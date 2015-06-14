#!/bin/bash

cd $LFS/sources
tar xf findutils-4.4.2.tar.gz
cd findutils-4.4.2

./configure --prefix=/tools
make && make check && make install

