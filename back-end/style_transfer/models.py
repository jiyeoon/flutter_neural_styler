from django.db import models
from django.forms import ModelForm

# Create your models here.

class StyleTransferModel(models.Model):
    id=models.CharField(max_length=30, primary_key=True)
    id_number=models.CharField(max_length=30, blank=True)

    content_image=models.ImageField(blank=True, null=True)
    content_weight=models.FloatField(blank=True, null=True)

    style_image=models.ImageField(blank=True, null=True)
    style_weight=models.FloatField(blank=True, null=True)

    variation_weight=models.FloatField(blank=True, null=True)

    learning_rate=models.FloatField(blank=True, null=True)

    transfer_epoch=models.IntegerField(blank=True, null=True)
    transfer_image=models.ImageField(blank=True, null=True)

class StyleTransferForm(ModelForm):
    class Meta:
        model=StyleTransferModel
        fields='__all__'

