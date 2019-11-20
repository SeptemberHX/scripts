#!/bin/bash

# A simple script to install useful tools

yum -y install epel-release
yum install -y net-tools git curl vim htop zsh byobu yum-versionlock iperf3

git clone https://github.com/SeptemberHX/scripts.git
cd scripts

./k8s/k8s_install.sh 1.16.2-0