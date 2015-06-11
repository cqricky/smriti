#!/bin/bash

if [ -b "$1" ];then
FORMAT_DEV=$1;
echo "deicve $1 will be init..."
else
echo "please enter a device..."
exit 1
fi

isUbuntu=`cat /etc/issue | grep "Ubuntu" | wc -l`

if [ $isUbuntu == 1 ];then
. soft-ubuntu.15.04.sh
else
. soft-centos.6.6.sh
fi
. version-check.sh
. library-check.sh
. create-file-system.sh $FORMAT_DEV
. mount.sh $FORMAT_DEV


