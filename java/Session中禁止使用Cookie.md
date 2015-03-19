打开项目WebRoot目录下的META-INF文件夹,编辑context.xml,内容如下:
```xml
<!-- /META-INF/context.xml -->
<?xml version='1.0' encoding='UTF-8'?>
<Context path="/sessionWeb"cookies="false">
</Context>
```
或者修改Tomcat全局的conf/context.xml,内容如下:
```xml
<!-- context.xml -->
<!-- The contents of this file will be loaded for eachweb application -->
<Context cookies="false">
    <!-- ...  -->
</Context>
部署后TOMCAT便不会自动生成名JSESSIONID的Cookie，Session也不会以Cookie为识别标志，而仅仅以重写后的URL地址为识别标志了。

注意：该配置只是禁止Session使用Cookie作为识别标志，并不能阻止其他的Cookie读写。也就是说服务器不会自动维护名为JSESSIONID的Cookie了，但是程序中仍然可以读写其他的Cookie。
