package demo.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import demo.model.Demo;

public interface DemoRepository extends PagingAndSortingRepository<Demo, Long> {

}
