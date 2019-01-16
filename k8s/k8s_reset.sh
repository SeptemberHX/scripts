#!/bin/bash 

# reset k8s
kubeadm reset

# clean interface
ifconfig cni0 down
ip link delete cni0
# brctl delbr flannel.1 
ifconfig flannel.1 down
ip link delete flannel.1
