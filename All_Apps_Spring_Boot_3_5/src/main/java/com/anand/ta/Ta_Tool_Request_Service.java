package com.anand.ta;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;

public interface Ta_Tool_Request_Service {

    /* Existing */
    List<Ta_Tool_Request> getRequestList(HttpServletRequest request);

    String createToolRequest(HttpServletRequest request,
                             Ta_Tool_Request toolRequest,
                             String actionType);

    String updateToolRequest(HttpServletRequest request,
                             Ta_Tool_Request toolRequest,
                             String actionType);

    String getToolRequestDetails(HttpServletRequest request);

    /* 🔹 ADDED FOR VIEW PAGES (READ-ONLY) */
    Ta_Tool_Request getToolRequestById(Long reqId);

    List<Ta_Tool_Request> getAllToolRequestsForView(HttpServletRequest request);
}
