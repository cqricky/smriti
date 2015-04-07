package demo.web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/demo")
public class DemoController {

	@Value("${foo:xxxx}")
	String foo;

	@RequestMapping("/")
	public String index() {
		return foo;
	}
}
