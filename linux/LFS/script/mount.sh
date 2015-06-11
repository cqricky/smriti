#!/bin/bash

FORMAT_DEV=$1
export LFS=/mnt/lfs
sudo mkdir -pv $LFS
sudo mount -v -t ext4 ${FORMAT_DEV}3 ${LFS}
sudo mkdir -pv $LFS/boot
sudo mount -v -t ext4 ${FORMAT_DEV}1 ${LFS}/boot
sudo /sbin/swapon -v ${FORMAT_DEV}2

df -h



