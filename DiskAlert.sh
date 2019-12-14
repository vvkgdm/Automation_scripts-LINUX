#!/bin/bash
trigger=90
#diskuse=`df -h | grep dev | awk {'print $5'} | sed 's/[^0-9]*//g'`
diskuse=`df -h | grep dev | awk {'print $5'} | sed 's/[^0-9]*//g' | cut -d "0" -f 1`
disk=`df -h | grep dev | awk {'print $5'}`
ip=`ifconfig | grep 192.168 | awk {'print $2'}`

response=`echo | awk -v T=$trigger -v L=$diskuse 'BEGIN{if ( L > T){ print "greater"}}'`
if [[ $response = "greater" ]]
then
echo "Subject: SYNC3 Server Disk Space Critical $disk " | cat - /home/ashok/mm.txt | /usr/lib/sendmail -f ashok.pilla@spoors.in -t ashok.pilla@spoors.in bala.balam@spoors.in vijay@spoors.in nikhita.duppalli@spoors.in 

fi
