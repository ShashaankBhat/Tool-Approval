package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_Zone_Dao extends JpaRepository<M_Zone, Long> {

	List<M_Zone> findByZoneActive(Integer zoneActive);

	List<M_Zone> findByZoneName(String zoneName);
}