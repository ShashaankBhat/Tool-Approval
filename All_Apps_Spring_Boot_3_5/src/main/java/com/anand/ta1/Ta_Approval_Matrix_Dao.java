package com.anand.ta1;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface Ta_Approval_Matrix_Dao extends JpaRepository<Ta_Approval_Matrix, Long> {
	List<Ta_Approval_Matrix> findByMatrixActive(Integer matrixActive);

	List<Ta_Approval_Matrix> findByApprovalMatrixForBusinessUnit(Ta_Business_Unit approvalMatrixForBusinessUnit);
}
