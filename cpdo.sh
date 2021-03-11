#!/bin/sh

# Author : Aleksandar Milisavljevic
# Copyright (c) eyecay.com
# cPanel DNS Only- LazyMode  
# cpdo.sh

echo "Check if your host name is valid: $HOSTNAME Y/N "
# User Response
read hostn


if [ $hostn == y ]
then
	# System Update
	yum update
	# Change of Directory
	cd /home
	# Download Latest Version of cPanle-DNS Only
	curl -o latest-dnsonly -L https://securedownloads.cpanel.net/latest-dnsonly
	# Start Installation
	sh latest-dnsonly 
	# Finish 
	echo "Continue setup in WHM"
	echo "http://$HOSTNAME:2086/"
	# Removing Script from System
	rm cpdo.sh
	# Terminate our shell script with success message
	exit 0
	
else
   # hostname update in case that hostname is not in required format ns.example.com
   echo "After hostname change we will reboot server and you will have to re run script "
   echo "Enter desired Hostname?"
   read host
   hostnamectl set-hostname $host
   reboot
fi
