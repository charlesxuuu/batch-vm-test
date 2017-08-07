##!/bin/sh
#comments

# kill iperf transmission 
# 
# Author: Charles Xu 
# Email: xuchi.int@gmail.com
# 
# 
#
#


SSTART=111
SEND=140

	for (( j=$SSTART; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
	done
	
	

RSTART=151
REND=180

	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "sudo pkill iperf" &
	done
	
exit
