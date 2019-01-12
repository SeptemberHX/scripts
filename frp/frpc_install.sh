#!/bin/bash

wget https://github.com/fatedier/frp/releases/download/v0.22.0/frp_0.22.0_linux_amd64.tar.gz
tar -zxvf ./frp_0.22.0_linux_amd64.tar.gz -C /opt
mv /opt/frp_0.22.0_linux_amd64 /opt/frp
systemctl install ./frpc.service
