## 添加maven依赖
```xml
    <dependency>
			<groupId>org.apache.shiro</groupId>
			<artifactId>shiro-spring</artifactId>
			<version>1.2.3</version>
		</dependency>
```
## configuration 文件
```java
@Configuration
@EnableAutoConfiguration
public class ShiroConfiguration {
	@Bean(name = "shiroFilter")
	public ShiroFilterFactoryBean shiroFilter() {
		ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
		Map<String, String> filterChainDefinitionMapping = new HashMap<String, String>();
		// Map<String, Filter> filters = new HashMap<String, Filter>();

		filterChainDefinitionMapping.put("/*", "authc");
		filterChainDefinitionMapping.put("/admin/*", "authc,roles[admin]");
		filterChainDefinitionMapping.put("/logout", "logout");

		shiroFilter.setLoginUrl("/login");
		shiroFilter.setSuccessUrl("/index");
		shiroFilter.setFilterChainDefinitionMap(filterChainDefinitionMapping);
		shiroFilter.setSecurityManager(securityManager());
		// shiroFilter.setFilters(filters);

		return shiroFilter;
	}

	@Bean(name = "securityManager")
	public DefaultWebSecurityManager securityManager() {
		final DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setRealm(shiroRealm());
		return securityManager;
	}

	@Bean(name = "shiroRealm")
	@DependsOn("lifecycleBeanPostProcessor")
	public MyAuthorizingRealm shiroRealm() {
		return new MyAuthorizingRealm();
	}

	@Bean(name = "lifecycleBeanPostProcessor")
	public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
		return new LifecycleBeanPostProcessor();
	}
}
```

## Ream
@Component
public class MyAuthorizingRealm extends AuthorizingRealm {

	/**
	 * 认证代码
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken auchcToken) throws AuthenticationException {
		if (auchcToken == null)
			throw new AuthenticationException("权限验证失败");

		UsernamePasswordToken token = (UsernamePasswordToken) auchcToken;

		if (StringUtils.isBlank(token.getUsername()))
			throw new AuthenticationException("用户名不能为空");

		return new SimpleAuthenticationInfo(token.getUsername(), token.getPassword(), getName());
	}

	/**
	 * 授权代码
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		if (principals == null)
			throw new AuthorizationException("principals 不能为空");

		String username = (String) getAvailablePrincipal(principals);

		SimpleAuthorizationInfo info = null;
		if (StringUtils.isNotBlank(username)) {
			info = new SimpleAuthorizationInfo();
			User user = getUserByUsername(username);

			Set<String> roles = new HashSet<String>();
			roles.add(user.getRoleName());
			info.setRoles(roles);

		}

		return info;
	}

	/**
	 * 获取用户信息 （这里只是方便测试，项目中以实际需求为准）
	 * 
	 * @param username
	 * @return
	 */
	private User getUserByUsername(String username) {

		String roleName = username.equals("admin") ? "admin" : "user";

		User user = new User();
		user.setUsername(username);
		user.setRoleName(roleName);
		return user;
	}
}

## Controller
@Controller
public class IndexController {

	@RequestMapping("/index")
	public String index() {
		return "index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String toLogin() {
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(AuthenticationToken token) {
		SecurityUtils.getSubject().login(token);
		return "fail";
	}

	@RequestMapping(value = "/logout")
	public String logout() {
		SecurityUtils.getSubject().logout();
		return "login";
	}

	@RequestMapping(value = "/admin/index")
	public String toAdmin() {
		return "admin";
	}
}

## 小结
>* Shiro不提供维护用户/权限，而是通过Realm让开发人员自己注入
>* Authentication：身份认证/登录，验证用户是不是拥有相应的身份
>* Authorization: 授权，包括授权角色/权限授权

-------
|Filter Name |	Class | 
|------|-----:|:----:|
|anon	| org.apache.shiro.web.filter.authc.AnonymousFilter |
|authc	| org.apache.shiro.web.filter.authc.FormAuthenticationFilter |
|authcBasic	| org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter |
|perms	| org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter |
|port	| org.apache.shiro.web.filter.authz.PortFilter |
|rest	| org.apache.shiro.web.filter.authz.HttpMethodPermissionFilter |
|roles	| org.apache.shiro.web.filter.authz.RolesAuthorizationFilter |
|ssl	| org.apache.shiro.web.filter.authz.SslFilter |
|user	| org.apache.shiro.web.filter.authc.UserFilter |
