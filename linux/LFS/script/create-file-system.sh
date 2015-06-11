#!/bin/bash

FORMAT_DEV=$1
echo "dev $FORMAT_DEV will be format..."

sudo fdisk $FORMAT_DEV << "EOF"
p
d

d

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

