package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface Ta_Approval_Matrix_History_Dao extends JpaRepository<Ta_Approval_Matrix_History, Long> {
	List<Ta_Approval_Matrix_History> findByTaApprovalMatrixId(Ta_Approval_Matrix taApprovalMatrixId);
}
