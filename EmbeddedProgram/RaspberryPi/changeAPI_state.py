#!/usr/bin/python
import requests

f = open("/home/pi/secret/secretToken.txt", "r")
mane = f.read()
print(mane)

URL1 = "https://bikebuddy.udana.systems/bikes"
headers1 = {"Authorization": "Token " + mane}

r1 = requests.get(URL1, headers=headers1)

returned = r1.json()
nameMane = returned["Bikes"][0]["Name"]
latMane = returned["Bikes"][0]["LatLng"][0]
lngMane = returned["Bikes"][0]["LatLng"][1]

URL = "https://bikebuddy.udana.systems/bikes/changeBike"
PARAM = {"Name":nameMane, "lat":latMane, "lng":lngMane, "state":"stolen"}
headers = {"Authorization": "Token " + mane}

r = requests.put(URL, json=PARAM, headers=headers)
print("Done")
