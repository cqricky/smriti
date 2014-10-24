在实际的开发过程中，我们经常碰到跨域访问，情况很多，如：
* 与其他公司的模块对接
* 项目的分层设计

Ajax跨域访问普通的解决方式可以采用jsonp形式，如：
```
$.ajax({
         type : "post",
         async:true,
	 url : vurl,
	 dataType : "jsonp",
	timeout:10000,// 超时10秒
	contentType : "application/x-www-form-urlencoded; charset=utf-8",  
	success : function(data,textStatus){
			
	}
});
```

该方式访问，会在客户端请求时浏览器自动带上callback参数，服务器端再根据该callback参数，拼装返回结果，如java的servlet代码：
```
String callback = request.getParameter("callback");
String json = 返回数据;
PrintWriter out = response.getWriter();
out.write(callback + "(" + json + ")");
if (out != null) {
	out.close();
}
```

服务器返回的代码示例：
```
jQuery1111012659700540825725_1414128060897({"data":null,"id":0,"code":0,"msg":null})
```

该种跨域访问实现需要客户端及服务器端配合，如果是与其他公司衔接，这种方式并不可取，因为对方不会带上callback 参数。


另外一种解决跨域方式利用nginx的反向代理，就是把请求地址和服务器的地址都代理到同一个域名下，这样就变成了在一个域名下方式，ajax访问时就可以用普通方式访问。配置也相当简单，范例如下：
```
server {
        listen       80;
        server_name  localhost;



        location ~ ^/api/{ 
	 proxy_pass              http://目标服务器的地址(如：11.11.11.11:8081); 
         proxy_redirect          off; 
         proxy_set_header        X-Real-IP       目标服务器的IP(如：11.11.11.11); 
	}

	location ~ ^/test/{ 
	 proxy_pass              http://请求服务器的IP(如：22.22.22.22:8082); 
         proxy_redirect          off; 
         proxy_set_header        X-Real-IP       请求服务器的IP(如：22.22.22.22); 
	}

```

此时本地的请求地址变为：
```
localhost/test
```

访问的远程服务器地址变为：
```
localhost/api
```

ajax的代码访问直接以普通的json访问，示例如下：
```
$.ajax({
         type : "post",
         async:true,
	 url : vurl,
	 dataType : "json",
	timeout:10000,// 超时10秒
	contentType : "application/x-www-form-urlencoded; charset=utf-8",  
	success : function(data,textStatus){
			
	}
});
```

