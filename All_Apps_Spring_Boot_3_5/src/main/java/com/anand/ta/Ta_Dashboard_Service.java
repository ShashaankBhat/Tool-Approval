package com.anand.ta;

import jakarta.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Service for Tool Approval dashboard metrics and reporting
 */
public interface Ta_Dashboard_Service {
    
    /**
     * Get count of tool requests by status
     * @param request HTTP request for security context
     * @return Map of status name to count
     */
    Map<String, Long> getRequestCountByStatus(HttpServletRequest request);
    
    /**
     * Get count of pending approvals by role
     * @param request HTTP request for security context
     * @return Map of role name to pending count
     */
    Map<String, Long> getPendingApprovalsByRole(HttpServletRequest request);
    
    /**
     * Get total approval turnaround time metrics
     * @param request HTTP request for security context
     * @return Map with avgTurnaroundDays, minTurnaroundDays, maxTurnaroundDays
     */
    Map<String, Double> getApprovalTurnaroundMetrics(HttpServletRequest request);
    
    /**
     * Get approval rate metrics
     * @param request HTTP request for security context
     * @return Map with totalRequests, approvedRequests, rejectedRequests, approvalRate(%)
     */
    Map<String, Object> getApprovalRateMetrics(HttpServletRequest request);
    
    /**
     * Get requests pending with specific user
     * @param userId User ID
     * @return List of tool requests awaiting user's approval
     */
    List<Ta_Tool_Request> getPendingRequestsForUser(Long userId);
    
    /**
     * Get requests by date range
     * @param fromDate Start date
     * @param toDate End date
     * @return List of tool requests created in date range
     */
    List<Ta_Tool_Request> getRequestsByDateRange(Date fromDate, Date toDate);
    
    /**
     * Get requests by plant/entity
     * @param entityId Entity ID
     * @return List of tool requests for specific entity
     */
    List<Ta_Tool_Request> getRequestsByEntity(Long entityId);
    
    /**
     * Get average approval time in days
     * @return Number of days for average approval
     */
    Double getAverageApprovalTime();
    
    /**
     * Get all active tool approval requests
     * @return List of all active tool requests
     */
    List<Ta_Tool_Request> getAllActiveRequests();
    
    /**
     * Get tool request by ID
     * @param taToolRequestId Request ID
     * @return Tool request entity
     */
    Ta_Tool_Request getToolRequestById(Long taToolRequestId);
    
    /**
     * Get cost details for a tool request
     * @param taToolRequestId Request ID
     * @return List of cost details for the request
     */
    List<Ta_Tool_Cost_Details> getCostDetailsForRequest(Long taToolRequestId);
}
