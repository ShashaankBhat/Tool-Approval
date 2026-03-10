package com.anand.ta1;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface Ta_Approval_Matrix_Service {

    List<Ta_Approval_Matrix> getApprovalMatrixList(HttpServletRequest request, Integer offset);

    List<Ta_Approval_Matrix> getApprovalMatrixByActiveStatus(Integer active);

    String saveApprovalMatrixDetails(HttpServletRequest request, Ta_Approval_Matrix matrix);

    String getApprovalMatrixDetails(HttpServletRequest request);

    List<Ta_Approval_Matrix_History> getApprovalMatrixHistoryByTaApprovalMatrixId(Long taStatusId);
}
