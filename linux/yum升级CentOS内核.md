```shell
# 导入public ke
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

# 安装ELRepo到CentOS-6.5中
rpm -ivh http://www.elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm

# 安装kernel-lt
yum --enablerepo=elrepo-kernel install kernel-lt -y

# 修改默认的启动内核,设置default=0
vi /etc/grub.conf

# 重启，查看内核是否升级成功
uname -a


```
