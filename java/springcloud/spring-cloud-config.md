- 官方示例
```shell
$ git clone https://github.com/spring-cloud/spring-cloud-config.git
$ mvn clean install

# Start the sample
$ cd spring-cloud-config-sample/target
$ java -jar spring-cloud-config-sample-1.0.0.RELEASE.jar

# Start the server
$ cd spring-cloud-config-server/target
$ java -jar spring-cloud-config-server-1.0.0.RELEASE.jar
$ curl localhost:8888/foo/development
{"name":"development","label":"master","propertySources":[
  {"name":"https://github.com/scratches/config-repo/foo-development.properties","source":{"bar":"spam"}},
  {"name":"https://github.com/scratches/config-repo/foo.properties","source":{"foo":"bar"}}
]}

# Start the sample
$ cd spring-cloud-config-sample/target
$ java -jar spring-cloud-config-sample-1.0.0.RELEASE.jar
$ curl localhost:8080/env
{
  "profiles":[],
  "configService:https://github.com/scratches/config-repo/bar.properties":{"foo":"bar"},
  "servletContextInitParams":{},
  "systemProperties":{...},
  ...
}
$ curl localhost:8080/env/foo
bar
```

- 定制化服务端
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>

	<groupId>com.firefly</groupId>
	<artifactId>spring-cloud-config-server-demo</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>jar</packaging>

	<name>spring-cloud-config-server-demo</name>
	<description>spring-cloud-config-server-demo</description>

	<parent>
		<groupId>org.springframework.cloud</groupId>
		<artifactId>spring-cloud-starter-parent</artifactId>
		<version>1.0.1.BUILD-SNAPSHOT</version>
		<relativePath /> <!-- lookup parent from repository -->
	</parent>

	<dependencies>
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-config-server</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-security</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
	</dependencies>

	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<start-class>demo.Application</start-class>
		<java.version>1.7</java.version>
	</properties>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>
	</build>

</project>
```
默认情况下，Config Server通过git加载配置文件，将profile设置为native，让其从本地文件加载配置
```yml
info:
  component: Config Server
spring:
  application:
    name: configserver
  profiles:
    active: native

server:
  port: 8888
management:
  context_path: /admin
  
security:
  user: 
    name: admin
    password: foo@bar
```
将具体配置放在config目录下，命名跟client端spring.application.name保持一致
```properties
foo=bar

spring.datasource.url=jdbc:mysql://localhost/demo
spring.datasource.username=root
spring.datasource.password=
spring.datasource.driver-class-name=com.mysql.jdbc.Driver

# JPA (JpaBaseConfiguration, HibernateJpaAutoConfiguration)
spring.jpa.openInView=true
spring.jpa.show-sql=true
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.database=mysql
```
通过@EnableConfigServer注解，开启ConfigServer
```java
@Configuration
@ComponentScan
@EnableAutoConfiguration
@EnableConfigServer
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

- 定制化客户端
