package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_Designation_Dao extends JpaRepository<M_Designation, Long> {

	List<M_Designation> findByDesignationActive(Integer designationActive);

	List<M_Designation> findByDesignationName(String designationName);
}