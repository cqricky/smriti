package demo.batch;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class BatchService {

	@Scheduled(cron = "0/5 * * * * ?")
	public void test() {
		System.out.println("xxx");
	}
}
