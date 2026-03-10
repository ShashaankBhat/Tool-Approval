package com.anand.masters;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface M_Location_Service {

	List<M_Location> getLocationList(HttpServletRequest request, Integer offset);

	List<M_Location> getLocationByActiveStatus(Integer locationActive);

	String saveLocationDetails(HttpServletRequest request, M_Location location);

	String getLocationDetails(HttpServletRequest request);
}
