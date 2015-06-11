#!/bin/bash

LFS=/mnt/lfs
sudo mkdir -v $LFS/tools
sudo ln -sv $LFS/tools /

sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k ./skel lfs
echo "lfs:lfs" | sudo  chpasswd

sudo chown -v lfs $LFS/tools
sudo chown -v lfs $LFS/sources


