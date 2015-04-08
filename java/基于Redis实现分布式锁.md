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
	RedisTemplate<String, Long> longRedisTemplate;

	private static final String LOCK_PREFIX = "lock:";
	private static final long LOCK_EXPIRE_SECONDS = 5;

	private final RedisScript<Boolean> lockScript = new RedisScript<Boolean>() {

		private final String script = "local setResult = redis.call('SETNX',KEYS[1],ARGV[1]);if setResult == 1 then redis.call('EXPIRE',KEYS[1],ARGV[2]) end;return setResult;";

		@Override
		public String getSha1() {
			return DigestUtils.sha1DigestAsHex(script);
		}

		@Override
		public Class<Boolean> getResultType() {
			return Boolean.class;
		}

		@Override
		public String getScriptAsString() {
			return script;
		}
	};

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
		
		long start = System.currentTimeMillis();
		long timeoutMilliSeconds = TimeUnit.MILLISECONDS.convert(timeout, unit);
		long end = start + timeoutMilliSeconds;

		do {
			boolean success = setTarget(target);
			if (success) {
				logger.info("try lock target: " + target + " success.");
				return Boolean.TRUE;
			}
			
			if (timeout <= 0) {
				return Boolean.FALSE;
			}

			try {
				TimeUnit.MILLISECONDS.sleep(100);
			} catch (InterruptedException e) {
				logger.warn(e.getMessage());
			}
		} while (System.currentTimeMillis() < end);

		logger.info("try lock target: " + target + " fail,cause timeout.");
		return Boolean.FALSE;
	}
	
	private boolean setTarget(String target){
		return longRedisTemplate.execute(lockScript, Lists.newArrayList(LOCK_PREFIX + target), System.currentTimeMillis(), LOCK_EXPIRE_SECONDS);
	}

	@Override
	public void unLock(String target) {
		logger.info("release lock, target :" + target);  
		longRedisTemplate.delete(LOCK_PREFIX + target);
	}

}
```
