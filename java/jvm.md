## jps
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

## jstat
```shell
# 显示gc的信息，查看gc的次数及时间.其中最后五项，分别是young gc的次数，young gc的时间，full gc的次数，full gc的时间，gc的总时间。
[root@iZ283rm8e66Z ~]#  jstat -gc 18703
 S0C    S1C    S0U    S1U      EC       EU        OC         OU       PC     PU    YGC     YGCT    FGC    FGCT     GCT
103424.0 105472.0  0.0   1626.9 836096.0 335913.6 2097152.0   74910.8   57344.0 57251.3     15    0.599   0      0.000    0.599

# 显示，VM内存中三代（young,old,perm）对象的使用和占用大小
[root@iZ283rm8e66Z ~]# jstat -gccapacity 18703
 NGCMN    NGCMX     NGC     S0C   S1C       EC      OGCMN      OGCMX       OGC         OC      PGCMN    PGCMX     PGC       PC     YGC    FGC
1048576.0 1048576.0 1048576.0 103424.0 105472.0 836096.0  2097152.0  2097152.0  2097152.0  2097152.0  21504.0 524288.0  57344.0  57344.0     15     0

#  统计gc信息
[root@iZ283rm8e66Z ~]# jstat -gcutil 18703
  S0     S1     E      O      P     YGC     YGCT    FGC    FGCT     GCT
  0.00   1.54  54.35   3.57  99.84     15    0.599     0    0.000    0.599

# 年轻代对象的信息
[root@iZ283rm8e66Z ~]# jstat -gcnew 18703
 S0C    S1C    S0U    S1U   TT MTT  DSS      EC       EU     YGC     YGCT
103424.0 105472.0    0.0 1626.9  1  15 103424.0 836096.0 553536.1     15    0.599

# 年轻代对象的信息及其占用量
[root@iZ283rm8e66Z ~]# jstat -gcnewcapacity 18703
  NGCMN      NGCMX       NGC      S0CMX     S0C     S1CMX     S1C       ECMX        EC      YGC   FGC
 1048576.0  1048576.0  1048576.0 349184.0 103424.0 349184.0 105472.0  1047552.0   836096.0    15     0

# old代对象的信息
[root@iZ283rm8e66Z ~]# jstat -gcold 18703
   PC       PU        OC          OU       YGC    FGC    FGCT     GCT
 57344.0  57259.0   2097152.0     74910.8     15     0    0.000    0.599

# old代对象的信息及其占用量
[root@iZ283rm8e66Z ~]# jstat -gcoldcapacity 18703
   OGCMN       OGCMX        OGC         OC       YGC   FGC    FGCT     GCT
  2097152.0   2097152.0   2097152.0   2097152.0    15     0    0.000    0.599

# perm对象的信息及其占用量
[root@iZ283rm8e66Z ~]# jstat -gcpermcapacity 18703
  PGCMN      PGCMX       PGC         PC      YGC   FGC    FGCT     GCT
   21504.0   524288.0    57344.0    57344.0    15     0    0.000    0.599

# 显示加载class的数量，及所占空间等信息
[root@iZ283rm8e66Z ~]# jstat -class 18703
Loaded  Bytes  Unloaded  Bytes     Time
  9620 19225.5        0     0.0       6.73

#  显示VM实时编译的数量等信息
[root@iZ283rm8e66Z ~]# jstat -compiler 18703
Compiled Failed Invalid   Time   FailedType FailedMethod
    2360      1       0    43.35          1 org/apache/tomcat/util/IntrospectionUtils setProperty

# 当前VM执行的信息
[root@iZ283rm8e66Z ~]# jstat -printcompilation 18703
Compiled  Size  Type Method
    2360    438    1 com/mysql/jdbc/util/ReadAheadInputStream fill

```
* S0C：年轻代中第一个survivor的容量 (字节)
* S1C：年轻代中第二个survivor的容量 (字节)
* S0U：年轻代中第一个survivor目前已使用空间 (字节)
* S1U：年轻代中第二个survivor目前已使用空间 (字节)
* EC：年轻代中Eden的容量 (字节)
* EU：年轻代中Eden目前已使用空间 (字节)
* OC：Old代的容量 (字节)
* OU：Old代目前已使用空间 (字节)
* PC：Perm的容量 (字节)
* PU：Perm目前已使用空间 (字节)
* YGC：从应用程序启动到采样时年轻代中gc次数
* YGCT：从应用程序启动到采样时年轻代中gc所用时间(s)
* FGC：从应用程序启动到采样时old代(全gc)gc次数
* FGCT：从应用程序启动到采样时old代(全gc)gc所用时间(s)
* GCT：从应用程序启动到采样时gc用的总时间(s)
* NGCMN：年轻代(young)中初始化(最小)的大小 (字节)
* NGCMX：年轻代(young)的最大容量 (字节)
* NGC：年轻代(young)中当前的容量 (字节)
* OGCMN：old代中初始化(最小)的大小 (字节) 
* OGCMX：old代的最大容量 (字节)
* OGC：old代当前新生成的容量 (字节)
* PGCMN：perm代中初始化(最小)的大小 (字节) 
* PGCMX：perm代的最大容量 (字节)   
* PGC：perm代当前新生成的容量 (字节)
* S0：年轻代中第一个survivor已使用的占当前容量百分比
* S1：年轻代中第二个survivor已使用的占当前容量百分比
* E：年轻代中Eden已使用的占当前容量百分比
* O：old代已使用的占当前容量百分比
* P：perm代已使用的占当前容量百分比
* S0CMX：年轻代中第一个survivor）的最大容量 (字节)
* S1CMX ：年轻代中第二个survivor）的最大容量 (字节)
* ECMX：年轻代中Eden）的最大容量 (字节)
* DSS：当前需要survivor的容量 (字节)（Eden区已满）
* TT： 持有次数限制
* MTT ： 最大持有次数限制


## 开启远程监控
```shell
cd $JAVA_HOME/bin/
vim jstatd.all.policy

grant codebase "file:${java.home}/../lib/tools.jar" {
    permission java.security.AllPermission;
};

nohup jstatd -J-Djava.security.policy=$JAVA_HOME/bin/jstatd.all.policy  -J-Djava.rmi.server.hostname=xxx.xx.xxx.xx &

```