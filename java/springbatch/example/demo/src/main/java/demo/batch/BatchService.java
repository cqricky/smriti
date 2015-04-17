package demo.batch;

import java.util.Date;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class BatchService {

	@Autowired
	Job job;

	@Autowired
	JobLauncher jobLauncher;

	JobParametersBuilder jobParametersBuilder = new JobParametersBuilder();

	@Scheduled(cron = "0/5 * * * * ?")
	public void test() throws JobExecutionAlreadyRunningException, JobRestartException, JobInstanceAlreadyCompleteException, JobParametersInvalidException {
		JobExecution result = jobLauncher.run(job, jobParametersBuilder.addDate("time", new Date()).toJobParameters());

		System.out.println(result);
	}
}
