#!/bin/bash

#!/bin/bash
A=`ps -C nginx |wc -l`
if [ $A -eq 1 ];then
  /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
  sleep 3
  if [ `ps -C nginx |wc -l` -eq 1 ];then
    killall keepalived
  fi
fi
