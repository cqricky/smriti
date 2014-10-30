下面是项目中一些常用的Configuration:
- Spring MVC
```java
    @Bean
    public DispatcherServlet dispatcherServlet() {
        return new DispatcherServlet();
    }
```
- CharacterEncoding
```java
    @Bean
    public CharacterEncodingFilter characterEncodingFilter() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding(characterEncoding);
        filter.setForceEncoding(true);
        return filter;
    }
```
- RestTemplate
```java
	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}
```
- Filter
```java
	  @Bean
    public FilterRegistrationBean appFilter() {
        FilterRegistrationBean reg = new FilterRegistrationBean();
        reg.setFilter(new AppFilter());
        reg.addUrlPatterns("/*");
        return reg;
    }
```
- MessageConverter
```java
	@Bean
	public StringHttpMessageConverter stringHttpMessageConverter() {
		StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter(
				Charset.forName(characterEncoding));
		return stringHttpMessageConverter;
	}
```
- JSON转换
```java
	@Bean
	public ObjectMapper jsonMapper(){
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));

		return objectMapper;
	}
```
- 数据源,以Druid为例
```java
	@Bean(initMethod="init",destroyMethod="close")
	@ConfigurationProperties(prefix="datasource.druid")
	public DataSource dataSource() {
		return new DruidDataSource();
	}

	@Value("${datasource.druid.allow}")
	private String druidAllowUrl;

	@Value("${datasource.druid.deny}")
	private String druidDenyUrl;
	
	@Bean
	public ServletRegistrationBean statViewServlet() {
		ServletRegistrationBean reg = new ServletRegistrationBean();
		reg.setServlet(new StatViewServlet());
		reg.addUrlMappings("/druid/*");
		reg.addInitParameter("allow", druidAllowUrl);
		reg.addInitParameter("deny", druidDenyUrl);

		return reg;
	}
```
```properties
##application.properties
datasource.druid.url=jdbc:oracle:thin:@192.168.1.111:1521:xxx
datasource.druid.username=xxx
datasource.druid.password=xxx
datasource.druid.filters=stat
datasource.druid.allow=192.168.0.1/24,192.168.0.212
datasource.druid.deny=192.168.200.1/24
```
- RequestContextListener
```java
	@Bean
	public RequestContextListener requestContextListener(){
	    RequestContextListener requestContextListener = new RequestContextListener();

	    return requestContextListener;
	}
```

