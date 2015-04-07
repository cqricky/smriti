package demo.web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/demo")
public class DemoController {

	@Value("${foo:xxxx}")
	String foo;

	@Value("${spring.datasource.url}")
	String datasourceUrl;

	@RequestMapping("/")
	public String index() {
		return datasourceUrl;
	}
}
