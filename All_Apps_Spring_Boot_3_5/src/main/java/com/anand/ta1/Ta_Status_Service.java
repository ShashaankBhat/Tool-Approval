package com.anand.ta1;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface Ta_Status_Service {

    List<Ta_Status> getStatusList(HttpServletRequest request, Integer offset);

    List<Ta_Status> getStatusByActiveStatus(Integer active);

    String saveStatusDetails(HttpServletRequest request, Ta_Status status);

    String getStatusDetails(HttpServletRequest request);

    List<Ta_Status_History> getStatusHistoryByStatusId(Long taStatusId);
}
