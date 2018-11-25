from django.contrib import admin
from django.urls import path
from .views import login,sample_api,createAcc


urlpatterns = [
    path('api/createacc',createAcc),
    path('admin/', admin.site.urls),
    path('api/login', login),
    path('api/sampleapi', sample_api)
]