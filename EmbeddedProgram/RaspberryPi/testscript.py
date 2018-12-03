#!/usr/bin/python3
import serial
import os
import time

port = "/dev/ttyACM0"
serialRate = 115200

while True:
	try:
		serialport = serial.Serial(port, serialRate, timeout=0.5)
		break
	except:
		print("Could not open port %s, press CTRL+C to exit" % port)
		continue

i = 0
while i < 100:
	time.sleep(0.2)
	s = serialport.read()
	if s==b'\x01':
		print("Oh no, bike looks like its being stolen, make HTTPrequest")
		os.system("/home/pi/bikebuddy/src/scripts/changeAPI_state.py")
		break
	i += 1
