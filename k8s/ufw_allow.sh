#!/bin/bash

allow_port=(443 10250 30000:32767/tcp 8285/udp 8472/udp 179 2379 2380)

for i in ${allow_port[@]}
do
    echo "allow $i"
    ufw allow $i
done
