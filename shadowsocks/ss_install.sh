#!/bin/bash

echo " =========>>> Install proxychains4 <<<========= "
git clone https://github.com/rofl0r/proxychains-ng.git proxychains-ng
cd proxychains-ng
./configure
make
make install
cd ..
rm -r proxychains-ng
cp ./config/proxychains.conf /etc

echo " =========>>> Install privoxy <<<========= "
apt install privoxy
cp ./config/config /etc/privoxy/config

echo " =========>>> Install shadowsocks <<<========== "
pip install shadowsocks
cp ./config/shadowsocks.service /etc/systemd/system
systemctl enable shadowsocks

echo " =========>>> END <<<========= "
echo "Put your shadowsocks.json to /etc/shadowsocks/shadowsocks.json"
echo "Then execute: systemctl start shadowsocks"
