#!/bin/bash

yum install git -y

git clone https://github.com/SeptemberHX/scripts.git
cd scripts
./basic_utils.sh

./k8s/k8s_install.sh 1.16.2-0

# yum install nfs-utils rpcbind
# systemctl restart rpcbind && systemctl enable rpcbind
# systemctl restart nfs && systemctl enable nfs