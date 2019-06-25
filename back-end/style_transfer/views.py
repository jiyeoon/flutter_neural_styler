from django.shortcuts import render
from rest_framework import viewsets
from django.http import HttpResponse

import numpy as np
import cv2
from PIL import Image
import style_transfer.style_transfer_model as style_net

# Create your views here.
from style_transfer.models import StyleTransferModel
from style_transfer.models import StyleTransferForm
from style_transfer.serializers import StyleTransferModelSerializer

def index(request):
    return 'request received'

class StyleTransferViewSet(viewsets.ModelViewSet):
    queryset=StyleTransferModel.objects.all()
    serializer_class=StyleTransferModelSerializer

def style_transfer_test_form(request):
    if request.method=='POST':
        form=StyleTransferForm(request.POST, request.FILES)
        if form.is_valid():
            print(form.cleaned_data)

            content_image=form.cleaned_data['content_image']
            content_weight=form.cleaned_data['content_weight']
            style_image=form.cleaned_data['style_image']
            style_weight=form.cleaned_data['style_weight']
            variation_weight=form.cleaned_data['variation_weight']
            learning_rate=form.cleaned_data['learning_rate']
            transfer_epoch=form.cleaned_data['transfer_epoch']

            if content_image!=None and style_image!=None:
                content_image=Image.open(content_image)
                #content_image=np.array(content_image)[:, :, ::-1]
                content_image=np.array(content_image)
                style_image=Image.open(style_image)
                #style_image=np.array(style_image)[:, :, ::-1]
                style_image=np.array(style_image)
                if content_weight==None:
                    content_weight=5.
                if style_weight==None:
                    style_weight=10000.
                if variation_weight==None:
                    variation_weight=0.001
                if learning_rate==None:
                    learning_rate=1.
                if transfer_epoch==None:
                    transfer_epoch=1000
                print(type(style_image))
                print(type(content_image))
                print(content_weight)
                print(style_weight)
                print(variation_weight)
                print(learning_rate)
                print(transfer_epoch)
                transfer_image=style_net.trans_image(content_image, style_image, content_weight, style_weight, variation_weight, learning_rate, transfer_epoch)
                #transfer_image=cv2.cvtColor(transfer_image, cv2.COLOR_BGR2RGB)
                transfer_image=Image.fromarray(transfer_image)
                response=HttpResponse(content_type='image/jpeg')
                transfer_image.save(response, 'JPEG')
                return response
                #return render(request, 'style_transfer/result.html', {
                #    'transfer_image':transfer_image
                #})
        else:
            print('invalid')
        return render(request, 'style_transfer/form.html', {})
    elif request.method=='GET':
        return render(request, 'style_transfer/form.html', {})
