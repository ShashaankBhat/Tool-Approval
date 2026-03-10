package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Business_Unit_Dao extends JpaRepository<Ta_Business_Unit, Long> {

    List<Ta_Business_Unit> findByTaBusinessUnitActive(Integer active);

    List<Ta_Business_Unit> findByTaBusinessUnitName(String name);

    List<Ta_Business_Unit> findByTaBusinessUnitNameAndTaBusinessUnitActive(String name, Integer active);

    Long countByTaBusinessUnitActive(Integer active);
}
