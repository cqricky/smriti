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

	// 加入缓存
	@Cacheable(value = "demoCache", key = "#id")
	public Demo findById(Long id) {

		return demoMapper.findById(id);
	}

	// 直接从缓存删除
	@CacheEvict(value = "demoCache", key = "#demo.id")
	// 也可以更新缓存，但是务必保证方法返回值为Demo，且主键不为空
	// @CachePut(value = "demoCache", key = "#demo.id")
	public Demo update(Demo demo) {
		demo.setUpdatedAt(new Date());

		demoMapper.update(demo);

		return demo;
	}

	// 如果使用@CachePut，请保证方法返回值为Demo，且主键不为空
	// @CachePut(value = "demoCache", key = "#demo.id")
	public Demo save(Demo demo) {
		Date curDate = new Date();
		demo.setCreatedAt(curDate);
		demo.setUpdatedAt(curDate);
		
		demoMapper.save(demo);

		return demo;
	}

	// 清空缓存
	@CacheEvict(value = "demoCache", key = "#id")
	public void delete(Long id) {
		demoMapper.delete(id);
	}

	// 清空所有缓存
	@CacheEvict(value = "demoCache", allEntries = true)
	public void reload() {
		logger.info("CacheEvict for demoCache.");
	}
}
```
