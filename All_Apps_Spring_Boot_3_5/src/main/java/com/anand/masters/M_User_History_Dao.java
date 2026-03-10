package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_User_History_Dao extends JpaRepository<M_User_History, Long> {

	public M_User findByUserLoginId(String userLoginId);

	public List<M_User> findByUserActive(Integer userActive);

}
