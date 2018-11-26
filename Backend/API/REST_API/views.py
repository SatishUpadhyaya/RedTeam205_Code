from django.shortcuts import render

# Create your views here.
from django.contrib.auth import authenticate
from django.views.decorators.csrf import csrf_exempt
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.status import (
    HTTP_400_BAD_REQUEST,
    HTTP_404_NOT_FOUND,
    HTTP_200_OK
)
from rest_framework.response import Response
from django.contrib.auth.models import User
from .models import Bike

@csrf_exempt
@api_view(["GET"])
def getBikes(request):
    user = getuser(request)
    bikes = [bike.toDict() for bike in user.bike_set.all()]
    return Response({"Bikes":bikes},
                status = HTTP_200_OK)

@csrf_exempt
@api_view(["POST"])
def addBike(request):
    user = getuser(request)

    bikename = request.data.get("Name")
    if not bikename:
        return Response({"Error":"Please Provide name of bike"},
                        status = HTTP_400_BAD_REQUEST)
    """
    name = models.CharField(max_length = 100)
    locationLat = models.DecimalField(max_digits=20, decimal_places=4)
    locationLong = models.DecimalField(max_digits=20, decimal_places=4)
    state = models.CharField(max_length = 100)
    owner = models.ForeignKey(User,on_delete=models.CASCADE)

    """
    bike = Bike(
        name = bikename,
        locationLat = -1.0,
        locationLong = -1.0,
        state = "Unknown",
        owner = user
    )
    bike.save()
    return Response({"Success":"Bike Added"},
                status = HTTP_200_OK)

@csrf_exempt
@api_view(["PUT"])
def changeBike(request):
    user = getuser(request)

    bikename = request.data.get("Name")
    if not bikename:
        return Response({"Error":"Please Provide name of bike"},
                        status = HTTP_400_BAD_REQUEST)
    
    try:
        bike = user.bike_set.all()[0]
    except:
        pass
    


    lat = request.data.get("lat")
    lng = request.data.get("lng")
    state = request.data.get("state")

    bike.locationLat = lat
    bike.state = state
    bike.locationLong = lng

    bike.save()
    return Response({"Success":"Bike info changed"},
                        status = HTTP_200_OK)

def getuser(request):
    tokenkey = request.META.get('HTTP_AUTHORIZATION')
    tokenarr = tokenkey.split(" ")
    tokenstr = tokenarr[1]
    tokenreal = Token.objects.filter(key = tokenstr)[0]
    user = tokenreal.user
    return user

@csrf_exempt
@api_view(["DELETE"])
def deleteBike(request):
    user = getuser(request)
    bike = user.bike_set.all()[0]
    bike.delete()
    return Response({"Success":"Bike Deleted"},
                        status=HTTP_200_OK)