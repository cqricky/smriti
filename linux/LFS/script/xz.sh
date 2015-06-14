#!/bin/bash

cd $LFS/sources
tar xf xz-5.2.0.tar.xz
cd xz-5.2.0

./configure --prefix=/tools
make && make check && make install

