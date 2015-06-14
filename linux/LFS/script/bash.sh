#!/bin/bash

cd $LFS/sources
tar xf bash-4.3.30.tar.gz
cd bash-4.3.30

./configure --prefix=/tools --without-bash-malloc
make && make tests && make install

ln -sv bash /tools/bin/sh

