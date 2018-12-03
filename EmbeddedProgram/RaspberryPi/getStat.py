#!/usr/bin/python
import requests
import os

f = open("/home/pi/secret/secretToken.txt", "r")
mane = f.read()
print(mane)

URL1 = "https://bikebuddy.udana.systems/bikes"
headers1 = {"Authorization": "Token " + mane}

r1 = requests.get(URL1, headers=headers1)

returned = r1.json()
stateMane = returned["Bikes"][0]["State"]
print(stateMane)

if(stateMane == "armed"):
	os.system("/home/pi/bikebuddy/src/scripts/turnon.py")
	os.system("/home/pi/bikebuddy/src/scripts/testscript.py")
elif(stateMane == "disarmed"):
	os.system("/home/pi/bikebuddy/src/scripts/turnoff.py")
