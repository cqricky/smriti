#!/bin/bash

cd $LFS/sources
tar xf gzip-1.6.tar.xz
cd gzip-1.6

./configure --prefix=/tools
make && make check && make install

