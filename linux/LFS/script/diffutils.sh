#!/bin/bash

cd $LFS/sources
tar xf diffutils-3.3.tar.xz
cd diffutils-3.3

./configure --prefix=/tools
make && make check && make install

