#!/bin/bash

cd $LFS/sources
tar xf patch-2.7.4.tar.xz
cd patch-2.7.4

./configure --prefix=/tools
make && make check && make install

