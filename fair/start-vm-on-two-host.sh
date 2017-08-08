#!/bin/sh

#on host one
sudo bash /home/chix/kvm/ovs-nodpdk-start/11.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/12.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/13.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/14.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/15.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/16.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/17.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/18.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/19.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/20.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/21.sh &
sleep 0.5
sudo bash /home/chix/kvm/ovs-nodpdk-start/22.sh &
sleep 0.5

#on host two
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/51.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/52.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/53.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/54.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/55.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/56.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/57.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/58.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/59.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/60.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/61.sh &" 
sleep 0.5
ssh -f -n root@192.168.1.59 "bash /home/chix/kvm/ovs-nodpdk-start/62.sh &" 
sleep 0.5


