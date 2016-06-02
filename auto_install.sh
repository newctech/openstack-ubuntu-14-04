#!/bin/bash

set -e
set -o xtrace

./init.sh
./create_link.sh
chap03/mysql/mysql.sh
chap03/rabbitmq/rabbitmq.sh
chap03/keystone/keystone.sh
chap04/swift.sh
chap04/swift-storage.sh
chap05/glance-with-swift.sh
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

set +o xtrace
