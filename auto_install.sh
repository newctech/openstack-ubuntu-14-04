#!/bin/bash

set -e
set -o xtrace

./init.sh
./create_link.sh
pushd  chap03/mysql
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc 
./mysql.sh
popd
pushd  chap03/rabbitmq
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
./rabbitmq.sh
popd
pushd chap03/keystone
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
apt-get install zlib1g-dev
apt-get upgrade python-oslo.config
#安装openstack-ubuntu-14-04/packages/pip
./keystone.sh
popd
pushd chap04
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
apt-get install nfs-common
./swift.sh
./swift-storage.sh
popd
pushd chap05
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
./glance-with-swift.sh
popd
pushd chap06
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
./quantum.sh
./quantum-agent.sh
popd
cp -rf interface /etc/network/
ifconfig eth3 down 
ifconfig eth3 0.0.0.0 up
ip link eth3 promisc on
ovs-vsctl add-port br-ex eth3
ifdown br-ex
ifup br-ex
sed -i '/#net.ipv4.ip_forward=1/s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf 
pushd chap07
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
./cinder.sh
./cinder-volume.sh
popd
pushd chap08/allinone
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
./nova-api.sh
./nova-compute.sh
popd
pushd chap09
sed -i '/192.168.56.180/s/192.168.56.180/192.168.56.181/g' ./localrc
./dashboard.sh
popd

set +o xtrace
