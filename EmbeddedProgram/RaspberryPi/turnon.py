#!/usr/bin/python
import serial
import time
x = serial.Serial("/dev/ttyACM1", 115200)
time.sleep(2)
#x.write(b'\x32')
#for _ in range(2):
x.write('1')
x.close()