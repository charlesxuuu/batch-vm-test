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
		ssh -f -n root@192.168.100.$i "cp -r /home/chix/nfs-share/experiments /home/chix/" &
		
	done
	
	for (( j=$SSTART; j<=$SEND; j++ ))
	do	
		ssh -f -n root@192.168.100.$j "cp -r /home/chix/nfs-share/experiments /home/chix/" &
	done

	echo "copy ok"
	sleep 5

	#start receiver
	for ((i=$RSTART; i<=$REND; i++))
	do
	ssh -f -n root@192.168.100.$i "/home/chix/experiments/opportunity/exp-server" &
	ssh -f -n root@192.168.100.$i "insmod /home/chix/mptcp_ecn.ko" &
	sleep 0.5
	done


	#set 
	for (( j=$SSTART; j<=$SEND; j++ ))
	do

	ssh -f -n root@192.168.100.$j "insmod /home/chix/mptcp_ecn.ko" &
	ssh -f -n root@192.168.100.$j "sysctl net.mptcp.mptcp_syn_retries=3" &
	ssh -f -n root@192.168.100.$j "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" &
	done

        for ((i=$RSTART; i<=$REND; i++))
        do
	ssh -f -n root@192.168.100.$i "sysctl net.ipv4.tcp_congestion_control=mptcp_ccc_ecn" &
	done
	
	#our
	echo "begin our"
	sudo mkdir /home/chix/nfs-share/$EXP/our	
	for (( j=$[$SSTART]; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "sysctl net.ipv4.tcp_ecn=1" &
		ssh -f -n root@192.168.100.$j "sysctl net.ipv4.tcp_congestion_control='mptcp_ccc_ecn'" &
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/opportunity/exp-client-our 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARA $EXP/our" &
	done
	echo "end our"
exit
