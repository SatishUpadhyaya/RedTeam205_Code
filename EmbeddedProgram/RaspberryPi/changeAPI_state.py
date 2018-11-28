#!/usr/bin/python
import requests

f = open("/home/pi/secret/secretToken.txt", "r")
mane = f.read()
print(mane)

URL = "https://bikebuddy.udana.systems/bikes/changeBike"
PARAM = {"Name":"dog", "lat":2.0, "lng":2.2, "state":"stolen"}
headers = {"Authorization": "Token " + mane}

r = requests.put(URL, json=PARAM, headers=headers)