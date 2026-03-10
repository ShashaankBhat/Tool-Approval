package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_Location_Dao extends JpaRepository<M_Location, Long> {

	/*@Query(value="select * from m_location order by m_location_id desc limit 20 offset ?", nativeQuery = true)
	List<M_Location> getLocationListWithOffset(Integer offset);*/

	List<M_Location> findByLocationActive(Integer locationActive);

	List<M_Location> findByLocationName(String locationName);
}