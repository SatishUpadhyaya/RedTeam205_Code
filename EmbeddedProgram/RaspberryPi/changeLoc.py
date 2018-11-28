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
stateMane = returned["Bikes"][0]["State"]
print(stateMane)

URL = "https://bikebuddy.udana.systems/bikes/changeBike"
PARAM = {"Name":nameMane, "lat":2.0, "lng":2.2, "state":stateMane}
headers = {"Authorization": "Token " + mane}

r = requests.put(URL, json=PARAM, headers=headers)