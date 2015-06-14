#!/bin/bash

cd $LFS/sources
tar xf gettext-0.19.4.tar.xz
cd gettext-0.19.4

cd gettext-tools 
EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

