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
EXP="fair"

RSTART=151
REND=162

SSTART=111
SEND=122


protm1=(cu cu cu ce de de de de)
protm2=(lu wu wu be le oe we be)
protm3=(ou bu wu be le oe we be)
protm4=(du iu cu ce de de de de)

#protm1=(l)
#protm2=(l)
#protm3=(l)
#protm4=(l)

if [ ! -d "/home/chix/nfs-share/$EXP" ]; then
	  mkdir -p /home/chix/nfs-share/$EXP
fi
sudo rm -rf /home/chix/nfs-share/$EXP/*


#send file
for ((i=$RSTART; i<=$REND; i++))
do
	ssh -f -n root@192.168.100.$i "cp -r /home/chix/nfs-share/experiments /home/chix/"	
	ssh -f -n root@192.168.100.$i "bash /root/in-vm-network-tuning.sh" 
done
	
for (( j=$SSTART; j<=$SEND; j++))
do	
	ssh -f -n root@192.168.100.$j "cp -r /home/chix/nfs-share/experiments /home/chix/"
	ssh -f -n root@192.168.100.$j "bash /root/in-vm-network-tuning.sh" 
done

echo "copy ok"
sleep 5


for ((r=0; r<=$ROUND; r++))
do

	if [ ! -d "/home/chix/nfs-share/$EXP/$r" ]; then
  		sudo mkdir -p /home/chix/nfs-share/$EXP/$r
	fi

	sudo rm -rf /home/chix/nfs-share/$EXP/$r/*

	#clean previous iperf
	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$i "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$i "sudo pkill iperf" &
	done

	for ((j=$SSTART; j<=$SEND; j++))
	do
		ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
	done

	#change cc
		#protm1 3 machin
		for ((i=$RSTART; i<=$[$RSTART+2]; i++))
		do
			bash /home/chix/nfs-sahre/experiments/fair/chang-cc.sh $i $[$i-40] ${protm1[$r]} &
		done
		#protm2 3 machine
		for ((i=$[$RSTART+3]; i<=$[$RSTART+5]; i++))
		do
			bash /home/chix/nfs-sahre/experiments/fair/chang-cc.sh $i $[$i-40] ${protm2[$r]} &
		done
		#protm3 3 machine
		for ((i=$[$RSTART+6]; i<=$[$RSTART+8]; i++))
		do
			bash /home/chix/nfs-sahre/experiments/fair/chang-cc.sh $i $[$i-40] ${protm3[$r]} &
		done
		#protm4 3 machine
		for ((i=$[$RSTART+9]; i<=$[$RSTART+11]; i++))
		do
			bash /home/chix/nfs-sahre/experiments/fair/chang-cc.sh $i $[$i-40] ${protm4[$r]} &
		done

	#start receiver
	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "/home/chix/experiments/fair/exp-server" &
	done

	
	echo "receiver ok sleep 5s"
	sleep 5

	echo "begin"

	for ((j=$[$SSTART]; j<=$SEND; j++))
	do
		ssh -f -n root@192.168.100.$j "/home/chix/experiments/fair/exp-client 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARA $EXP/$r" &
	done
		
	sleep $[$TIME+20]
	echo "end round $r"

done

exit
