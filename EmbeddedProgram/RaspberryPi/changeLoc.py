#!/usr/bin/python
import serial
import time
import json
import requests
import random

def parser(GPRMC):
    try:
        rawList = GPRMC.split(',')

        latBearing = rawList[4]
        longBearing = rawList[6]

        rawLat = rawList[3]
        rawLong = rawList[5]

        longt = str(float(rawLong)/100)
        lat = str(float(rawLat)/100)

        if 'W' in rawList:
            longt = str(float(longt)*-1)
        if 'S' in rawList:
            lat = str(float(lat)*-1)
        longtarr = longt.split('.')
        latarr = lat.split('.')

        latdeg = latarr[0]
        longtdeg = longtarr[0]

        latmin = "0." + latarr[1]
        longtmin = "0." + longtarr[1]

        latmin = str((float(latmin)*100)/60)
        longtmin = str((float(longtmin)*100)/60)

        if 'S' in rawList:
            lat =str(float(latdeg) + float(latmin)*-1)
        else:
            lat =str(float(latdeg) + float(latmin))

        if 'W' in rawList:
            longt = str(float(longtdeg) + float(longtmin)*-1)
        else:
            longt = str(float(longtdeg) + float(longtmin))

        retTuple = (float(lat) , float(longt))
        return retTuple
    except:
        print("Something went wrong!")
        return (-1.0,-1.0)


tupleMane = (0,0)
ser = serial.Serial('/dev/serial0', 9600,timeout = 1)
serial_line = ""
while "$GPRMC" not in str(serial_line):
	try:
        	serial_line = ser.readline()
	except:
        	ser.close()
        	ser = serial.Serial('/dev/serial0', 9600, timeout = 1)
        	continue

	if("$GPRMC" in str(serial_line)):
		serial_line = serial_line.decode("utf-8")
		serial_line = str(serial_line)
		print(serial_line)
		tupleMane = parser(serial_line)
		print(tupleMane)
		break
ser.close()



f = open("/home/pi/secret/secretToken.txt", "r")
mane = f.read()
print(mane)

URL1 = "https://bikebuddy.udana.systems/bikes"
headers1 = {"Authorization": "Token " + mane}

r1 = requests.get(URL1, headers=headers1)

returned = r1.json()
nameMane = returned["Bikes"][0]["Name"]
stateMane = returned["Bikes"][0]["State"]
print("Location posted")

URL = "https://bikebuddy.udana.systems/bikes/changeBike"
PARAM = {"Name":nameMane, "lat":tupleMane[0], "lng":tupleMane[1], "state":stateMane}
headers = {"Authorization": "Token " + mane}

r = requests.put(URL, json=PARAM, headers=headers)
