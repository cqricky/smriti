#!/bin/bash

if [ ! -r /usr/include/rpc/types.h ]; then
su -c 'mkdir -pv /usr/include/rpc'
su -c 'cp -v sunrpc/rpc/*.h /usr/include/rpc'
fi

sed -e '/ia32/s/^/1:/' -e '/SSE2/s/^1://' -i sysdeps/i386/i686/multiarch/mempcpy_chk.S

cd $LFS/sources

tar xf glibc-2.21.tar.xz
cd glibc-2.21
mkdir -v ../glibc-build
cd ../glibc-build

../glibc-2.21/configure --prefix=/tools --host=$LFS_TGT --build=$(../glibc-2.21/scripts/config.guess) --disable-profile --enable-kernel=2.6.32 --with-headers=/tools/include libc_cv_forced_unwind=yes libc_cv_ctors_header=yes libc_cv_c_cleanup=yes

make && make install

echo 'main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'

rm -v dummy.c a.out
