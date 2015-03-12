- 安装环境 CentOS 6.5
- 安装依赖库

```shell
yum install -y gcc-c++
yum install -y tcl
```

- 编译安装
```shell
wget http://download.redis.io/releases/redis-2.8.19.tar.gz
tar xvf redis-2.8.19.tar.gz
cd redis-2.8.19
make 
make test
cd src && make install && cd ../
ls /usr/local/bin/ | grep redis
redis-benchmark
redis-check-aof
redis-check-dump
redis-cli
redis-sentinel
redis-server

# 此时会在/usr/local/bin目录下生成本个可执行文件，分别是redis-server、redis-cli、redis-benchmark、redis-check-aof 、redis-check-dump，它们的作用如下：

# redis-server：Redis服务器的daemon启动程序

# redis-cli：Redis命令行操作工具。也可以用telnet根据其纯文本协议来操作

# redis-benchmark：Redis性能测试工具，测试Redis在当前系统下的读写性能

# redis-check-aof：数据修复

# redis-check-dump：检查导出工具
```

- 配置
```shell
 cp redis.conf  /etc/
 
 
echo vm.overcommit_memory=1 >> /etc/sysctl.conf

sysctl vm.overcommit_memory=1 或执行echo vm.overcommit_memory=1 >>/proc/sys/vm/overcommit_memory

# 使用数字含义：
# 0，表示内核将检查是否有足够的可用内存供应用进程使用；如果有足够的可用内存，内存申请允许；否则，内存申请失败，并把错误返回给应用进程。
# 1，表示内核允许分配所有的物理内存，而不管当前的内存状态如何。
# 2，表示内核允许分配超过所有物理内存和交换空间总和的内存。

vim /etc/redis.conf
daemonize yes

# daemonize：是否以后台daemon方式运行
# pidfile：pid文件位置
# port：监听的端口号
# timeout：请求超时时间
# loglevel：log信息级别
# logfile：log文件位置
# databases：开启数据库的数量
# save * *：保存快照的频率，第一个*表示多长时间，第三个*表示执行多少次写操作。在一定时间内执行一定数量的写操作时，自动保存快照。可设置多个条件。
# rdbcompression：是否使用压缩
# dbfilename：数据快照文件名（只是文件名，不包括目录）
# dir：数据快照的保存目录（这个是目录）
# appendonly：是否开启appendonlylog，开启的话每次写操作会记一条log，这会提高数据抗风险能力，但影响效率。
# appendfsync：appendonlylog如何同步到磁盘（三个选项，分别是每次写都强制调用fsync、每秒启用一次fsync、不调用fsync等待系统自己同步）
```

- 启动redis
```shell
redis-server /etc/redis.conf
ps aux | grep redis
root     24488  0.0  0.0 137372  7448 ?        Ssl  10:11   0:00 redis-server *:6379
root     24536  0.0  0.0 103248   836 pts/3    S+   10:11   0:00 grep redis

```