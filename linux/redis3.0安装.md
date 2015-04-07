- 安装环境 CentOS 6.6
- 安装依赖库

```shell
$ yum install -y gcc-c++ tcl
```

- 编译安装
```shell
$ wget http://download.redis.io/releases/redis-3.0.0.tar.gz
$ tar xf redis-3.0.0.tar.gz
$ cd redis-3.0.0
$ make
$ make test
$ cd src && make install && cd ../
$ ls /usr/local/bin/ | grep redis
redis-benchmark
redis-check-aof
redis-check-dump
redis-cli
redis-sentinel
redis-server
```
- 配置
```shell
$ cp redis.conf  /etc/
 
$ echo vm.overcommit_memory=1 >> /etc/sysctl.conf

$ sysctl vm.overcommit_memory=1

$ vim /etc/redis.conf
daemonize yes
```

- 启动redis
```shell
redis-server /etc/redis.conf
ps aux | grep redis
root      6834  0.2  0.3 133396  7440 ?        Ssl  14:09   0:00 redis-server *:6379
root      6844  0.0  0.0 103304   808 pts/0    S+   14:09   0:00 grep redis
```
