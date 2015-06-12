#!/bin/bash

sudo apt-get install -y  m4

cd /tmp 
sudo rm -rf gmp-*
wget http://ftp.gnu.org/gnu/gmp/gmp-4.3.2.tar.gz
tar xf gmp-4.3.2.tar.gz
cd gmp-4.3.2 && ./configure && sudo make && sudo  make install

sudo rm -rf mpfr-*
wget http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.gz
tar xf mpfr-3.1.2.tar.gz
r-3.1.2 && ./configure && sudo .ake && sudo  make install

sudo rm -rf mpc-*
wget http://mirrors.ustc.edu.cn/gnu/mpc/mpc-1.0.3.tar.gz
tar xf mpc-1.0.3.tar.gz
cd mpc-1.0.3 && ./configure && sudo make && sudo  make install


