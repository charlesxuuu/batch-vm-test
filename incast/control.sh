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
PARASET=(10 50 100 150 200 250)
EXP="ch-lb"

RSTART=151
REND=180

SSTART=111
SEND=140

sudo rm -rf /home/chix/nfs-share/ch-lb/*


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
	for ((r=0; r<${#PARASET[@]}; r++))
	do
		sudo mkdir /home/chix/nfs-share/ch-lb/${PARASET[$r]}
		#lia
		echo "begin ${PARASET[$r]}"
		for (( j=$[$SSTART]; j<=$SEND; j++ ))
		do
			ssh -f -n root@192.168.100.$j "/home/chix/experiments/opportunity/exp-client-lia 192.168.100.$j 192.168.100.$[$j+40] $TIME ${PARASET[$r]} $EXP/${PARASET[$r]}" &
		done
		
		sleep $[$TIME+90]
		echo "end ${PARASET[$r]}"
	done

exit
