package com.anand.vims;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Service;
import com.google.gson.Gson;

@RestController
public class VisitorManagementRestController {

	@Autowired private VMS_M_Visitor_Type_Service vmsMVisitorTypeService;
	@Autowired private VMS_M_Visitor_Purpose_Service vmsMVisitorPurposeService;
	@Autowired private M_User_Service mUserService;
	@Autowired private VMS_Visitor_Information_Service vmsVisitorInformationService;

	@GetMapping("getVisitorTypeDetails")
	public String getAppDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = vmsMVisitorTypeService.getVisitorTypeDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreVisitorType")
	public String loadMoreVisitorType(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalAppList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<VMS_M_Visitor_Type> visitorTypeList = vmsMVisitorTypeService.getVisitorTypeList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(VMS_M_Visitor_Type visitorType : visitorTypeList) {
				Map<String, String> visitorTypeMap = new HashMap<String, String>();
				visitorTypeMap.put("visitorTypeName", visitorType.getVisitorTypeName());
				if(visitorType.getVisitorTypeActive().compareTo(1) == 0) {
					visitorTypeMap.put("visitorTypeActive","<span class='badge badge-success'>Active</span>");
				} else {
					visitorTypeMap.put("visitorTypeActive","<span class='badge badge-danger'>In-Active</span>");
				}
				visitorTypeMap.put("visitorTypeCreatedBy", visitorType.getVisitorTypeCreatedBy().getUserFirstName()+" "+visitorType.getVisitorTypeCreatedBy().getUserLastName());
				visitorTypeMap.put("visitorTypeCreatedOn", dateFormat.format(visitorType.getVisitorTypeCreatedOn()));
				if(visitorType.getVisitorTypeUpdatedBy() != null) {
					visitorTypeMap.put("visitorTypeUpdatedBy", visitorType.getVisitorTypeUpdatedBy().getUserFirstName()+" "+visitorType.getVisitorTypeUpdatedBy().getUserLastName());
					visitorTypeMap.put("visitorTypeUpdatedOn", dateFormat.format(visitorType.getVisitorTypeUpdatedOn()));
				} else {
					visitorTypeMap.put("visitorTypeUpdatedBy", "");
					visitorTypeMap.put("visitorTypeUpdatedOn", "");
				}
				visitorTypeMap.put("visitorTypeAction", visitorType.getActionForList());
				finalAppList.add(visitorTypeMap);
				visitorTypeMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalAppList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalAppList.clear(); finalAppList = null;
		return response.toString();
	}

	@GetMapping("getVisitorPurposeDetails")
	public String getVisitorPurposeDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = vmsMVisitorPurposeService.getVisitorPurposeDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreVisitorPurpose")
	public String loadMoreVisitorPurpose(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalAppList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<VMS_M_Visitor_Purpose> visitorPurposeList = vmsMVisitorPurposeService.getVisitorPurposeList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(VMS_M_Visitor_Purpose visitorPurpose : visitorPurposeList) {
				Map<String, String> visitorPurposeMap = new HashMap<String, String>();
				visitorPurposeMap.put("visitorPurposeName", visitorPurpose.getVisitorPurposeName());
				if(visitorPurpose.getVisitorPurposeActive().compareTo(1) == 0) {
					visitorPurposeMap.put("visitorPurposeActive","<span class='badge badge-success'>Active</span>");
				} else {
					visitorPurposeMap.put("visitorPurposeActive","<span class='badge badge-danger'>In-Active</span>");
				}
				visitorPurposeMap.put("visitorPurposeCreatedBy", visitorPurpose.getVisitorPurposeCreatedBy().getUserFirstName()+" "+visitorPurpose.getVisitorPurposeCreatedBy().getUserLastName());
				visitorPurposeMap.put("visitorPurposeCreatedOn", dateFormat.format(visitorPurpose.getVisitorPurposeCreatedOn()));
				if(visitorPurpose.getVisitorPurposeUpdatedBy() != null) {
					visitorPurposeMap.put("visitorPurposeUpdatedBy", visitorPurpose.getVisitorPurposeUpdatedBy().getUserFirstName()+" "+visitorPurpose.getVisitorPurposeUpdatedBy().getUserLastName());
					visitorPurposeMap.put("visitorPurposeUpdatedOn", dateFormat.format(visitorPurpose.getVisitorPurposeUpdatedOn()));
				} else {
					visitorPurposeMap.put("visitorPurposeUpdatedBy", "");
					visitorPurposeMap.put("visitorPurposeUpdatedOn", "");
				}
				visitorPurposeMap.put("visitorPurposeAction", visitorPurpose.getActionForList());
				finalAppList.add(visitorPurposeMap);
				visitorPurposeMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalAppList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalAppList.clear(); finalAppList = null;
		return response.toString();
	}

	@GetMapping("getUserbyEntity")
	public String getUserbyEntity(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalVisitorList = new ArrayList<Map<String, String>>();
		try {
			List<M_User> userList = mUserService.getUserByEntityId(Long.valueOf(request.getParameter("mEntityId")), request);
			System.out.println(userList);
			System.out.println(userList.size());
			for (M_User user : userList) {
				Map<String, String> userMap = new HashMap<String, String>();
				String fullName = user.getUserFirstName() + " " + user.getUserLastName();
				userMap.put("userName", fullName);
				userMap.put("userMobileNumber", user.getUserPhoneNumber());
				userMap.put("userId", String.valueOf(user.getmUserId()));
				finalVisitorList.add(userMap);
				userMap = null;
			}
			Gson gson = new Gson();
			response.append(gson.toJson(finalVisitorList));
			System.out.println(response);
			gson = null;
		} catch (Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalVisitorList.clear();
		finalVisitorList = null;
		return response.toString();
	}

	@GetMapping("visitor-out")
	public String punchOutVisitor(HttpServletRequest request) {
		try {
			System.out.println("1");
			return vmsVisitorInformationService.punchOutVisitor(request);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}