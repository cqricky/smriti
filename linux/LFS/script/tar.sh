#!/bin/bash

cd $LFS/sources
tar xf tar-1.28.tar.xz
cd tar-1.28

./configure --prefix=/tools
make && make check && make install

