"""simple_server2 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls import url
from django.conf.urls.static import static
from rest_framework import routers

from style_transfer import views

router=routers.DefaultRouter()  #restful setting
router.register(r'style_transfers', views.StyleTransferViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    url(r'^', include(router.urls)),    #restful urls
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')), #restful urls
    path('style_transfer/', include('style_transfer.urls')),    #style_transfer urls
    url(r'^chat/', include('chat.urls'))    #web socket urls
]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) #image database
