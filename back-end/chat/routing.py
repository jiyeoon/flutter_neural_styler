from django.conf.urls import url
from chat import consumers

websocket_urlpatterns=[
    url(r'^ws/chat/(?P<room_name>[^/]+)/$', consumers.ChatConsumer),
]
