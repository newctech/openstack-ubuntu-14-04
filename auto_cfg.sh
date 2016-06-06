#!/bin/bash
set -e
set -o xtrace

cp ./tools/create.network.sh /root/

pushd /root/
cp cinderrc adminrc
sed -i 's,service,admin,g' ./adminrc
sed -i 's,keystone_cinder_password,admin_user_password,g' ./adminrc
sed -i 's,cinder,admin,g' ./adminrc
sleep 3
source adminrc

popd

cp /usr/local/bin/quantum /usr/local/bin/neutron

set +o xtrace
