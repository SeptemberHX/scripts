#!/bin/bash

if [[ $# != 1 ]]; then
    echo "$0 k8s_version"
    exit 0
fi

VERSION=$1

image_list=`kubeadm config images list --kubernetes-version $VERSION`
for image_name in $image_list
do
    echo "------------------------"
    echo -e "\033[34mPull image [$image_name]\033[0m"
    raw_image_name=$image_name
    new_image_name=${image_name/k8s.gcr.io/gcrxio}  # replace k8s.gcr.io with gcrxio
    docker pull $new_image_name
    docker tag $new_image_name $raw_image_name
    docker rmi $new_image_name
    echo "------------------------"
done
