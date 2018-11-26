from django.db import models
from django.contrib.auth.models import User
# Create your models here.

class Bike(models.Model):
    name = models.CharField(max_length = 100)
    locationLat = models.DecimalField(max_digits=20, decimal_places=4)
    locationLong = models.DecimalField(max_digits=20, decimal_places=4)
    state = models.CharField(max_length = 100)
    owner = models.ForeignKey(User,on_delete=models.CASCADE)

    def toDict(self):
        return ({
            "Name" : self.name,
            "LatLng": [self.locationLat,self.locationLong],
            "State": self.state,
        })
    
    def __str__(self):
        return self.name