#!/bin/bash

cd $LFS/sources/gcc-build

../gcc-4.9.2/libstdc++-v3/configure --host=$LFS_TGT --prefix=/tools --disable-multilib --disable-shared --disable-nls --disable-libstdcxx-threads --disable-libstdcxx-pch --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/4.9.2

make && make install


