package com.anand.masters;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface M_Department_Service {

	List<M_Department> getDepartmentList(HttpServletRequest request, Integer offset);

	List<M_Department> getDepartmentByActiveStatus(Integer departmentActive);

	String saveDepartmentDetails(HttpServletRequest request, M_Department department);

	String getDepartmentDetails(HttpServletRequest request);
}