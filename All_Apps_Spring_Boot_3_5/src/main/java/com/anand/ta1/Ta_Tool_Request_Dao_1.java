package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Tool_Request_Dao_1 extends JpaRepository<Ta_Tool_Request_1, Long> {

	List<Ta_Tool_Request_1> findByRequestActive(Integer active);

    List<Ta_Tool_Request_1> findByRequestNumber(String requestNumber);

    List<Ta_Tool_Request_1> findByEntityIdAndRequestActive(Ta_Business_Unit entityId, Integer active);
}
