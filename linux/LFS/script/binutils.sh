#!/bin/bash

cd $LFS/sources && tar xf binutils-2.25.tar.bz2 

rm -rf ./binutils-build
mkdir -v binutils-build
cd binutils-build/

../binutils-2.25/configure --prefix=/tools --with-sysroot=$LFS --with-lib-path=/tools/lib --target=$LFS_TGT --disable-nls --disable-werror

cd $LFS/sources

