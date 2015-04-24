```shell
# 安装
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-XtraDB-Cluster-56

# 修改/etc/hosts
192.168.1.151 node-1
192.168.1.152 node-2
192.168.1.153 node-3

# 关闭防火墙及selinux

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

# 配置my.cnf(node-1)
[root@master ~]# vim /etc/my.cnf
[mysqld]
wsrep_provider=/usr/lib64/libgalera_smm.so
# wsrep_cluster_address=gcomm://
wsrep_slave_threads=8
wsrep_sst_method=rsync
binlog_format=ROW
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
wsrep_sst_auth=sst:123456

# 配置my.cnf(node-2)
[root@master ~]# vim /etc/my.cnf
[mysqld]
wsrep_provider=/usr/lib64/libgalera_smm.so
# wsrep_cluster_address="gcomm://node-1"
wsrep_slave_threads=8
wsrep_sst_method=rsync
binlog_format=ROW
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
wsrep_sst_auth=sst:123456

# 配置my.cnf(node-2)
[root@master ~]# vim /etc/my.cnf
[mysqld]
wsrep_provider=/usr/lib64/libgalera_smm.so
# wsrep_cluster_address="gcomm://node-2"
wsrep_slave_threads=8
wsrep_sst_method=rsync
binlog_format=ROW
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
wsrep_sst_auth=sst:123456


```
