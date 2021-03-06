#!/bin/bash
#change congestion control settings
#$1 first argument  sender-ip  2digits 192.168.100.1XX
#$2 second argument receiver-ip 2digits 192.168.100.1XX
#$3 third argument cc  congestion algorithm
#use as "bash chang-cc.sh 11 51 cubic"

#index: cubic(cu) cubic-ecn(ce) dctcp(de) reno(ru) reno-ecn(re) vegas(vn) vegas-ecn(ve)
#       lia(lu) lia-ecn(le) olia(ou) olia-ecn(oe) balia(bu) balia-ecn(be) wvegas(wu) wvegas-ecn(we) our(ee)



ip1="192.168.100.$1"
echo $ip1
ip2="192.168.100.$2"
echo $ip2


addMoreSyn="true"


if test $3 = "cu" ; then
	#sender
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0"
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=cubic" 
	sleep 0.5 
  	ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	#receiver
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=cubic" 
	sleep 0.5 
  	ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	exit
fi

if test $3 = "ce"; then
	#sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=cubic" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=cubic" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        exit
fi


if test $3 = "de"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=dctcp" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=dctcp" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        exit
fi


if test $3 = "ru"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=reno" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=reno" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
        exit
fi



if test $3 = "re"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=reno" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=reno" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        exit
fi



if test $3 = "vu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=vegas" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=vegas" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
        exit
fi



if test $3 = "ve"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=vegas" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=vegas" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
        exit
fi


#mptcp


if test $3 = "lu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=lia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=lia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        exit
fi



if test $3 = "le"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=lia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=lia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        exit
fi



if test $3 = "ou"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=olia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=olia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        exit
fi



if test $3 = "oe"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=olia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=olia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        exit
fi



if test $3 = "bu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=balia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=balia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        exit
fi



if test $3 = "be"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=balia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=balia" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        exit
fi




if test $3 = "wu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        exit
fi




if test $3 = "we"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        sleep 0.5
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
	exit
fi



if test $3 = "ee"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "insmod /home/chix/nfs-share/mptcp_ecn_sf.ko" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=mptcp_ccc_ecn" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
	sleep 0.5 
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "insmod /home/chix/nfs-share/mptcp_ecn_sf.ko" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=mptcp_ccc_ecn" 
	sleep 0.5 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
	sleep 0.5 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        sleep 0.5
	if [ $addMoreSyn == "true" ]; then
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=10"
		sleep 0.5
	else 
		ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_syn_retries=3"
		sleep 0.5
	fi
	exit
fi
