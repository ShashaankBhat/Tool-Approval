package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_User_Role_Map_Dao extends JpaRepository<M_User_Role_Map, Long> {

	List<M_User_Role_Map> findByUserInfoForRoleAndRoleInfoForUsers(M_User userInfoForRole, M_Role roleInfoForUser);

	List<M_User_Role_Map> findByRoleInfoForUsersAndUserRoleActive(M_Role roleInfoForUser, Integer userRoleActive);

	List<M_User_Role_Map> findByUserInfoForRole(M_User userInfoForRole);
}