#!/bin/bash

cd $LFS/sources
tar xf gawk-4.1.1.tar.xz
cd gawk-4.1.1

./configure --prefix=/tools
make && make check && make install

