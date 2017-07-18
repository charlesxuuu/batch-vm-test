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
TIME=10
PARALLEL=1
EXP="ovs-nodpdk"
ROUND=1

RSTART=151
REND=151

SSTART=111
SEND=111



	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "cp -r /home/chix/nfs-share/experiments /home/chix/experiments"
	done
	
	for (( j=$SSTART; j<=$SEND; j++ ))
	do	
		ssh -f -n root@192.168.100.$j "cp -r /home/chix/nfs-share/experiments /home/chix/experiments"
	done



	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "/home/chix/experiments/exp-server" &
	done
	
	echo "receiver ok sleep 5s"
	sleep 5

	for ((r=1; r<=$ROUND; r++))
	do
		for (( j=$SSTART; j<=$SEND; j++ ))
		do
			ssh -f -n root@192.168.100.$j "cp -r /home/chix/nfs-share/experiments /home/chix/experiments"
			ssh -f -n root@192.168.100.$j "/home/chix/experiments/exp-client 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARALLEL $EXP" &
		done
	done

exit
