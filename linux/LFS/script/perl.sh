#!/bin/bash

cd $LFS/sources
tar xf perl-5.20.2.tar.bz2
cd perl-5.20.2

sh Configure -des -Dprefix=/tools -Dlibs=-lm
make
cp -v perl cpan/podlators/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/5.20.2
cp -Rv lib/* /tools/lib/perl5/5.20.2

