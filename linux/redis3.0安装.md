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
