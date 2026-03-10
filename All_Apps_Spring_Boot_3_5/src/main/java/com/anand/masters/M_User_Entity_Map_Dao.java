package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface M_User_Entity_Map_Dao extends JpaRepository<M_User_Entity_Map, Long> {

	List<M_User_Entity_Map> findByUserInfoForEntityAndEntityInfoForUsers(M_User userInfoForEntity, M_Entity entityInfoForUser);

	List<M_User_Entity_Map> findByUserInfoForEntity(M_User userInfoForEntity);

	List<M_User_Entity_Map> findByUserInfoForEntityAndUserEntityActive(M_User userInfoForEntity, Integer userEntityActive);

	@Query(value = "Select m_entity_id from ekayana.m_user_entity_map where m_user_id = ? LIMIT 1",nativeQuery = true)
    Long FindFirstEntityByUserInfoForEntity(M_User userInfoForEntity);
}