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
set -x

CONTROL=""
TIME=30
PARA=100
EXP="fair"

RSTART=151
REND=162

SSTART=111
SEND=122

ROUND=1

#protm1=(cu cu cu ce de de de de)
#protm2=(lu wu wu be le oe we be)
#protm3=(ou bu wu be le oe we be)
#protm4=(du iu cu ce de de de de)

protm1=(cu lu)
protm2=(lu wu)
protm3=(lu ou)
protm4=(cu bu)


function checkcc()
{
        #echo $1 #round
        #echo $2 #machine
        #echo $3 #rewrite the return string
        if [ $2 -ge 111 -a $2 -lt 114 ]; then
                eval "$3='${protm1[$1]}'"
                return
        fi

        if [ $2 -ge 114 -a $2 -lt 117 ]; then
                eval "$3='${protm2[$1]}'"
                return
        fi

        if [ $2 -ge 117 -a $2 -lt 120 ]; then
                eval "$3='${protm3[$1]}'"
                return
        fi

        if [ $2 -ge 120 -a $2 -lt 123 ]; then
                eval "$3='${protm4[$1]}'"
                return
        fi
}


if [ ! -d "/home/chix/nfs-share/$EXP" ]; then
	  mkdir -p /home/chix/nfs-share/$EXP
fi
sudo rm -rf /home/chix/nfs-share/$EXP/*


for ((r=0; r<=$ROUND; r++))
do

	if [ ! -d "/home/chix/nfs-share/$EXP/$r" ]; then
  		sudo mkdir -p /home/chix/nfs-share/$EXP/$r
	fi

	sudo rm -rf /home/chix/nfs-share/$EXP/$r/*

	#start vm
	#crazy: first let us kill all vm

	sudo pkill qemu 
	ssh -f -n root@192.168.1.59 "pkill qemu"

	sleep 5

	#then start
	echo "starting vm"
	bash start-vm-on-two-host.sh
	sleep 60

	#send file
	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "cp -r /home/chix/nfs-share/experiments /home/chix/"
		sleep 0.5
		ssh -f -n root@192.168.100.$i "bash /root/in-vm-network-tuning.sh > /dev/null" 
	done
	
	for ((j=$SSTART; j<=$SEND; j++))
	do	
		ssh -f -n root@192.168.100.$j "cp -r /home/chix/nfs-share/experiments /home/chix/"
		sleep 0.5
		ssh -f -n root@192.168.100.$j "bash /root/in-vm-network-tuning.sh > /dev/null" 
	done

	sleep 5

	#change cc
		#protm1 3 machin
		for ((i=$RSTART; i<=$[$RSTART+2]; i++))
		do
			bash /home/chix/nfs-share/experiments/fair/change-cc.sh $i $[$i-40] ${protm1[$r]} 
		done
		#protm2 3 machine
		for ((i=$[$RSTART+3]; i<=$[$RSTART+5]; i++))
		do
			bash /home/chix/nfs-share/experiments/fair/change-cc.sh $i $[$i-40] ${protm2[$r]} 
		done
		#protm3 3 machine
		for ((i=$[$RSTART+6]; i<=$[$RSTART+8]; i++))
		do
			bash /home/chix/nfs-share/experiments/fair/change-cc.sh $i $[$i-40] ${protm3[$r]} 
		done
		#protm4 3 machine
		for ((i=$[$RSTART+9]; i<=$[$RSTART+11]; i++))
		do
			bash /home/chix/nfs-share/experiments/fair/change-cc.sh $i $[$i-40] ${protm4[$r]} 
		done

	#start receiver
	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "/home/chix/experiments/fair/exp-server" 
	done
	
	echo "receiver ok sleep 5s"
	sleep 5

	echo "begin"

	for ((j=$SSTART; j<=$SEND; j++))
	do
		cc=''
		checkcc $r $j cc
		if [ $j -le $[$SSTART+6] ]; 
		then 
			ssh -f -n root@192.168.100.$j "/home/chix/experiments/fair/exp-client 192.168.100.$j 192.168.100.$[$j+40] $TIME $PARA $EXP $r $cc" &
		else 
			ssh -f -n root@192.168.101.$j "/home/chix/experiments/fair/exp-client 192.168.101.$j 192.168.101.$[$j+40] $TIME $PARA $EXP $r $cc" &
		fi
	done
		
	sleep $[$TIME+30]

	#close and clean

	for ((j=$SSTART; j<=$SEND; j++))
	do
		ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$j "sudo pkill iperf" &
	done

	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$i "sudo pkill iperf" &
		ssh -f -n root@192.168.100.$i "sudo pkill iperf" &
	done

	#shutdown vm

	for ((j=$SSTART; j<=$SEND; j++))
	do
		ssh -f -n root@192.168.100.$j "shutdown -h now"
	done

	for ((i=$RSTART; i<=$REND; i++))
	do
		ssh -f -n root@192.168.100.$i "shutdown -h now" 
	done
	sleep 15
	
	echo "end round $r"

done
