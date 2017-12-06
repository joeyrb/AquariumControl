# file: rfcomm-server.py
# auth: Albert Huang <albert@csail.mit.edu>
# desc: simple demonstration of a server application that uses RFCOMM sockets
#
# $Id: rfcomm-server.py 518 2007-08-10 07:20:07Z albert $

import time
import RPi.GPIO as GPIO
from bluetooth import *

GPIO.setmode(GPIO.BCM)
GPIO.setup(17, GPIO.OUT)

def light_on():
	GPIO.output(17, True)
	print "light on!"

def light_off():
	GPIO.output(17, False)
	print "light off!"

server_sock=BluetoothSocket( RFCOMM )
server_sock.bind(("",PORT_ANY))
server_sock.listen(1)

port = server_sock.getsockname()[1]

uuid = "94f39d29-7d6d-437d-973b-fba39e49d4ee"

advertise_service( server_sock, "SampleServer",
                   service_id = uuid,
                   service_classes = [ uuid, SERIAL_PORT_CLASS ],
                   profiles = [ SERIAL_PORT_PROFILE ], 
#                   protocols = [ OBEX_UUID ] 
                    )
                   
print "Waiting for connection on RFCOMM channel %d" % port

client_sock, client_info = server_sock.accept()
print "Accepted connection from ", client_info

try:
    while True:
        data = client_sock.recv(1024)
        if len(data) == 0: break
        print "received [%s]" % data
	
	if data == 'lightOn':
		light_on()
			
	elif data == 'lightOff':
#		GPIO.output(17, False)
#		print "light off!"
		light_off()
			
	elif data == 'quit':
		break
			
	else:
		print "try again idiot"
		
except IOError:
    pass

print "disconnected"

client_sock.close()
server_sock.close()
print "all done"
