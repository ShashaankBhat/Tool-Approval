package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface M_Entity_Dao extends JpaRepository<M_Entity, Long> {

	/*@Query(value="select * from m_entity order by m_entity_id desc limit 30 offset ?", nativeQuery = true)
	List<M_Entity> getEntityListWithOffset(Integer offset);*/

	List<M_Entity> findByEntitySourceAndLocationId(M_Entity entitySource, M_Location locationId);

	List<M_Entity> findByEntityNameAndEntitySourceAndLocationId(String entityName, M_Entity entitySource, M_Location locationId);

	List<M_Entity> findByEntityActive(Integer entityActive);

	List<M_Entity> findByEntityName(String entityName);

	List<M_Entity> findByEntitySourceAndEntityActive(M_Entity entitySource, Integer entityActive);

	List<M_Entity> findByEntityActiveAndEntitySourceIsNotNull(Integer entityActive);

	List<M_Entity> findByEntitySourceAndEntityAcronym(M_Entity entitySource, String entityAcronym);

	List<M_Entity> findByEntitySourceAndEntityName(M_Entity entitySource, String entityName);

	@Query(value="select * from m_entity order by m_entity_id", nativeQuery = true)
	List<M_Entity> getEntityList();
}