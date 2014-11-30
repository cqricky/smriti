# Tengine安装

标签（空格分隔）： linux

---

```bash

//下载源码
wget http://tengine.taobao.org/download/tengine-2.0.3.tar.gz
tar xvf tengine-2.0.3.tar.gz
cd tengine-2.0.3

//安装依赖
yum -y install zlib zlib-devel openssl openssl--devel pcre pcre-devel

//编译
./configure
make && make install

//启动
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```
