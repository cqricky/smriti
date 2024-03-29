﻿#!/bin/bash

if [ -b "$1" ];then
FORMAT_DEV=$1;
echo "deicve $FORMAT_DEV will be format..."
else
echo "please enter a device..."
exit 1
fi

for target in `ls $FORMAT_DEV*`;do
	umount $target; 
done
sudo fdisk $FORMAT_DEV << "EOF"
p
d
1
d
2
d
3
d
4

n
p
1

+100M
n
p
2

+2G
n
p
3


t
1
83
t
2
82
t
3
83

p
w
EOF

sudo mkswap ${FORMAT_DEV}2
sudo mkfs.ext4 ${FORMAT_DEV}1
sudo mkfs.ext4 ${FORMAT_DEV}3

sudo partprobe $FORMAT_DEV

