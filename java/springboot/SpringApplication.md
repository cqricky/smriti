spring boot通过调用SpringApplication.run启动应用.
```java
//Application.java
package demo;

import org.springframework.boot.SpringApplication;

public class Application {

    public static void main(String[] args) {
        SpringApplication.run(ApplicationConfig.class, args);
    }

}
```
runa方法可以接受多个Java Configuration(@Configuration)作为入参
```java
//AppConfig.java
package demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

@Configuration
@ComponentScan
@EnableAutoConfiguration
public class AppConfig {
    @Value("${characterEncoding}")
    String characterEncoding;

    @Bean
    public DispatcherServlet dispatcherServlet() {
        return new DispatcherServlet();
    }

    @Bean
    public CharacterEncodingFilter characterEncodingFilter() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding(characterEncoding);
        filter.setForceEncoding(true);
        return filter;
    }
}
```
```
#application.properties
characterEncoding = UTF-8
```
上面的AppConfig声明了2个bean,一个DispatcherServlet,一个CharacterEncodingFilter,characterEncodingFilter从配置文件中读取编码作为参数;

