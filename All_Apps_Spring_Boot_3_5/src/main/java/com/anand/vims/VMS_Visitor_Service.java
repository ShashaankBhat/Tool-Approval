package com.anand.vims;

import jakarta.servlet.http.HttpServletRequest;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Entity_Map;

import java.util.List;

public interface VMS_Visitor_Service {

	List<VMS_Visitor> getVisitorList(HttpServletRequest request, Integer offset);

	List<VMS_Visitor> getVisitorByActiveStatus(Integer visitorActive);

	String saveVisitorDetails(HttpServletRequest request, VMS_Visitor visitor) throws Exception;

	String getVisitorDetails(HttpServletRequest request);

	String saveUserRegistraiton(HttpServletRequest request, M_User user);

	VMS_Visitor getAppointmentInformationUsingId(HttpServletRequest request);

	void sendVisitingInformationEmail(Long visitorId, HttpServletRequest request);

	List <VMS_Visitor> passVisitorListAccordingToRole(HttpServletRequest request,Long entity, String date, Long userId);

	List <VMS_Visitor>getVisitorList(VMS_Visitor visitor, HttpServletRequest request);

	List<M_User_Entity_Map> getUserEntityForMapping(HttpServletRequest request);

	void sendNotificationToHost(Long visitorId, HttpServletRequest request);
}