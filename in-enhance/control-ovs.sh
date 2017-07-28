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
PARA=1000
EXP="in-enhance"

RSTART=151
REND=154

SSTART=111
SEND=114

sudo rm -rf /home/chix/nfs-share/$EXP/*


	#send file
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

	#start receiver
	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "/home/chix/experiments/opportunity/exp-server" &
		ssh -f -n root@192.168.100.$i "sysctl net.ipv4.tcp_congestion_control=lia" &
	done

	
	echo "receiver ok sleep 5s"
	sleep 5

	#set 
	for (( j=$SSTART; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "sysctl net.mptcp.mptcp_syn_retries=3"
		ssh -f -n root@192.168.100.$j "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows"
	done

	

	#lia
	echo "begin lia"
	sudo mkdir /home/chix/nfs-share/$EXP/lia
	for (( j=$[$SSTART]; j<=$SEND; j++ ))
	do
		ssh -f -n root@192.168.100.$j "sysctl net.ipv4.tcp_ecn=2"
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/opportunity/exp-client-lia 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARA $EXP/lia" &
	done
		
	sleep $[$TIME+20]
	echo "end lia"



	for ((t = 1; t <=5; t++))
	do
        	for (( j=$SSTART; j<=$SEND; j++ ))
        	do
                	ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
        	done
		sleep 3
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
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/opportunity/exp-client-our 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARA $EXP/our" &
	done
		
	echo "end our"


exit
