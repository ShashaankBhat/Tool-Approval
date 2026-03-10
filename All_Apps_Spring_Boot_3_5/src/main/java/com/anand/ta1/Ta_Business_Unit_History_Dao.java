package com.anand.ta1;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Ta_Business_Unit_History_Dao  extends JpaRepository<Ta_Business_Unit_History, Long> {

	List<Ta_Business_Unit_History> findByTaBusinessUnit_TaBusinessUnitId(Long taBusinessUnitId);
}
