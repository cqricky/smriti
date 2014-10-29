spring boot通过profiles使得某些特定的配置只在某些条件下才会生效,比如之前提到的开发,测试,生产对应的三种不同的配置.

在resources目录下添加2个配置文件,application-dev.properties,application-test.properties,分别代表开发和测试环境下的配置项:
```properties
#application-dev.properties
app.name=demo for dev
app.code=111111
```

```properties
#application-test.properties
app.name=demo for dev
app.code=222222
```
修改application.properties
```properties
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
```properties
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

也可以通过命令行设置profiles,多个profile用逗号分隔:
```shell
java -jar demo-0.0.1-SNAPSHOT.jar  --spring.profiles.active=dev,hsqldb
```

在Java代码中则可以通过@Profile注解使得某些配置只在profile被激活时才生效:
```java
@Configuration
@Profile("production")
public class ProductionConfiguration {
  // ...
}
```
上面的Configuration只有在被激活的profile包含production时才会生效.

profile也可以声明在@Controller,@Bean上,更多灵活的用法请自行探索.
```java
@RestController
@Profile("pro")
public class DemoController {
    @Value("${app.name}")
    String appName;

    @Value("${app.code}")
    String appCode;

    @RequestMapping("/appInfo")
    public String info() {
        return "name:"+appName+",code:"+appCode;
    }
}
```
