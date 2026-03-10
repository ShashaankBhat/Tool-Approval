package com.anand.masters;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

@RestController
public class MastersRestController {

	@Autowired private M_Zone_Service mZoneService;
	@Autowired private M_Location_Service mLocationService;
	@Autowired private M_Department_Service mDepartmentService;
	@Autowired private M_Designation_Service mDesignationService;
	@Autowired private M_Mail_Configuration_Service mMailConfigurationService;
	@Autowired private M_Role_Service mRoleService;
	@Autowired private M_Entity_Service mEntityService;
	@Autowired private M_User_Service mUserSerivce;
	@Autowired private M_App_Service mAppService;
	@Autowired private M_App_Dump_Service mAppDumpService;
	@Autowired private M_Member_Level_Service mMemberLevelService;

	@GetMapping("checkUserExists")
	public String checkUserExists(HttpServletRequest request) {
		String response = "";
		try {
			response = mUserSerivce.checkUserExists(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("getZoneDetails")
	public String getZoneDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mZoneService.getZoneDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreZone")
	public String loadMoreZone(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalZoneList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_Zone> zoneList = mZoneService.getZoneList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			System.out.println("zoneList : "+zoneList.size());
			for(M_Zone zone : zoneList) {
				Map<String, String> zoneMap = new HashMap<String, String>();
				zoneMap.put("zoneName", zone.getZoneName());
				if(zone.getZoneActive().compareTo(1) == 0) {
					zoneMap.put("zoneActive","<span class='badge badge-success'>Active</span>");
				} else {
					zoneMap.put("zoneActive","<span class='badge badge-danger'>In-Active</span>");
				}
				zoneMap.put("zoneCreatedBy", zone.getmUserId().getUserFirstName()+" "+zone.getmUserId().getUserLastName());
				zoneMap.put("zoneCreatedOn", dateFormat.format(zone.getCreatedOn()));
				if(zone.getmUserIdUpdated() != null) {
					zoneMap.put("zoneUpdatedBy", zone.getmUserIdUpdated().getUserFirstName()+" "+zone.getmUserIdUpdated().getUserLastName());
					zoneMap.put("zoneUpdatedOn", dateFormat.format(zone.getUpdatedOn()));
				} else {
					zoneMap.put("zoneUpdatedBy", "");
					zoneMap.put("zoneUpdatedOn", "");
				}
				zoneMap.put("zoneAction", zone.getActionForList());
				finalZoneList.add(zoneMap);
				zoneMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalZoneList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalZoneList.clear(); finalZoneList = null;
		return response.toString();
	}

	@GetMapping("getLocationDetails")
	public String getLocationDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mLocationService.getLocationDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreLocation")
	public String loadMoreLocation(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalEntityList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_Location> locationList = mLocationService.getLocationList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_Location location : locationList) {
				Map<String, String> locationMap = new HashMap<String, String>();
				locationMap.put("locationName", location.getLocationName());
				locationMap.put("locationZone", location.getmZoneId().getZoneName());
				if(location.getLocationActive().compareTo(1) == 0) {
					locationMap.put("locationActive","<span class='badge badge-success'>Active</span>");
				} else {
					locationMap.put("locationActive","<span class='badge badge-danger'>In-Active</span>");
				}
				locationMap.put("locationCreatedBy", location.getmUserId().getUserFirstName()+" "+location.getmUserId().getUserLastName());
				locationMap.put("locationCreatedOn", dateFormat.format(location.getCreatedOn()));
				if(location.getmUserIdUpdated() != null) {
					locationMap.put("locationUpdatedBy", location.getmUserIdUpdated().getUserFirstName()+" "+location.getmUserIdUpdated().getUserLastName());
					locationMap.put("locationUpdatedOn", dateFormat.format(location.getUpdatedOn()));
				} else {
					locationMap.put("locationUpdatedBy", "");
					locationMap.put("locationUpdatedOn", "");
				}
				locationMap.put("locationAction", location.getActionForList());
				finalEntityList.add(locationMap);
				locationMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalEntityList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalEntityList.clear(); finalEntityList = null;
		return response.toString();
	}

	@GetMapping("getDepartmentDetails")
	public String getDepartmentDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mDepartmentService.getDepartmentDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreDepartment")
	public String loadMoreDepartment(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalDepartmentList = new ArrayList<Map<String, String>>();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd-MMM-yyyy");
		try {
			List<M_Department> departmentList = mDepartmentService.getDepartmentList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_Department department : departmentList) {
				Map<String, String> departmentMap = new HashMap<String, String>();
				departmentMap.put("departmentName", department.getDepartmentName());
				departmentMap.put("departmentDescription", department.getDepartmentDescription());
				if(department.getDepartmentActive().compareTo(1) == 0) {
					departmentMap.put("departmentActive","<span class='badge badge-success'>Active</span>");
				} else {
					departmentMap.put("departmentActive","<span class='badge badge-danger'>In-Active</span>");
				}
				departmentMap.put("departmentCreatedBy", department.getmUserId().getUserFirstName()+" "+department.getmUserId().getUserLastName());
				departmentMap.put("departmentCreatedOn", dateFormatter.format(department.getCreatedOn()));
				if(department.getmUserIdUpdate() != null) {
					departmentMap.put("departmentUpdatedBy", department.getmUserIdUpdate().getUserFirstName()+" "+department.getmUserIdUpdate().getUserLastName());
					departmentMap.put("departmentUpdatedOn", dateFormatter.format(department.getUpdatedOn()));
				} else {
					departmentMap.put("departmentUpdatedBy", "");
					departmentMap.put("departmentUpdatedOn", "");
				}
				departmentMap.put("departmentAction", department.getActionForList());
				finalDepartmentList.add(departmentMap);
				departmentMap = null;
			}
			departmentList.clear(); departmentList = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalDepartmentList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		dateFormatter = null;
		finalDepartmentList.clear(); finalDepartmentList = null;
		return response.toString();
	}

	@GetMapping("getDesignationDetails")
	public String getDesignationDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mDesignationService.getDesignationDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreDesignation")
	public String loadMoreDesignation(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalDesignationList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_Designation> designationList = mDesignationService.getDesignationList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_Designation designation : designationList) {
				Map<String, String> designationMap = new HashMap<String, String>();
				designationMap.put("designationName", designation.getDesignationName());
				if(designation.getDesignationActive().compareTo(1) == 0) {
					designationMap.put("designationActive","<span class='badge badge-success'>Active</span>");
				} else {
					designationMap.put("designationActive","<span class='badge badge-danger'>In-Active</span>");
				}
				designationMap.put("designationCreatedBy", designation.getmUserId().getUserFirstName()+" "+designation.getmUserId().getUserLastName());
				designationMap.put("designationCreatedOn", dateFormat.format(designation.getCreatedOn()));
				if(designation.getmUserIdUpdate() != null) {
					designationMap.put("designationUpdatedBy", designation.getmUserIdUpdate().getUserFirstName()+" "+designation.getmUserIdUpdate().getUserLastName());
					designationMap.put("designationUpdatedOn", dateFormat.format(designation.getUpdatedOn()));
				} else {
					designationMap.put("designationUpdatedBy", "");
					designationMap.put("designationUpdatedOn", "");
				}
				designationMap.put("designationAction", designation.getActionForList());
				finalDesignationList.add(designationMap);
				designationMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalDesignationList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalDesignationList.clear(); finalDesignationList = null;
		return response.toString();
	}

	@GetMapping("getMailConfigurationDetails")
	public String getMailConfigurationDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mMailConfigurationService.getMailConfigurationDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreMailConfiguration")
	public String loadMoreMailConfiguration(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalMailConfigurationList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_Mail_Configuration> mailConfigurationList = mMailConfigurationService.getMailConfigurationList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_Mail_Configuration mailConfiguration : mailConfigurationList) {
				Map<String, String> mailConfigurationMap = new HashMap<String, String>();
				mailConfigurationMap.put("email", mailConfiguration.getMailId());
				mailConfigurationMap.put("password", mailConfiguration.getMailAppPassword());
				if(mailConfiguration.getActive().compareTo(1) == 0) {
					mailConfigurationMap.put("mailConfigurationActive","<span class='badge badge-success'>Active</span>");
				} else {
					mailConfigurationMap.put("mailConfigurationActive","<span class='badge badge-danger'>In-Active</span>");
				}
				mailConfigurationMap.put("mailConfigurationCreatedBy", mailConfiguration.getmUserId().getUserFirstName()+" "+mailConfiguration.getmUserId().getUserLastName());
				mailConfigurationMap.put("mailConfigurationCreatedOn", dateFormat.format(mailConfiguration.getCreatedOn()));
				if(mailConfiguration.getmUserIdUpdate() != null) {
					mailConfigurationMap.put("mailConfigurationUpdatedBy", mailConfiguration.getmUserIdUpdate().getUserFirstName()+" "+mailConfiguration.getmUserIdUpdate().getUserLastName());
					mailConfigurationMap.put("mailConfigurationUpdatedOn", dateFormat.format(mailConfiguration.getUpdatedOn()));
				} else {
					mailConfigurationMap.put("mailConfigurationUpdatedBy", "");
					mailConfigurationMap.put("mailConfigurationUpdatedOn", "");
				}
				mailConfigurationMap.put("mailConfigurationAction", mailConfiguration.getActionForList());
				finalMailConfigurationList.add(mailConfigurationMap);
				mailConfigurationMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalMailConfigurationList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalMailConfigurationList.clear(); finalMailConfigurationList = null;
		return response.toString();
	}

	@GetMapping("getRoleDetails")
	public String getRoleDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mRoleService.getRoleDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreRole")
	public String loadMoreRole(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalRoleList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_Role> roleList = mRoleService.getRoleList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_Role role : roleList) {
				Map<String, String> roleMap = new HashMap<String, String>();
				roleMap.put("roleName", role.getRoleName());
				roleMap.put("roleDescription", role.getRoleDescription());
				if(role.getRoleActive().compareTo(1) == 0) {
					roleMap.put("roleActive","<span class='badge badge-success'>Active</span>");
				} else {
					roleMap.put("roleActive","<span class='badge badge-danger'>In-Active</span>");
				}
				roleMap.put("roleCreatedBy", role.getmUserId().getUserFirstName()+" "+role.getmUserId().getUserLastName());
				roleMap.put("roleCreatedOn", dateFormat.format(role.getCreatedOn()));
				if(role.getmUserIdUpdated() != null) {
					roleMap.put("roleUpdatedBy", role.getmUserIdUpdated().getUserFirstName()+" "+role.getmUserIdUpdated().getUserLastName());
					roleMap.put("roleUpdatedOn", dateFormat.format(role.getUpdatedOn()));
				} else {
					roleMap.put("roleUpdatedBy", "");
					roleMap.put("roleUpdatedOn", "");
				}
				roleMap.put("roleAction", role.getActionForList());
				finalRoleList.add(roleMap);
				roleMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalRoleList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalRoleList.clear(); finalRoleList = null;
		return response.toString();
	}

	@GetMapping("getMemberLevelDetails")
	public String getMemberLevelDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mMemberLevelService.getMemberLevelDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreMemberLevel")
	public String loadMoreMemberLevel(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalMemberLevelList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_Member_Level> memberLevelList = mMemberLevelService.getMemberLevelList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_Member_Level role : memberLevelList) {
				Map<String, String> roleMap = new HashMap<String, String>();
				roleMap.put("memberLevelName", role.getMemberLevelName());
				roleMap.put("memberLevelDescription", role.getMemberLevelDescription());
				if(role.getMemberLevelActive().compareTo(1) == 0) {
					roleMap.put("memberLevelActive","<span class='badge badge-success'>Active</span>");
				} else {
					roleMap.put("memberLevelActive","<span class='badge badge-danger'>In-Active</span>");
				}
				roleMap.put("memberLevelCreatedBy", role.getMemberLevelCreatedBy().getUserFirstName()+" "+role.getMemberLevelCreatedBy().getUserLastName());
				roleMap.put("memberLevelCreatedOn", dateFormat.format(role.getMemberLevelCreatedOn()));
				if(role.getMemberLevelUpdatedBy() != null) {
					roleMap.put("memberLevelUpdatedBy", role.getMemberLevelUpdatedBy().getUserFirstName()+" "+role.getMemberLevelUpdatedBy().getUserLastName());
					roleMap.put("memberLevelUpdatedOn", dateFormat.format(role.getMemberLevelUpdatedOn()));
				} else {
					roleMap.put("memberLevelUpdatedBy", "");
					roleMap.put("memberLevelUpdatedOn", "");
				}
				roleMap.put("memberLevelAction", role.getActionForList());
				finalMemberLevelList.add(roleMap);
				roleMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalMemberLevelList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalMemberLevelList.clear(); finalMemberLevelList = null;
		return response.toString();
	}

	@GetMapping("getAppDetails")
	public String getAppDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mAppService.getAppDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("getAppDumpDetails")
	public String getAppDumpDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mAppDumpService.getAppDumpDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreApp")
	public String loadMoreApp(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalAppList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_App> appList = mAppService.getAppList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_App app : appList) {
				Map<String, String> appMap = new HashMap<String, String>();
				appMap.put("appName", app.getAppName());
				appMap.put("appDescription", app.getAppDescription());
				if(app.getAppActive().compareTo(1) == 0) {
					appMap.put("appActive","<span class='badge badge-success'>Active</span>");
				} else {
					appMap.put("appActive","<span class='badge badge-danger'>In-Active</span>");
				}
				appMap.put("appCreatedBy", app.getAppCreatedBy().getUserFirstName()+" "+app.getAppCreatedBy().getUserLastName());
				appMap.put("appCreatedOn", dateFormat.format(app.getAppCreatedOn()));
				if(app.getAppUpdatedBy() != null) {
					appMap.put("appUpdatedBy", app.getAppUpdatedBy().getUserFirstName()+" "+app.getAppUpdatedBy().getUserLastName());
					appMap.put("appUpdatedOn", dateFormat.format(app.getAppUpdatedOn()));
				} else {
					appMap.put("appUpdatedBy", "");
					appMap.put("appUpdatedOn", "");
				}
				appMap.put("appAction", app.getActionForList());
				finalAppList.add(appMap);
				appMap = null;
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

	@GetMapping("getEntityDetails")
	public String getEntityDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mEntityService.getEntityDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreEntity")
	public String loadMoreEntity(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalEntityList = new ArrayList<Map<String, String>>();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<M_Entity> entityList = mEntityService.getEntityList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_Entity entity : entityList) {
				Map<String, String> entityMap = new HashMap<String, String>();
				entityMap.put("mEntityId", ""+entity.getmEntityId());
				entityMap.put("entityName", entity.getEntityName());
				entityMap.put("entityShortName", entity.getEntityShortName());
				if(entity.getEntitySource() != null) {
					entityMap.put("entitySource", entity.getEntitySource().getEntityAcronym());
					entityMap.put("entityLocation", entity.getLocationId().getLocationName());
					entityMap.put("entityZone", entity.getLocationId().getmZoneId().getZoneName());
				} else {
					entityMap.put("entitySource", "Parent Entity");
					entityMap.put("entityLocation", "");
					entityMap.put("entityZone", "");
				}
				entityMap.put("entityAcronym", entity.getEntityAcronym());
				if(entity.getEntityActive().compareTo(1) == 0) {
					entityMap.put("entityActive","<span class='badge badge-success'>Active</span>");
				} else {
					entityMap.put("entityActive","<span class='badge badge-danger'>In-Active</span>");
				}
				entityMap.put("entityCreatedBy", entity.getmUserId().getUserFirstName()+" "+entity.getmUserId().getUserLastName());
				entityMap.put("entityCreatedOn", dateFormat.format(entity.getCreatedOn()));
				if(entity.getmUserIdUpdated() != null) {
					entityMap.put("entityUpdatedBy", entity.getmUserIdUpdated().getUserFirstName()+" "+entity.getmUserIdUpdated().getUserLastName());
					entityMap.put("entityUpdatedOn", dateFormat.format(entity.getUpdatedOn()));
				} else {
					entityMap.put("entityUpdatedBy", "");
					entityMap.put("entityUpdatedOn", "");
				}
				entityMap.put("entityAction", entity.getActionForList());
				finalEntityList.add(entityMap);
				entityMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalEntityList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalEntityList.clear(); finalEntityList = null;
		return response.toString();
	}

	@GetMapping("getUserDetails")
	public String gerUserDetails(HttpServletRequest request) {
		String response = "";
		try {
			response = mUserSerivce.getUserDetails(request);
			System.out.println(response);
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@GetMapping("loadMoreUsers")
	public String loadMoreUsers(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalUserList = new ArrayList<Map<String, String>>();
		try {
			System.out.println("came here : "+Integer.parseInt(""+request.getParameter("offsetValue")));
			List<M_User> userList = mUserSerivce.getUserList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(M_User user : userList) {
				Map<String, String> userMap = new HashMap<String, String>();
				userMap.put("mUserId", ""+user.getmUserId());
                userMap.put("mEntityId", ""+user.getmEntityId().getmEntityId());
				userMap.put("userFirstName", user.getUserFirstName());
				if(user.getUserMiddleName() != null) {
					userMap.put("userMiddleName", user.getUserMiddleName());
				} else {
					userMap.put("userMiddleName", "");
				}
				userMap.put("userLastName", user.getUserLastName());
				userMap.put("userEntity", "");
				if(user.getmEntityId() != null) {
					userMap.put("userEntity", user.getmEntityId().getEntityName());
				}
				
				userMap.put("userLocation", "");
				if(user.getmEntityId() != null) {
					if(user.getmEntityId().getLocationId() != null) {
						userMap.put("userLocation", user.getmEntityId().getLocationId().getLocationName());
					}
				}
				
				userMap.put("userZone", "");
				if(user.getmEntityId() != null) {
					if(user.getmEntityId().getLocationId() != null) {
						userMap.put("userZone", user.getmEntityId().getLocationId().getmZoneId().getZoneName());
					}
				}
				
				userMap.put("userRoles", user.getRolesAvailable());
				if(user.getUserActive().compareTo(1) == 0) {
					userMap.put("userActive","<span class='badge sequence-bg-5'>Active</span>");
				} else {
					userMap.put("userActive","<span class='badge sequence-bg-1'>In-Active</span>");
				}
				userMap.put("userAction",user.getAction());
				userMap.put("userEmailId",user.getUserLoginId());
				finalUserList.add(userMap);
				userMap = null;
			}
			userList.clear(); userList = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalUserList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalUserList.clear(); finalUserList = null;
		return response.toString();
	}
}