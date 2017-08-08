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

if test $3 = "cu" ; then
	#sender
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
	ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=cubic" 
  	ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
	#receiver
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
	ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=cubic" 
  	ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
	exit
fi

if test $3 = "ce"; then
	#sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=cubic" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=cubic" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi


if test $3 = "de"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=dctcp" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=dctcp" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi


if test $3 = "ru"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=reno" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=reno" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
        exit
fi



if test $3 = "re"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=reno" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=reno" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi



if test $3 = "vu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=vegas" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=vegas" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
        exit
fi



if test $3 = "ve"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=vegas" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=0" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=vegas" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi


#mptcp


if test $3 = "lu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=lia" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=lia" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
        exit
fi



if test $3 = "le"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=lia" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=lia" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi



if test $3 = "ou"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=olia" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=olia" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
        exit
fi



if test $3 = "oe"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=olia" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=olia" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi



if test $3 = "bu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=balia" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=balia" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
        exit
fi



if test $3 = "be"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=balia" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=balia" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi




if test $3 = "wu"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=2" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=2" 
        exit
fi




if test $3 = "we"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=wvegas" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi



if test $3 = "ee"; then
        #sender
        ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_enabled=1" 
	ssh -f -n root@192.168.100.$1 "insmod /home/chix/nfs-share/mptcp_ecn_sf.ko" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_congestion_control=mptcp_ccc_ecn" 
	ssh -f -n root@192.168.100.$1 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$1 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$1 "sysctl net.ipv4.tcp_ecn=1" 
        #receiver
        ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_enabled=1" 
	ssh -f -n root@192.168.100.$2 "insmod /home/chix/nfs-share/mptcp_ecn_sf.ko" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_congestion_control=mptcp_ccc_ecn" 
	ssh -f -n root@192.168.100.$2 "sysctl net.mptcp.mptcp_path_manager='fullmesh'" 
        ssh -f -n root@192.168.100.$2 "echo 1 > /sys/module/mptcp_fullmesh/parameters/num_subflows" 
        ssh -f -n root@192.168.100.$2 "sysctl net.ipv4.tcp_ecn=1" 
        exit
fi


