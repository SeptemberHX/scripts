#!/bin/bash 

# reset k8s
kubeadm reset

# clean interface
ifconfig cni0 down
ip link delete flannel.1
brctl delbr cni0
