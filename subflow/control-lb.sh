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
SUBSET=(1 2 4 6 8 10)
EXP="sf-lb"

RSTART=151
REND=180

SSTART=111
SEND=140

sudo rm -rf /home/chix/nfs-share/sf-lb/*


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
		ssh -f -n root@192.168.100.$j "sysctl net.mptcp.mptcp_syn_retries=10"
	done


	#start from 0 array index
	for ((r=0; r<${#SUBSET[@]}; r++))
	do
		sudo mkdir /home/chix/nfs-share/sf-lb/${SUBSET[$r]}
		#lia
		echo "begin ${SUBSET[$r]}"
		for (( j=$[$SSTART]; j<=$SEND; j++ ))
		do
			ssh -f -n root@192.168.100.$j "echo ${SUBSET[$r]} > /sys/module/mptcp_fullmesh/parameters/num_subflows"
			ssh -f -n root@192.168.100.$j "/home/chix/experiments/opportunity/exp-client-lia 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARA $EXP/${SUBSET[$r]}" &
		done
		
		sleep $[$TIME+90]
		echo "end ${SUBSET[$r]}"
	done

exit
