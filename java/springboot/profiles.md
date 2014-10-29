spring boot通过profiles使得某些特定的配置只在某些条件下才会生效,比如之前提到的开发,测试,生产对应的三种不同的配置.

在resources目录下添加2个配置文件,application-dev.properties,application-test.properties,分别代表开发和测试环境下的配置项:
```
#application-dev.properties
app.name=demo for dev
app.code=111111
```

```
#application-test.properties
app.name=demo for dev
app.code=222222
```
修改application.properties
```
#application.properties
app.name=demo
app.code=123456

#激活profile
spring.profiles.active=dev
```
启动应用,访问[http://localhost:8080/appInfo](http://localhost:8080/appInfo),显示:
```
name:demo for dev,code:111111
```
再次修改application.properties
```
#application.properties
app.name=demo
app.code=123456

#激活profile
spring.profiles.active=test
```
重启应用,访问[http://localhost:8080/appInfo](http://localhost:8080/appInfo),显示:
```
name:demo for test,code:222222
```
