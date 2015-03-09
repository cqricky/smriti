先升级内核,[yum升级CentOS内核](../linux/yum升级CentOS内核.md),再安装：
```shell

sudo yum -y remove docker

sudo yum install http://mirrors.zju.edu.cn/epel/6/i386/epel-release-6-8.noarch.rpm

sudo yum install docker-io

sudo service docker start
```
