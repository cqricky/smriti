- 发布/订阅
```java
public class Msg extends BaseModel {

	private static final long serialVersionUID = 5675243762635682256L;

	private String id;

	private String msg;

	public Msg() {
	}

	public Msg(String id, String msg) {
		this.id = id;
		this.msg = msg;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}

@Service
public class TestService {

	@Autowired
	RedisTemplate<String, Msg> msgRedisTemplate;

	@Scheduled(cron = "0/5 * * * * ?")
	public void test() {
		msgRedisTemplate.convertAndSend("pub.xxx", new Msg(RandomStringUtils.randomAlphabetic(10), RandomStringUtils.randomAlphabetic(10)));
	}

}

@Configuration
public class MsgConfig {

	@Autowired
	RedisConnectionFactory connectionFactory;

	@Bean
	RedisTemplate<String, Msg> msgRedisTemplate() {
		RedisTemplate<String, Msg> msgRedisTemplate = new RedisTemplate<String, Msg>();

		msgRedisTemplate.setConnectionFactory(connectionFactory);
		msgRedisTemplate.setKeySerializer(new StringRedisSerializer());
		msgRedisTemplate.setValueSerializer(new JdkSerializationRedisSerializer());

		return msgRedisTemplate;
	}

	@Bean
	RedisMessageListenerContainer container() {
		RedisMessageListenerContainer container = new RedisMessageListenerContainer();
		container.setConnectionFactory(connectionFactory);
		// container.addMessageListener(messageListenerAdapter(), new ChannelTopic("pub.xxx"));
		container.addMessageListener(messageListenerAdapter(), new PatternTopic("pub.*"));

		return container;
	}

	@Bean
	MessageListenerAdapter messageListenerAdapter() {
		MessageListenerAdapter messageListenerAdapter = new MessageListenerAdapter(new Object() {

			@SuppressWarnings("unused")
			public void handleMessage(Msg msg) {
				System.out.println(msg);
			}

		});

		messageListenerAdapter.setSerializer(new JdkSerializationRedisSerializer());

		return messageListenerAdapter;
	}
}
```
- 消息队列
```

```
