```shell
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

rpm -ivh http://www.elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm

yum --enablerepo=elrepo-kernel install kernel-lt -y
```
