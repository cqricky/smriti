#!/bin/bash

cd $LFS/sources
tar xf util-linux-2.26.tar.xz
cd util-linux-2.26

./configure --prefix=/tools --without-python --disable-makeinstall-chown --without-systemdsystemunitdir PKG_CONFIG=""
make && make install

