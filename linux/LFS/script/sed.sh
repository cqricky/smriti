#!/bin/bash

cd $LFS/sources
tar xf sed-4.2.2.tar.bz2
cd sed-4.2.2

./configure --prefix=/tools
make && make check && make install

