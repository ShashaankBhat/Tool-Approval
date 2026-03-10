package com.anand.ta1;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface Ta_Recovery_Type_Service {

    List<Ta_Recovery_Type> getRecoveryTypeList(HttpServletRequest request, Integer offset);

    List<Ta_Recovery_Type> getRecoveryTypeByActiveStatus(Integer active);

    String saveRecoveryTypeDetails(HttpServletRequest request, Ta_Recovery_Type recoveryType);

    String getRecoveryTypeDetails(HttpServletRequest request);

    List<Ta_Recovery_Type_History> getRecoveryTypeHistoryById(Long id);
}
