package demo.batch;

import java.util.Date;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.JobParametersValidator;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class BatchService {

	@Autowired
	JobLauncher jobLauncher;

	@Autowired
	JobBuilderFactory jobs;

	@Autowired
	Step s1;

	JobParametersBuilder jobParametersBuilder = new JobParametersBuilder();

	@Scheduled(cron = "0/5 * * * * ?")
	public void test() throws JobExecutionAlreadyRunningException, JobRestartException, JobInstanceAlreadyCompleteException, JobParametersInvalidException {
		System.out.println("-----------------------------------------------------------------------------");
		Job job = jobs.get("importUserJob").listener(new JobExecutionListener() {

			@Override
			public void beforeJob(JobExecution jobExecution) {
				System.out.println("beforeJob");
				System.out.println(jobExecution.toString());
				System.out.println(jobExecution.getJobParameters());
			}

			@Override
			public void afterJob(JobExecution jobExecution) {
				System.out.println("afterJob");
				System.out.println(jobExecution.toString());
				System.out.println(jobExecution.getJobParameters());
			}
		}).validator(new JobParametersValidator() {

			@Override
			public void validate(JobParameters parameters) throws JobParametersInvalidException {
				System.out.println("parameters:" + parameters);
			}
		}).incrementer(new RunIdIncrementer()).flow(s1).end().build();

		JobExecution result = jobLauncher.run(job, jobParametersBuilder.addDate("time", new Date()).toJobParameters());
		System.out.println("result:" + result);
		System.out.println("-----------------------------------------------------------------------------");
	}
}
