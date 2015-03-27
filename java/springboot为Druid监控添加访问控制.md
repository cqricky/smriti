- 修改application.properties
```properties
# application.properties
druid.stat.loginUsername=starwar
druid.stat.loginPassword=showmethemoney
```

- 修改数据源配置
```java
  	// DataSourceConfig.java
	@Value("${druid.stat.loginUsername}")
	private String loginUsername;

	@Value("${druid.stat.loginPassword}")
	private String loginPassword;
	
	
	@Bean(initMethod = "init", destroyMethod = "close")
	@ConfigurationProperties(prefix = "datasource.druid")
	public DataSource dataSource() {
		return new DruidDataSource();
	}
	
	@Bean
	public ServletRegistrationBean statViewServlet() {
		ServletRegistrationBean reg = new ServletRegistrationBean();
		reg.setServlet(new StatViewServlet());
		reg.addUrlMappings("/druid/*");
		reg.addInitParameter("loginUsername", loginUsername);
		reg.addInitParameter("loginPassword", loginPassword);

		return reg;
	}
```
