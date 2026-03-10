package com.anand.ta;

import jakarta.servlet.http.HttpServletRequest;

public interface Ta_Approval_Service {

    void submitForApproval(Long toolRequestId, HttpServletRequest request);

    String approveToolRequest(Long toolRequestId, String remarks, HttpServletRequest request);

    String rejectToolRequest(Long toolRequestId, String remarks, HttpServletRequest request);

    String sendBackToolRequest(Long toolRequestId, String remarks, HttpServletRequest request);

    String getApprovalHistory(Long toolRequestId);
}
