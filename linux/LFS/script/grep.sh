#!/bin/bash

cd $LFS/sources
tar xf grep-2.21.tar.xz
cd grep-2.21.tar.xz

./configure --prefix=/tools
make && make check && make install

