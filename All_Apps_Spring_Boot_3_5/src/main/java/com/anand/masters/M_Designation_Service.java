package com.anand.masters;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface M_Designation_Service {

	List<M_Designation> getDesignationList(HttpServletRequest request, Integer offset);

	List<M_Designation> getDesignationByActiveStatus(Integer designationActive);

	String saveDesignationDetails(HttpServletRequest request, M_Designation designation);

	String getDesignationDetails(HttpServletRequest request);
}
