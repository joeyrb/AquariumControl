#!/usr/bin/python
# Backup for pwrOFF.py
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

# init list with pin numbers

pinList = [2, 3, 17, 27]

# loop through pins and set mode and state to 'high'

for i in pinList:
	GPIO.setup(i, GPIO.OUT)
	GPIO.output(i, GPIO.HIGH)

# time to sleep between operations in the main loop

# SleepTimeL = 1

# main loop
try:
	 GPIO.output(2, GPIO.LOW)
	# print "ONE"
	# time.sleep(SleepTimeL);
	# GPIO.output(3,GPIO.LOW)
	# print "TWO"
	# time.sleep(SleepTimeL);
	# GPIO.output(17, GPIO.LOW)
	# print "THREE"
	# time.sleep(SleepTimeL);
	# GPIO.output(27, GPIO.LOW)
	# print "FOUR"
	# time.sleep(SleepTimeL);
	GPIO.cleanup()
	# print "Power off!"

# end program cleanly with keyboard
except KeyboardInterrupt:
	# print "	Quit"
	# Reset GPIO settings
	GPIO.cleanup()
