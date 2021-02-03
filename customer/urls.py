from django.conf.urls import url

from . import views
from customer.views import *


urlpatterns = [
    url(r'^$', views.customer_login, name='login'),
    url(r'^logout$', views.customer_logout, name='logout'),
    url(r'^usermanagement', views.customermanagement, name='customermanagement'),
    url(r'^adduser', views.adduser, name='adduser'),
    url(r'^userlist', views.userlist, name='userlist'),
    url(r'^user_activate', views.user_activate, name='user_activate'),
    url(r'^profile', views.profile, name='profile'),

]