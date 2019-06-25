from django.urls import path
import style_transfer.views as views

app_name='style_transfer'
urlpatterns=[
    path('', views.index, name='index'),
    path('form/', views.style_transfer_test_form, name='form'),

]

