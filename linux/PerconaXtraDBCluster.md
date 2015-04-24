```shell
# 安装
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-XtraDB-Cluster-56

# 启动测试
/etc/init.d/mysql start

# 开机自启动
chkconfig mysql on

# 安全加固
/usr/bin/mysql_secure_installation

# 授权用于集群同步的用户和密码
mysql -uroot -p

mysql> GRANT USAGE ON *.* to sst@'%' IDENTIFIED BY '123456';
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT ALL PRIVILEGES on *.* to sst@'%';
Query OK, 0 rows affected (0.00 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.00 sec)

mysql> quit
Bye

# 配置my.cnf

```
