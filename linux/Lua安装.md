- 安装环境 CentOS 6.6
- 安装依赖库

```shell
$ yum install -y libtermcap-devel ncurses-devel libevent-devel readline-devel
```

- 编译安装
```shell
$ curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz

$ tar zxf lua-5.3.0.tar.gz
$ cd lua-5.3.0
$ make linux test
```

- 验证
```shell
[root@localhost ~]# lua
Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
> print("hello,world!")
hello,world!
>
```
