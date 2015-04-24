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


```
