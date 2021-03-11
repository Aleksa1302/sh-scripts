#!/bin/sh

# Author : Aleksandar Milisavljevic
# Copyright (c) eyecay.com
# cPanel DNS Only- LazyMode  
# cpdo.sh

IP=$(hostname -I)

echo "Check if your host name is good: $HOSTNAME Y/N "
read hostn

if [ $hostn == y ]
then
	yum update
	cd /home
	curl -o latest-dnsonly -L https://securedownloads.cpanel.net/latest-dnsonly
	sh latest-dnsonly 
	echo "Continue setup in WHM"
	echo "http://$IP:2086/"
else
   echo "After hostname change we will reboot server"
   echo "Enter Desired Hostname "
   read host
   hostnamectl set-hostname $host
   reboot
fi


