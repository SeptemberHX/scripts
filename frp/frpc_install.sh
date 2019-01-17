#!/bin/bash

if [ $? < 2 ]; then
    echo 'Usage: $0 MODE[client/server]'
    exit
fi

if [ ! -d /opt/frp ]; then
    # try to download frp release version from github
    wget https://github.com/fatedier/frp/releases/download/v0.22.0/frp_0.22.0_linux_amd64.tar.gz

    # install it to /opt/frp
    tar -zxvf ./frp_0.22.0_linux_amd64.tar.gz -C /opt
    mv /opt/frp_0.22.0_linux_amd64 /opt/frp
    rm ./frp_0.22.0_linux_amd64.tar.gz
fi

# copy service file to /usr/lib/systemd/system
cd `dirname $0`
if [ $2 = 'client' -o $2 = 'c' ]; then
    cp ./frpc.service /usr/lib/systemd/system
    systemctl enable frpc.service
    systemctl start frpc.service
elif [ $2 = 'server' -o $2 = 's' ]; then
    cp ./frps.service /usr/lib/systemd/system
    systemctl enable frps.service
    systemctl start frps.service
else
    echo 'Unknow mode "$2"'
    exit 1
fi
