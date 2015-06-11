#!/bin/bash

LFS=/mnt/lfs
sudo mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/sources

wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
