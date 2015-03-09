- 添加maven依赖
```xml
    <!-- pom.xml -->
		<dependency>
			<groupId>org.springframework.session</groupId>
			<artifactId>spring-session-data-redis</artifactId>
			<version>1.0.0.RELEASE</version>
			<type>pom</type>
		</dependency>
```

- 开启RedisHttpSession
```java
//HttpSessionConfig.java
@Configuration
@EnableRedisHttpSession 
public class HttpSessionConfig {

    @Bean
    public JedisConnectionFactory connectionFactory() {
		JedisConnectionFactory jedisConnectionFactory = new JedisConnectionFactory();

		jedisConnectionFactory.setHostName("xxx.xxx.x.xxx");
		return jedisConnectionFactory;
    }
}
```

- 验证Spring Session
```
启动项目，用chrome访问页面，查看cookie，可以看到名为SESSION的cookie。

访问redis服务器，redis-cli keys '*'，验证session是否存储到了redis服务器。
```

- 参见[spring-session](http://projects.spring.io/spring-session/),[spring-session-demo](https://github.com/Utgard/leaf/tree/master/spring-session)
