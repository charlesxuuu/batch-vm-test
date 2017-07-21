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
TIME=20
PARALLEL=100
EXP="op-lb"
ROUND=1

RSTART=151
REND=180

SSTART=111
SEND=140

sudo rm -rf /home/chix/nfs-share/op-lb/*

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
		ssh -f -n root@192.168.100.$i "/home/chix/experiments/opportunity/exp-server" &
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
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/opportunity/exp-client-cubic 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARALLEL $EXP" &
	done
	
	sleep $[$TIME+30]





	for (( j=$SSTART; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "sysctl net.mptcp.mptcp_syn_retries=10"
	done
	



	#lia
	echo "begin"
	for (( j=$[$SSTART]; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/opportunity/exp-client-lia 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARALLEL $EXP" &
	done
	
	sleep $[$TIME+30]



exit
