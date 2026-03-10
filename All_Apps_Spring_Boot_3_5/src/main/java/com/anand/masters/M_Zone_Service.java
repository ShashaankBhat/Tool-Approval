package com.anand.masters;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface M_Zone_Service {

	List<M_Zone> getZoneList(HttpServletRequest request, Integer offset);

	List<M_Zone> getZoneByActiveStatus(Integer zoneActive);

	String saveZoneDetails(HttpServletRequest request, M_Zone zone);

	String getZoneDetails(HttpServletRequest request);
}
