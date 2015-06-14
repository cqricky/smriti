#!/bin/bash

cd $LFS/sources
tar xf texinfo-5.2.tar.xz
cd texinfo-5.2

./configure --prefix=/tools
make && make check && make install

