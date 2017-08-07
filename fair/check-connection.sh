##!/bin/sh
#comments

# Performing pair iperf transmission and return data result
# 
# Author: Charles Xu 
# Email: xuchi.int@gmail.com
# 
# 
#
#


CONTROL=""
TIME=60
PARA=100
EXP="in-enhance"

RSTART=151
REND=180

SSTART=111
SEND=140

sudo rm -rf /home/chix/nfs-share/$EXP/*


	#send file
	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "cat /etc/hostname " &
		sleep 1
	done
	
	for (( j=$SSTART; j<=$SEND; j++ ))
	do	
		ssh -f -n root@192.168.100.$j "cat /etc/hostname" &
		sleep 1
	done



exit
