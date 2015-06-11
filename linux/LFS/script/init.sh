#!/bin/bash

if [ -b "$1" ];then
FORMAT_DEV=$1;
echo "deicve $1 will be init..."
else
echo "please enter a device..."
exit 1
fi

. soft-ubuntu.15.04.sh
. version-check.sh
. library-check.sh
. create-file-system.sh $FORMAT_DEV
. mount.sh $FORMAT_DEV


