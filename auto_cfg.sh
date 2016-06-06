#!/bin/bash
set -e
set -o xtrace

cp ./tools/create.network.sh /root/

pushd /root/
cp cinderrc adminrc
sed -i 's,service,admin,g' ./adminrc
sed -i 's,keystone_cinder_password,admin_user_password,g' ./adminrc
sed -i 's,cinder,admin,g' ./adminrc

source adminrc

popd

set +o xtrace
