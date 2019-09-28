#!/bin/bash

wget $1 package_tmp
sudo yum install ./package_tmp

# linux brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.zprofile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
