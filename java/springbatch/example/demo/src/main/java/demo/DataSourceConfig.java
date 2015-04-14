package demo;

import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.alibaba.druid.pool.DruidDataSource;

@Configuration
public class DataSourceConfig {

	@Bean(initMethod = "init", destroyMethod = "close")
	@ConfigurationProperties(prefix = "datasource.druid")
	public DataSource dataSource() {
		return new DruidDataSource();
	}

}
