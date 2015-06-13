#!/bin/bash

cd $LFS/sources

rm -rf ./binutils-build ./binutils-2.25

tar xf binutils-2.25.tar.bz2

cd binutils-2.25 && mkdir -v ../binutils-build
cd ../binutils-build

CC=$LFS_TGT-gcc AR=$LFS_TGT-ar RANLIB=$LFS_TGT-ranlib ../binutils-2.25/configure --prefix=/tools --disable-nls --disable-werror --with-lib-path=/tools/lib --with-sysroot

make && make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin


