#!/usr/bin/python
# constantly check the state of the bike
# if the bike moves, change the state

# getStat.py arms/disarms the bike depending on the state in the API
# and if the bike is in armed state: calls testscript.py which calls changeAPIstate.py
# which change the state to stolen if the bike is moved
# we need to update the location all the time: even when it is not armed
import os

while True:
	os.system("/home/pi/bikebuddy/src/scripts/getStat.py")
	os.system("/home/pi/bikebuddy/src/scripts/changeLoc.py")
