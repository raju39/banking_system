from django.conf.urls import url

from . import views
from accounts.views import *


urlpatterns = [
    url(r'^deposit$', views.deposit_view, name='deposit_view'),
    url(r'^withdraw$', views.withdrawal_view, name='withdrawal_view'),
    url(r'^enquiry$', views.enquiry_view, name='enquiry_view'),
    url(r'^report$', views.report_view, name='report_view'),

]