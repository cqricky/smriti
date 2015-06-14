#!/bin/bash

cd $LFS/sources
tar xf check-0.9.14.tar.gz
cd check-0.9.14

PKG_CONFIG= ./configure --prefix=/tools
make && make check && make install


