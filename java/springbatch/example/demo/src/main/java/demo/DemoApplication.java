package demo;

import org.springframework.boot.SpringApplication;

public class DemoApplication {

    public static void main(String[] args) {
		System.exit(SpringApplication.exit(SpringApplication.run(BatchConfiguration.class, args)));
    }
}
