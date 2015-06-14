#!/bin/bash

cd $LFS/sources
tar xf file-5.22.tar.gz
cd file-5.22

./configure --prefix=/tools
make && make check && make install

