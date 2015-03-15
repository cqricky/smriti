项目中经常碰到需要分布式锁的场景，以下尝试通过Redis实现分布式锁。

```java
public interface Lock {

	/**
	 * 获取锁,如果锁可用,立即返回true,否则返回false
	 * @param target
	 * @return
	 */
	public boolean tryLock(String target);
	
	/**
	 * 给定的等待时间内获取锁,如果锁可用,返回true,否则返回false
	 * @param target
	 * @param timeout
	 * @param unit
	 * @return
	 */
	public boolean tryLock(String target, long timeout, TimeUnit unit);
	
	/**
	 * 释放锁
	 * @param target
	 */
	public void unLock(String target);
}

```

```java
@Service
public class RedisLock implements Lock{
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	StringRedisTemplate stringRedisTemplate;
	
	private static final String LOCK_PREFIX = "fxt:lock:";
	private static final int LOCK_EXPIRE_SECONDS = 5;

	@Override
	public boolean tryLock(String target) {
		logger.info("try lock target: " + target);
		return tryLock(target,0L,TimeUnit.SECONDS);
	}

	@Override
	public boolean tryLock(String target, long timeout, TimeUnit unit) {
		if (StringUtils.isBlank(target)) {
			logger.info("try lock target fail,target is blank");
			return Boolean.FALSE;
		}
		
		long start = System.nanoTime();
		do {
			boolean success = setTarget(target);
			if (success) {
				//5秒后自动释放锁
				// TODO 如果获取锁后宕机，会导致死锁
				stringRedisTemplate.expire(LOCK_PREFIX + target, LOCK_EXPIRE_SECONDS, TimeUnit.SECONDS);
				
				logger.info("try lock target: " + target + " success.");
				return Boolean.TRUE;
			}
			
			try {
				TimeUnit.MILLISECONDS.sleep(100);
			} catch (InterruptedException e) {
				logger.warn(e.getMessage());
			}
		} while (System.nanoTime()-start<unit.toNanos(timeout));
		
		logger.info("try lock target: " + target + " fail,cause timeout.");
		return Boolean.FALSE;
	}
	
	private boolean setTarget(String target){
		return stringRedisTemplate.opsForValue().setIfAbsent(LOCK_PREFIX + target, System.currentTimeMillis()+"");
	}

	@Override
	public void unLock(String target) {
		logger.info("release lock, target :" + target);  
		stringRedisTemplate.delete(LOCK_PREFIX + target);
	}

	/**
	 * 定期检查并清理死锁
	 */
	//@PostConstruct
	public void init() {
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				Set<String> keys = stringRedisTemplate.keys(LOCK_PREFIX+"*");
				for (String key : keys) {
					String value = stringRedisTemplate.opsForValue().get(key);
					if (System.currentTimeMillis() - Long.parseLong(value)> 1000*60) {
						stringRedisTemplate.delete(key);
					}
				}
				
				try {
					TimeUnit.MINUTES.sleep(10);
				} catch (InterruptedException e) {
					logger.warn(e.getMessage());
				}
			}
		}).start();
	}
}
```
