#!/bin/bash

if [ -b "$1" ];then
FORMAT_DEV=$1;
echo "deicve $1 will be mount..."
else
echo "please enter a device..."
exit 1
fi

export LFS=/mnt/lfs
sudo mkdir -pv $LFS
sudo mount -v -t ext4 ${FORMAT_DEV}3 ${LFS}
sudo mkdir -pv $LFS/boot
sudo mount -v -t ext4 ${FORMAT_DEV}1 ${LFS}/boot
sudo /sbin/swapon -v ${FORMAT_DEV}2

df -h

echo "export LFS=/mnt/lfs" >> ~/.bash_profile
source ~/.bash_profile
echo "lfs root is $LFS"
