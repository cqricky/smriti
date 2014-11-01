package demo.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import demo.model.Demo;
import demo.service.DemoService;

@RestController
@RequestMapping("/demo")
public class DemoController {
	@Autowired
	DemoService demoService;

	@RequestMapping("/all")
	public List<Demo> findAll() {
		return demoService.findAll();
	}
	
	@RequestMapping("/page")
	public Page<Demo> findAllDemo() {
		Pageable page = new PageRequest(0, 10);
		return demoService.findAll(page);
	}
}
