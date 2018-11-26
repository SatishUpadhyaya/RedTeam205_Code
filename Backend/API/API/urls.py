from django.contrib import admin
from django.urls import path
from .views import login,createAcc
from django.urls import re_path, include
urlpatterns = [
    path('api/createacc',createAcc),
    path('admin/', admin.site.urls),
    path('api/login', login),
    re_path(r"^bikes/",include('REST_API.urls'))
]