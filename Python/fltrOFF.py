#!/usr/bin/python
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)

GPIO.setup(3, GPIO.OUT)
GPIO.output(3, GPIO.HIGH)