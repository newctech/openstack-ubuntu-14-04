#!/bin/bash

set -e
set -o xtrace

./init.sh
./create_link.sh
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap03/mysql/localrc 
chap03/mysql/mysql.sh
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap03/rabbitmq/localrc
chap03/rabbitmq/rabbitmq.sh
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap03/keystone/localrc
chap03/keystone/keystone.sh
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap04/localrc
chap04/swift.sh
chap04/swift-storage.sh
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap05/localrc
chap05/glance-with-swift.sh
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap06/localrc
chap06/quantum.sh
chap06/quantum-agent.sh
cp -rf interface /etc/network/
ifconfig eth3 down 
ifconfig eth3 0.0.0.0 up
ip link eth3 promisc on
ovs-vsctl add-port br-ex eth3
ifdown br-ex
ifup br-ex
sed -i '/#net.ipv4.ip_forward=1/s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf 

sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap07/localrc
chap07/cinder.sh
chap07/cinder-volume.sh
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap08/allinone/localrc
chap08/allinone/nova-api.sh
chap08/allinone/nova-compute.sh

sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' chap09/localrc
chap09/dashboard.sh


set +o xtrace
