- 添加maven依赖

```xml
	<!-- pom.xml -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>1.2.2</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>3.2.7</version>
		</dependency>
```

- 配置SqlSessionFactory

```java
  // AppConfig.java
@Configuration
@EnableAutoConfiguration
@ComponentScan
@MapperScan("demo.repository")
public class AppConfig extends WebMvcConfigurerAdapter implements EmbeddedServletContainerCustomizer {

    	@Bean(name = "sqlSessionFactory")
    	public SqlSessionFactory sqlSessionFactoryBean() throws Exception {
    
    		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
    		sqlSessionFactoryBean.setDataSource(dataSource());
    		sqlSessionFactoryBean.setTypeAliasesPackage("demo.model");
    
    		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
    		sqlSessionFactoryBean.setMapperLocations(resolver.getResources("classpath:mapper/*.xml"));
    
    		return sqlSessionFactoryBean.getObject();
    	}
	
	}
```


- 1.2.+的版本,会导致启动报错(Cannot subclass final class class com.sun.proxy.$Proxy49),修复方法如下：

```
# application.properties
# 1.2.+ bug https://github.com/spring-projects/spring-boot/issues/1929
spring.dao.exceptiontranslation.enabled=false
```

- 参见[spring-boot-samples](https://github.com/Utgard/spring-boot-samples)
