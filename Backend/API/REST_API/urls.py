from django.contrib import admin
from django.urls import path
from django.urls import re_path, include
from .views import getBikes, addBike, changeBike, deleteBike
urlpatterns = [
    re_path(r'addBike',addBike),
    re_path(r'changeBike',changeBike),
    re_path(r'deleteBike',deleteBike),
    re_path(r'',getBikes),
]