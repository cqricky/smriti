```shell
# 导入public ke
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

# 安装ELRepo到CentOS-6.5中
rpm -ivh http://www.elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm

# 安装kernel-lt
yum --enablerepo=elrepo-kernel install kernel-lt -y
```
