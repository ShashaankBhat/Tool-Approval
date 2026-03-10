package com.anand.ta;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface Ta_Tool_Cost_Details_Service {

    List<Ta_Tool_Cost_Details> getCostDetails(Long toolRequestId);

    String saveCostDetails(HttpServletRequest request,
                           Long toolRequestId,
                           List<Ta_Tool_Cost_Details> costDetailsList,
                           String actionType);
}
