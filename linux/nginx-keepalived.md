```
yum install openssl*
yum install popt*
yum isntall ipvsadm
yum install ipvsadm
yum install libnl-dev*

wget http://www.keepalived.org/software/keepalived-1.2.19.tar.gz
tar xf keepalived-1.2.19.tar.gz
cd keepalived-1.2.19
./configure
make && make install

# master 
cp /usr/local/sbin/keepalived  /usr/sbin/
cp /usr/local/etc/rc.d/init.d/keepalived /etc/init.d/
cp /usr/local/etc/sysconfig/keepalived /etc/sysconfig/
mkdir /etc/keepalived/
mkdir /etc/keepalived/script/
cp keepalived-master.conf /etc/keepalived/keepalived.conf
cp nginx.sh /etc/keepalived/script

# slave 
cp /usr/local/sbin/keepalived  /usr/sbin/
cp /usr/local/etc/rc.d/init.d/keepalived /etc/init.d/
cp /usr/local/etc/sysconfig/keepalived /etc/sysconfig/
mkdir /etc/keepalived/
mkdir /etc/keepalived/script/
cp keepalived-slave.conf /etc/keepalived/keepalived.conf
cp nginx.sh /etc/keepalived/script

```
