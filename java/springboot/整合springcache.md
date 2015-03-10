- 开启Caching
```java
//CacheConfig.java
@Configuration
@EnableCaching
public class CacheConfig {
	@Autowired
	JedisConnectionFactory jedisConnectionFactory;

	@Bean
	public RedisTemplate<Object, Object> redisTemplate() {
		RedisTemplate<Object, Object> redisTemplate = new RedisTemplate<Object, Object>();

		redisTemplate.setConnectionFactory(jedisConnectionFactory);

		return redisTemplate;
	}

	@Bean
	public RedisCacheManager redisCacheManager() {
		RedisCacheManager redisCacheManager = new RedisCacheManager(redisTemplate());

		return redisCacheManager;
	}
}
```

- 通过注解使用cache
```java
@Service
@Transactional
public class DemoService extends BaseService {
	@Autowired
	DemoMapper demoMapper;

	@Cacheable(value = "demoCache", key = "#id")
	public Demo findById(Long id) {

		return demoMapper.findById(id);
	}

	@CachePut(value = "demoCache", key = "#demo.id")
	public void update(Demo demo) {
		demoMapper.update(demo);
	}

	@CachePut(value = "demoCache", key = "#demo.id")
	public void save(Demo demo) {
		demoMapper.save(demo);
	}

	@CacheEvict(value = "demoCache", key = "#id")
	public void delete(Long id) {
		demoMapper.delete(id);
	}

	// 清空缓存
	@CacheEvict(value = "demoCache", allEntries = true)
	public void reload() {
		logger.info("CacheEvict for demoCache.");
	}
}
```
