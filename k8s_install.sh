#!/bin/bash

if [[ $# != 2 ]]; then 
    echo "$0 k8s_version"
    exit 0
fi 

K8S_VERSION=$1

# turn off swap, firewall and selinux
swapoff -a

systemctl stop firewalld
systemctl disable firewalld

setenforce 0

# install docker and start the service
yum install -y docker
systemctl enable docker
systemctl start docker

# add k8s repo and install it
if [ ! -f "/etc/yum.repos.d/kubernetes.repo" ]; then
    cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
fi

sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet-$K8S_VERSION.x86_64 kubeadm-$K8S_VERSION.x86_64 kubectl-$K8S_VERSION.x86_64 etcd --disableexcludes=kubernetes

systemctl enable kubelet && systemctl start kubelet
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

# done
echo "Finished"