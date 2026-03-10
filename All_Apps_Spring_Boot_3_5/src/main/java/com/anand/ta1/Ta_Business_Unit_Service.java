package com.anand.ta1;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface Ta_Business_Unit_Service {

	List<Ta_Business_Unit> getBusinessUnitList(HttpServletRequest request, Integer offset);

	List<Ta_Business_Unit> getBusinessUnitByActiveStatus(Integer active);

	String saveBusinessUnitDetails(HttpServletRequest request, Ta_Business_Unit businessUnit);

	String getBusinessUnitDetails(HttpServletRequest request);

	List<Ta_Business_Unit_History> getBusinessUnitHistoryById(Long id);
}