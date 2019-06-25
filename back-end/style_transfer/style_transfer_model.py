import os
import numpy as np
import tensorflow as tf
from tensorflow.python.framework import ops
import style_transfer.vgg as vgg
import cv2

#os.environ['TF_CPP_MIN_LOG_LEVEL'] = '1'
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

class StyleTransfer():
    def __init__(self, content_image, style_image, initial_image,
                 content_feature_layers, style_feature_layers,
                 content_weight=0.1, style_weight=1., variation_weight=0.1,
                 learning_rate=0.1):
        self.content_image=content_image
        self.content_shape=(1, )+content_image.shape
        self.style_image=style_image
        self.style_shape=(1, )+style_image.shape
        self.initial_image=initial_image
        self.initial_shape=(1, )+initial_image.shape
        
        self.content_features={}
        self.style_features={}
        
        self.normalization_mean, self.network_weights=vgg.vgg_data_load()

        self.restore=False
        
        content_graph=tf.Graph()
        with content_graph.as_default():
            sess=tf.Session()
            image=tf.placeholder(tf.float32, shape=self.content_shape)
            vgg_network=vgg.vgg_network(self.network_weights, image)
            content_mean=np.array([self.content_image-self.normalization_mean])
            for layer in content_feature_layers:
                self.content_features[layer]=sess.run(vgg_network[layer], feed_dict={image:content_mean})
                
        style_graph=tf.Graph()
        with style_graph.as_default():
            sess=tf.Session()
            image=tf.placeholder(tf.float32, shape=self.style_shape)
            vgg_network=vgg.vgg_network(self.network_weights, image)
            style_mean=np.array([self.style_image-self.normalization_mean])
            for layer in style_feature_layers:
                features=vgg_network[layer]
                _, height, width, channels=[x.value for x in features.get_shape()]
                features=tf.reshape(features, (-1, features.shape[3]))
                gram=tf.matmul(tf.transpose(features), features)/(height*width*channels*2.)
                #gram=tf.matmul(tf.transpose(features), features)/(height*width*channels)
                self.style_features[layer]=sess.run(gram, feed_dict={image:style_mean})
                
        self.target_graph=tf.Graph()
        with self.target_graph.as_default():
            sess=tf.Session()
            initial_mean=np.array([self.initial_image-self.normalization_mean])
            self.image=tf.Variable(initial_mean, dtype=tf.float32)
            vgg_network=vgg.vgg_network(self.network_weights, self.image)
            
            self.content_loss=0
            for content_layer in content_feature_layers:
                temp_content_loss=tf.nn.l2_loss(vgg_network[content_layer]-self.content_features[content_layer])/2.    #방법 1 오리지널 논문에 가까움
                self.content_loss+=temp_content_loss*content_feature_layers[content_layer]
                #temp_content_loss=tf.nn.l2_loss(vgg_network[content_layer]-self.content_features[content_layer])*2.
                #self.content_loss+=temp_content_loss*content_feature_layers[content_layer]/self.content_features[content_layer].size

            self.style_loss=0
            for style_layer in style_feature_layers:
                features=vgg_network[style_layer]
                _, height, width, channels=[x.value for x in features.get_shape()]
                features=tf.reshape(features, (-1, features.shape[3]))
                gram=tf.matmul(tf.transpose(features), features)/(height*width*channels*2.)
                #gram=tf.matmul(tf.transpose(features), features)/(height*width*channels)
                temp_style_loss=tf.nn.l2_loss((gram-self.style_features[style_layer]))
                self.style_loss+=temp_style_loss*style_feature_layers[style_layer]
                #temp_style_loss=tf.nn.l2_loss((gram-self.style_features[style_layer]))*2.
                #self.style_loss+=temp_style_loss*style_feature_layers[style_layer]/self.style_features[style_layer].size

            self.variation_loss=tf.reduce_sum(tf.image.total_variation(self.image))

            self.total_loss=content_weight*self.content_loss+style_weight*self.style_loss+variation_weight*self.variation_loss
            
            optimizer=tf.train.AdamOptimizer(learning_rate)
            self.train_step=optimizer.minimize(self.total_loss)
            
        #tf.summary.FileWriter('tensorboard', self.target_graph)
    
    def training_model(self, generations, output_generations, save_generations,
                       output_path, save_path, log_path,
                       last_generation=0):
        with self.target_graph.as_default():
            if not self.restore:
                self.sess=tf.Session()
            init=tf.global_variables_initializer()
            self.sess.run(init)

            saver=tf.train.Saver()

            print('training start')
            
            for i in range(generations):
                self.sess.run(self.train_step)

                if (i+1)%output_generations==0:
                    f=open(log_path, "a")
                    print('Generation {}, loss: {}'.format(i+1, self.sess.run(self.total_loss)))
                    log_output=self.sess.run([self.total_loss, self.content_loss, self.style_loss, self.variation_loss])
                    f.write('Generation {}, total loss: {}, content loss: {}, style loss: {}, variation loss: {}\n'.format(i+1, *log_output))
                    f.close()
                    squeeze_image=tf.cast(tf.squeeze(self.image)+self.normalization_mean, tf.uint8)
                    output_image=self.sess.run(squeeze_image)
                    cv2.imwrite("{}_{}.jpg".format(output_path, i+1), output_image)

                if (i+1)%save_generations==0:
                    print('saving start')
                    saver.save(self.sess, save_path, global_step=(i+1+last_generation))

    def training_model_l_bfgs(self, generations, output_generations):
        with self.target_graph.as_default():
            if not self.restore:
                self.sess=tf.Session()
            init=tf.global_variables_initializer()
            self.sess.run(init)
            optimizer = tf.contrib.opt.ScipyOptimizerInterface(self.total_loss, method='L-BFGS-B', options={'maxiter': generations, 'disp': output_generations})
            optimizer.minimize(self.sess)

    def restore_model(self, save_path):
        with self.target_graph.as_default():
            self.sess=tf.Session()
            self.restore=True
            saver=tf.train.Saver()
            saver.restore(sess, save_path)

    def get_image(self):
        with self.target_graph.as_default():
            squeeze_image=tf.cast(tf.squeeze(self.image)+self.normalization_mean, tf.uint8)
            output_image=self.sess.run(squeeze_image)
            return output_image

def trans_image(content_image, style_image, content_weight=5.0, style_weight=10000., variation_weight=0.001,
                learning_rate=1., epoch=1000,):
    content_feature_layers={'relu4_2':0.5, 
                            'relu5_2':0.5}
    style_feature_layers={'relu1_1':0.2,
                          'relu2_1':0.2, 
                          'relu3_1':0.2, 
                          'relu4_1':0.2, 
                          'relu5_1':0.2}
    style_transfer_model=StyleTransfer(content_image, style_image, content_image, content_feature_layers, style_feature_layers,
                                       content_weight=content_weight, style_weight=style_weight, variation_weight=variation_weight, 
                                       learning_rate=learning_rate)
    style_transfer_model.training_model_l_bfgs(epoch, epoch//20)
    return style_transfer_model.get_image()