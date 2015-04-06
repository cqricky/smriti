```shell
$ git clone https://github.com/spring-cloud/spring-cloud-config.git
$ mvn clean install

# Start the sample
$ cd spring-cloud-config-sample/target
$ java -jar spring-cloud-config-sample-1.0.0.RELEASE.jar

# Start the server
$ cd spring-cloud-config-server/target
$ java -jar spring-cloud-config-server-1.0.0.RELEASE.jar
$ curl localhost:8888/foo/development
{"name":"development","label":"master","propertySources":[
  {"name":"https://github.com/scratches/config-repo/foo-development.properties","source":{"bar":"spam"}},
  {"name":"https://github.com/scratches/config-repo/foo.properties","source":{"foo":"bar"}}
]}

# Start the sample
$ cd spring-cloud-config-sample/target
$ java -jar spring-cloud-config-sample-1.0.0.RELEASE.jar
$ curl localhost:8080/env
{
  "profiles":[],
  "configService:https://github.com/scratches/config-repo/bar.properties":{"foo":"bar"},
  "servletContextInitParams":{},
  "systemProperties":{...},
  ...
}
$ curl localhost:8080/env/foo
bar
```
