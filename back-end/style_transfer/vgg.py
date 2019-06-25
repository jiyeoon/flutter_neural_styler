import scipy.io
import numpy as np
import tensorflow as tf
import os
from django.conf import settings
#from simple_server2.settings import STATICFILES_DIRS

#default_vgg_path='imagenet-vgg-verydeep-19.mat'
#default_vgg_path=os.path.join(settings.BASE_DIR, 'imagenet-vgg-verydeep-19.mat')
default_vgg_path=os.path.join(settings.BASE_DIR, 'static', 'imagenet-vgg-verydeep-19.mat')

vgg_layers=['conv1_1', 'relu1_1',
            'conv1_2', 'relu1_2', 'pool1',
            'conv2_1', 'relu2_1',
            'conv2_2', 'relu2_2', 'pool2',
            'conv3_1', 'relu3_1',
            'conv3_2', 'relu3_2',
            'conv3_3', 'relu3_3',
            'conv3_4', 'relu3_4', 'pool3',
            'conv4_1', 'relu4_1',
            'conv4_2', 'relu4_2',
            'conv4_3', 'relu4_3',
            'conv4_4', 'relu4_4', 'pool4',
            'conv5_1', 'relu5_1',
            'conv5_2', 'relu5_2',
            'conv5_3', 'relu5_3',
            'conv5_4', 'relu5_4']
def vgg_data_load(vgg_path=default_vgg_path):
    vgg_data = scipy.io.loadmat(vgg_path)
    normalization_matrix = vgg_data['normalization'][0][0][0]
    mat_mean = np.mean(normalization_matrix, axis=(0,1))
    network_weights = vgg_data['layers'][0]
    return mat_mean, network_weights

def vgg_network(network_weights, init_image):
    network={}
    image=init_image
    for i, layer in enumerate(vgg_layers):
        if layer[0]=='c':
            weights, bias=network_weights[i][0][0][0][0]
            weights=np.transpose(weights, (1, 0, 2, 3))
            bias=bias.reshape(-1)
            conv_layer=tf.nn.conv2d(image, tf.constant(weights), (1, 1, 1, 1), 'SAME')
            image=tf.nn.bias_add(conv_layer, bias)
        elif layer[0]=='r':
            image=tf.nn.relu(image)
        else:
            image=tf.nn.max_pool(image, (1, 2, 2, 1), (1, 2, 2, 1), 'SAME')
        network[layer]=image
    return network


