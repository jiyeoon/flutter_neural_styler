from style_transfer.models import StyleTransferModel
from rest_framework import serializers

class StyleTransferModelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model=StyleTransferModel
        #fields=('id', 'content_image', 'content_weight', 'style_image', 'style_weight', 'transfer_epoch', 'transfer_image')
        fields='__all__'
