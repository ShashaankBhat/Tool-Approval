package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Status_Dao extends JpaRepository<Ta_Status, Long> {

	List<Ta_Status> findByTaStatusActive(Integer active);

    List<Ta_Status> findByTaStatusName(String name);

    List<Ta_Status> findByTaStatusNameAndTaStatusActive(String name, Integer active);
}
