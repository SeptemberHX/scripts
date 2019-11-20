#!/bin/bash

# A simple script to install useful tools

yum -y install epel-release
yum install -y net-tools git curl vim htop zsh byobu yum-versionlock iperf3
