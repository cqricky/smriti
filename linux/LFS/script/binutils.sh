#!/bin/bash

cd $LFS/sources && tar xf binutils-2.25.tar.bz2 

rm -rf ./binutils-build
mkdir -v binutils-build
cd binutils-build/

case $(uname -m) in
x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac

../binutils-2.25/configure --prefix=/tools --with-sysroot=$LFS --with-lib-path=/tools/lib --target=$LFS_TGT --disable-nls --disable-werror && make && make install

cd $LFS/sources

