- 添加pom依赖
```xml
<!-- pom.xml -->
		<dependency>
			<groupId>org.springframework.session</groupId>
			<artifactId>spring-session-data-redis</artifactId>
			<version>1.0.0.RELEASE</version>
			<type>pom</type>
		</dependency>
```

- 配置链接信息
```
//application.properties
redis.hostName=xxx.xxx.xxx.xxx
redis.password=xxxxx
```

- JavaConfig
```java
@Configuration
@EnableCaching
public class CacheConfig {

	@Autowired
	JedisConnectionFactory jedisConnectionFactory;

	private static final StringRedisSerializer STRING_SERIALIZER = new StringRedisSerializer();

	@Bean
	public RedisTemplate<Object, Object> redisTemplate() {
		RedisTemplate<Object, Object> redisTemplate = new RedisTemplate<Object, Object>();

		redisTemplate.setConnectionFactory(jedisConnectionFactory);

		return redisTemplate;
	}

	@Bean
	public RedisTemplate<String, Long> longRedisTemplate() {

		RedisTemplate<String, Long> redisTemplate = new RedisTemplate<String, Long>();

		redisTemplate.setConnectionFactory(jedisConnectionFactory);
		redisTemplate.setKeySerializer(STRING_SERIALIZER);
		redisTemplate.setValueSerializer(LongSerializer.INSTANCE);

		return redisTemplate;
	}

	@Bean
	public RedisCacheManager redisCacheManager() {
		RedisCacheManager redisCacheManager = new RedisCacheManager(redisTemplate());

		return redisCacheManager;
	}
}
```
