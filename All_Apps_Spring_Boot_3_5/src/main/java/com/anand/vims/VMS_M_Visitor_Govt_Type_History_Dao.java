package com.anand.vims;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VMS_M_Visitor_Govt_Type_History_Dao extends JpaRepository<VMS_M_Visitor_Govt_Type_History, Long> {
}