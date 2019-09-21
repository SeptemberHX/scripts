#!/bin/bash

if [[ $# != 1 ]]; then
    echo "$0 image_name"
    exit 0
fi

image_name=$1

echo "------------------------"
echo -e "\033[34mPull image [$image_name]\033[0m"
raw_image_name=$image_name
new_image_name=${image_name/k8s.gcr.io/mirrorgooglecontainers}  # replace k8s.gcr.io with gcrxio
docker pull $new_image_name
docker tag $new_image_name $raw_image_name
docker rmi $new_image_name
echo "------------------------"
