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
TIME=100
PARALLEL=1
EXP="shift-one"
ROUND=1

RSTART=151
REND=151

SSTART=111
SEND=111



	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "cp -r /home/chix/nfs-share/experiments /home/chix/"
	done
	
	for (( j=$SSTART; j<=$SEND; j++ ))
	do	
		ssh -f -n root@192.168.100.$j "cp -r /home/chix/nfs-share/experiments /home/chix/"
	done

	echo "copy ok"
	sleep 5

	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "/home/chix/experiments/shift/exp-server" &
	done

	
	echo "receiver ok sleep 5s"
	sleep 5


	for (( j=$SSTART; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "sysctl net.ipv4.tcp_syn_retries=10"
	done

	#tcp-cubic	
	echo "begin"
	for (( j=$[$SSTART]; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/shift/exp-client-cubic-full 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARALLEL $EXP" &
	done
	
	sleep 15

	for ((t = 1; t <= 6; t++))
	do
		iperf -u -c 192.168.100.103 -b 500M -t 5 > /dev/null &
		sleep 15
	done

	sleep 10


	for (( j=$SSTART; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "sysctl net.mptcp.mptcp_syn_retries=10"
	done
	



	#lia
	echo "begin"
	for (( j=$[$SSTART]; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/shift/exp-client-lia-full 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARALLEL $EXP" &
	done
	
	sleep 15

	for ((t = 1; t <= 6; t++))
	do
		iperf -u -c 192.168.100.103 -b 500M -t 5 > /dev/null &
		sleep 15
	done

	sleep 10


exit
