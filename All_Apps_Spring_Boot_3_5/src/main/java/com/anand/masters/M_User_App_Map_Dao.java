package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_User_App_Map_Dao extends JpaRepository<M_User_App_Map, Long> {

	List<M_User_App_Map> findByUserInfoForAppAndAppInfoForUsers(M_User userInfoForApp, M_App appInfoForUser);
}