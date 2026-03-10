package com.anand.ta;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Ta_Approval_Action_Dao extends JpaRepository<Ta_Approval_Action, Long> {

    List<Ta_Approval_Action> findByToolRequest_TaToolRequestId(Long taToolRequestId);

}
