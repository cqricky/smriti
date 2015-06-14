#!/bin/bash

cd $LFS/sources
tar xf coreutils-8.23.tar.xz
cd coreutils-8.23

./configure --prefix=/tools --enable-install-program=hostname
make
make RUN_EXPENSIVE_TESTS=yes check
make install

