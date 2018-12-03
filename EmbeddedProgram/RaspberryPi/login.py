#!/usr/bin/python
import requests
import json

with open("/home/pi/secret/secret.txt", "r") as file:
	x = file.read()

	buf = x.split("\n")
	global usrName
	global pswd
	usrName = buf[0]
	pswd = buf[1]
print(usrName)
print(pswd)

URL = "https://bikebuddy.udana.systems/api/login"
PARAMS = {"username":usrName, "password":pswd}
r = requests.post(URL, json=PARAMS)

print(r.json())

data = r.json()
f = open("/home/pi/secret/secretToken.txt", "w")
f.write(data["token"])