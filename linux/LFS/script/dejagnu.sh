#!/bin/bash

cd $LFS/sources
tar xf dejagnu-1.5.2.tar.gz
cd dejagnu-1.5.2

./configure --prefix=/tools
make install
make check

