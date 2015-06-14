#!/bin/bash

cd $LFS/sources
tar xf m4-1.4.17.tar.xz
cd m4-1.4.17

./configure --prefix=/tools
make && make check && make install

