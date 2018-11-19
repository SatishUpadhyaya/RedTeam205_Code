from django.db import models

# Create your models here.
class UserAccount(models.Model):
    username = models.CharField(max_length = 100)
    password = models.CharField(max_length = 100)

class Bike(models.Model):
    name = models.CharField(max_length = 100)
    locationLat = models.DecimalField(max_digits=20, decimal_places=4)
    locationLong = models.DecimalField(max_digits=20, decimal_places=4)
    state = models.CharField(max_length = 100)
    owner = models.ForeignKey(UserAccount,on_delete=models.CASCADE)