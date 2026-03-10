package com.anand.masters;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_User_Role_Map_History_Dao extends JpaRepository<M_User_Role_Map_History, Long> {
}