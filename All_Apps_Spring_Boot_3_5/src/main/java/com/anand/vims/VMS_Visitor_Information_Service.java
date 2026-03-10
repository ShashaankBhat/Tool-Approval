package com.anand.vims;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

public interface VMS_Visitor_Information_Service {

	List<VMS_Visitor_Information> getVisitorInfoList(HttpServletRequest request, Integer offset);

	List<VMS_Visitor_Information> getVisitorYetToPunchOut(HttpServletRequest request);

    List<VMS_Visitor_Information> getVisitorInfoByActiveStatus(Integer visitorActive);

    String saveVisitorInfoDetails(HttpServletRequest request, VMS_Visitor_Information visitorInformation);

    String saveVisitorInfoDetails(HttpServletRequest request, VMS_Visitor visitor);

    String getVisitorInfoDetails(HttpServletRequest request);

    List<VMS_Visitor_Information> getVisitorInformation(HttpServletRequest request);

    String punchOutVisitor(HttpServletRequest request);

    List<VMS_Visitor_Information> getVisitorInfoList(VMS_Visitor_Information visitor, HttpServletRequest request, Integer getFlag);
}
