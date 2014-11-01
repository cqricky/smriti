package demo.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import demo.model.Demo;
import demo.repository.DemoRepository;

@Service
@Transactional
public class DemoService {
	private final JdbcTemplate jdbcTemplate;
	private final DemoRepository demoRepository;
	
	@Autowired
	public DemoService(JdbcTemplate jdbcTemplate,DemoRepository demoRepository) {
		this.jdbcTemplate = jdbcTemplate;
		this.demoRepository = demoRepository;
		
	}
	
	public List<Demo> findAll(){
		return jdbcTemplate.query("select * from demo", new RowMapper<Demo>() {

			@Override
			public Demo mapRow(ResultSet rs, int arg1) throws SQLException {
				Demo demo = new Demo();
				demo.setId(rs.getLong("id"));
				demo.setName(rs.getString("name"));
				demo.setCreateTime(rs.getDate("create_time"));
				
				return demo;
			}
			
		});
	}
	
	public Page<Demo> findAll(Pageable page){
		return  demoRepository.findAll(page);
	}
}