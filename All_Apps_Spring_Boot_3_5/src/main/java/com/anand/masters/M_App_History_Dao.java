package com.anand.masters;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_App_History_Dao extends JpaRepository<M_App_History, Long> {
}