#!/usr/bin/python3
import serial
import os

port = "/dev/ttyACM1"
serialRate = 115200

while True:
    try:
        serialport = serial.Serial(port, serialRate, timeout=0.5)
        break
    except:
        print("Could not open port %s, press CTRL+C to exit" % port)
        continue

while True:
        s = serialport.read()
        if s==b'\x01':
			#print("Oh no, bike looks like its being stolen, make HTTPrequest")
			os.system("/home/pi/bikebuddy/src/scripts/changeAPI_state.py")