# Tengine安装

标签（空格分隔）： linux

---

```bash
wget http://tengine.taobao.org/download/tengine-2.0.3.tar.gz
tar xvf tengine-2.0.3.tar.gz
cd tengine-2.0.3

yum -y install zlib zlib-devel openssl openssl--devel pcre pcre-devel

./configure

make && make install

/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```
