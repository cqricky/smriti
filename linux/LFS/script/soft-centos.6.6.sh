#!/bin/bash

yum -y update
yum -y groupinstall "Development tools"
yum -y install tar texinfo

