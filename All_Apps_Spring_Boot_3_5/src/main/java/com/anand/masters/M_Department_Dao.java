package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_Department_Dao extends JpaRepository<M_Department, Long> {

	/*@Query(value="select * from m_department order by m_department_id desc limit 20 offset ?", nativeQuery = true)
	List<M_Department> getDepartmentWithOffset(Integer offset);*/

	List<M_Department> findByDepartmentActive(Integer departmentActive);

	List<M_Department> findByDepartmentName(String departmentName);
}