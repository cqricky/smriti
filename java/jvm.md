- jps
```shell
# 显示当前所有java进程pid
[root@iZ283rm8e66Z ~]# jps
18703 Bootstrap
17716 Bootstrap
22219 Jps

# -q 只显示pid，不显示class名称,jar文件名和传递给main 方法的参数
[root@iZ283rm8e66Z ~]# jps -q
22240
18703
17716

# -m 输出传递给main 方法的参数
[root@iZ283rm8e66Z ~]# jps -m
22260 Jps -m
18703 Bootstrap start
17716 Bootstrap start

# -l 输出应用程序main class的完整package名 或者 应用程序的jar文件完整路径名
[root@iZ283rm8e66Z ~]# jps -l
22275 sun.tools.jps.Jps
18703 org.apache.catalina.startup.Bootstrap
17716 org.apache.catalina.startup.Bootstrap

# -v 输出传递给JVM的参数
[root@iZ283rm8e66Z ~]# jps -v
18703 Bootstrap -Djava.util.logging.config.file=/opt/tomcat7/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xmx3072m -Xms3072m -XX:MaxPermSize=512m -XX:+PrintGCDetails -Xloggc:/logs/gc.log -Djava.endorsed.dirs=/opt/tomcat7/endorsed -Dcatalina.base=/opt/tomcat7 -Dcatalina.home=/opt/tomcat7 -Djava.io.tmpdir=/opt/tomcat7/temp
17716 Bootstrap -Djava.util.logging.config.file=/opt/tomcat2/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xmx1536m -XX:MaxPermSize=512m -Djava.endorsed.dirs=/opt/tomcat2/endorsed -Dcatalina.base=/opt/tomcat2 -Dcatalina.home=/opt/tomcat2 -Djava.io.tmpdir=/opt/tomcat2/temp
22294 Jps -Denv.class.path=.:/opt/java/jdk1.7.0_55/lib/dt.jar:/opt/java/jdk1.7.0_55/lib/tools.jar -Dapplication.home=/opt/java/jdk1.7.0_55 -Xms8m


```
