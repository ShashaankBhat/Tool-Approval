package com.anand.masters;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.common.Common_Constants;
import com.anand.common.EncryptionDecryptionFunction;
import com.anand.common.MailService;
import com.google.gson.Gson;

@Service
public class M_User_Service_Impl implements M_User_Service {

	@Autowired private M_User_Dao mUserDao;
	@Autowired private M_User_History_Dao mUserHistoryDao;
	@Autowired private M_Role_Dao mRoleDao;
	@Autowired private M_User_Role_Map_Dao mUserRoleMapDao;
	@Autowired private M_User_Entity_Map_Dao mUserEntityMapDao;
	@Autowired private M_User_Role_Map_History_Dao mUserRoleMapHistoryDao;
	@Autowired private M_Entity_Dao mEntityDao;
	@Autowired private M_Department_Dao mDepartmentDao;
	@Autowired private M_Designation_Dao mDesignationDao;
	@Autowired private M_App_Dao mAppsDao;
	@Autowired private M_User_App_Map_Dao mUserAppMapDao;
	@Autowired private MailService mailService;

	@Override
	public List<M_User> getUserList(HttpServletRequest request, Integer offset) {
		List<M_User> userListFinal = new ArrayList<M_User>();
		try {
			Integer proceedFlag = 1;
			List<M_User> userList = new ArrayList<M_User>();
			if (request.getParameter("all") != null
					&& proceedFlag.compareTo(Integer.parseInt("" + request.getParameter("all"))) == 0) {
				userList.addAll(mUserDao.findAll());
			} else {
				Pageable pageable = PageRequest.of(offset/20, 20, Sort.by("mUserId").descending());
				userList.addAll(mUserDao.findAll(pageable).toList());
				pageable = null;
			}
			HttpSession session = request.getSession(true);
			for (M_User user : userList) {
				if ((session.getAttribute("admin") != null && proceedFlag.compareTo(Integer.parseInt("" + session.getAttribute("admin"))) == 0) ||
					(session.getAttribute("itAdmin") != null && proceedFlag.compareTo(Integer.parseInt("" + session.getAttribute("itAdmin"))) == 0) ||
					(session.getAttribute("vimsAdmin") != null && proceedFlag.compareTo(Integer.parseInt("" + session.getAttribute("vimsAdmin"))) == 0)) {
					if(request.getRequestURL().toString().contains("vims-user")) {
						user.setAction("<a href='vims-registration?id="+user.getmUserId()+"' title='Edit User Information'><i class='fas fa-edit'></i></a>");
					} else {
						user.setAction("<a href='#' title='Edit User Information' onclick='editUserInfo("+ user.getmUserId() + ")'><i class='fas fa-edit'></i></a>");
					}
				}
				if (user.getAction() != null && !user.getAction().isEmpty()) {
					user.setAction(
							user.getAction() + "&ensp;<a href='#' title='Get User Information' onclick='getUserInfo("
									+ user.getmUserId() + ")'><i class='fas fa-info'></i></a>");
				} else {
					user.setAction(user.getAction() + "<a href='#' title='Get User Information' onclick='getUserInfo("
							+ user.getmUserId() + ")'><i class='fas fa-info'></i></a>");
				}
				user.setRolesAvailable("");
				for (M_User_Role_Map userRoleMap : user.getUserInfoForRole()) {
					if (userRoleMap.getUserRoleActive().compareTo(1) == 0) {
						if (user.getRolesAvailable() != null && !user.getRolesAvailable().isEmpty()) {
							user.setRolesAvailable(
									user.getRolesAvailable() + ", " + userRoleMap.getRoleInfoForUsers().getRoleName());
						} else {
							user.setRolesAvailable(userRoleMap.getRoleInfoForUsers().getRoleName());
						}
					}
				}
				userListFinal.add(user);
			}
			session = null; proceedFlag = null;
			Collections.sort(userListFinal);
			userList.clear(); userList = null;
		} catch (Exception e) {
			e.printStackTrace();
			userListFinal.clear(); userListFinal = null;
		}
		return userListFinal;
	}

	@Override
	public M_User getUserInformationByUserName(String username) {
		try {
			M_User user = mUserDao.findByUserLoginId(username);
			if (user != null) {
			} else {
				user = null;
			}
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public M_User getUserInformationForVimsRegistration(HttpServletRequest request) {
		try {
			M_User user = mUserDao.findById(Long.parseLong(""+request.getParameter("id"))).get();
			StringBuilder userRoles = new StringBuilder();
			for(M_User_Role_Map userRoleMap: user.getUserInfoForRole()) {
				if(userRoleMap.getUserRoleActive().compareTo(1) == 0 && userRoleMap.getRoleInfoForUsers().getRoleName().contains("VIMS")) {
					if(userRoles.toString().isEmpty()) {
						userRoles.append(""+userRoleMap.getRoleInfoForUsers().getmRoleId());
					} else {
						userRoles.append(","+userRoleMap.getRoleInfoForUsers().getmRoleId());
					}
				}
			}
			user.setUserRolesTemp(userRoles.toString());

			StringBuilder userEntities = new StringBuilder();
			for(M_User_Entity_Map userEntityMap: user.getUserInfoForEntity()) {
				if(userEntityMap.getUserEntityActive().compareTo(1) == 0) {
					if(userEntities.toString().isEmpty()) {
						userEntities.append(""+userEntityMap.getEntityInfoForUsers().getmEntityId());
					} else {
						userEntities.append(","+userEntityMap.getEntityInfoForUsers().getmEntityId());
					}
				}
			}
			user.setUserEntitysTemp(userEntities.toString());
			
			user.setTempDepartmentId(Integer.parseInt(""+user.getmDepartmentId().getmDepartmentId()));
			user.setTempEntityId(Integer.parseInt(""+user.getmEntityId().getmEntityId()));
			user.setTempDesignationId(Integer.parseInt(""+user.getmDesignationId().getmDesignationId()));
			
			userRoles.setLength(0); userEntities.setLength(0);
			userRoles = null; userEntities = null;
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<M_User> getUserByActiveStatus(Integer userActive) {
		List<M_User> userList = null;
		try {
			userList = mUserDao.findByUserActive(userActive);
			Collections.sort(userList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userList;
	}

	@Override
	public List<M_User> getActiveUserByRole(Integer userActive, String roleName) {
		List<M_User> userList = new ArrayList<M_User>();
		try {
			M_User currUser = mUserDao
					.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
			List<M_User_Role_Map> usersWithRole = mUserRoleMapDao
					.findByRoleInfoForUsersAndUserRoleActive(mRoleDao.findByRoleName(roleName).get(0), 1);
			for (M_User_Role_Map currUserWithRole : usersWithRole) {
				if (currUserWithRole.getUserInfoForRole().getUserActive().compareTo(1) == 0) {
					Integer addFlag = 0;
					if (currUser.getmEntityId().getEntityAcronym().equalsIgnoreCase("AAPL")) {
						addFlag = 1;
					} else if (currUser.getmEntityId().getEntitySource().getmEntityId().compareTo(currUserWithRole
							.getUserInfoForRole().getmEntityId().getEntitySource().getmEntityId()) == 0) {
						addFlag = 1;
					}
					if (addFlag.compareTo(1) == 0) {
						userList.add(currUserWithRole.getUserInfoForRole());
					}
					addFlag = null;
				}
			}
			Collections.sort(userList);
		} catch (Exception e) {
			e.printStackTrace();
			userList.clear();
			userList = null;
		}
		return userList;
	}

	@Override
	public String getActiveUserByRoleInJson(Integer userActive, String roleName) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalUserList = new ArrayList<Map<String, String>>();
		try {
			List<M_User> userList = getActiveUserByRole(userActive, roleName);
			for (M_User user : userList) {

				Map<String, String> userMap = new HashMap<String, String>();
				userMap.put("mUserId", "" + user.getmUserId());
				userMap.put("mEntityId", "" + user.getmEntityId().getmEntityId());
				userMap.put("userFirstName", user.getUserFirstName());
				if (user.getUserMiddleName() != null) {
					userMap.put("userMiddleName", user.getUserMiddleName());
				} else {
					userMap.put("userMiddleName", "");
				}
				userMap.put("userLastName", user.getUserLastName());
				userMap.put("userEntity", "");
				if (user.getmEntityId() != null) {
					userMap.put("userEntity", user.getmEntityId().getEntityName());
				}

				userMap.put("userLocation", "");
				if (user.getmEntityId() != null) {
					if (user.getmEntityId().getLocationId() != null) {
						userMap.put("userLocation", user.getmEntityId().getLocationId().getLocationName());
					}
				}

				userMap.put("userZone", "");
				if (user.getmEntityId() != null) {
					if (user.getmEntityId().getLocationId() != null) {
						userMap.put("userZone", user.getmEntityId().getLocationId().getmZoneId().getZoneName());
					}
				}

				userMap.put("userRoles", user.getRolesAvailable());
				if (user.getUserActive().compareTo(1) == 0) {
					userMap.put("userActive", "<span class='badge sequence-bg-5'>Active</span>");
				} else {
					userMap.put("userActive", "<span class='badge sequence-bg-1'>In-Active</span>");
				}
				userMap.put("userAction", user.getAction());
				userMap.put("userEmailId", user.getUserLoginId());
				finalUserList.add(userMap);
				userMap = null;
			}
			userList.clear();
			userList = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalUserList));
			gson = null;
		} catch (Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalUserList.clear();
		finalUserList = null;
		return response.toString();
	}

	@Override
	public List<M_User> getActiveUserByRoleInList(Integer userActive, String roleName, HttpServletRequest request) {
		List<M_User> finalUserList = new ArrayList<>();
		try {
			List<M_User> userList = getActiveUserByRole(userActive, roleName);
			List<M_User> finalTempUserList = new ArrayList<>();
			if (request.getParameter("parentEntityId") != null
					&& Integer.parseInt(request.getParameter("parentEntityId")) != -1) {
				for (M_User user : userList) {
					if (user.getmEntityId().getEntitySource().getmEntityId()
							.compareTo(Long.parseLong(request.getParameter("parentEntityId"))) == 0) {
						finalTempUserList.add(user);
					}
					user = null;
				}
			}
			if (request.getParameter("plantId") != null && Integer.parseInt(request.getParameter("plantId")) != -1) {
				if (finalTempUserList != null && finalTempUserList.size() != 0) {
					for (M_User user : finalTempUserList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalUserList.add(user);
						}
						user = null;
					}
				} else {
					for (M_User user : userList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalTempUserList.add(user);
						}
						user = null;
					}
				}
			}
			if (finalUserList.size() == 0) {
				finalUserList.addAll(finalTempUserList);
			}
			userList.clear();
			userList = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return finalUserList;
	}

	@Override
	public String getLineManager(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalUserList = new ArrayList<Map<String, String>>();
		M_Entity entity = mEntityDao.findById(Long.parseLong("" + request.getParameter("mEntityId"))).get();
		try {
			List<M_User> userList = getActiveUserByRole(1, "IFC PRAAC");
			for (M_User user : userList) {
				System.out.println(user.getUserLoginId() + " - " + entity.getEntitySource().getmEntityId() + " - "
						+ user.getmEntityId().getEntitySource().getmEntityId());
				if (entity.getEntitySource().getmEntityId()
						.compareTo(user.getmEntityId().getEntitySource().getmEntityId()) == 0) {
					Map<String, String> userMap = new HashMap<String, String>();
					userMap.put("mUserId", "" + user.getmUserId());
					userMap.put("mEntityId", "" + user.getmEntityId().getmEntityId());
					userMap.put("userFirstName", user.getUserFirstName());
					if (user.getUserMiddleName() != null) {
						userMap.put("userMiddleName", user.getUserMiddleName());
					} else {
						userMap.put("userMiddleName", "");
					}
					userMap.put("userLastName", user.getUserLastName());
					userMap.put("userEntity", "");
					if (user.getmEntityId() != null) {
						userMap.put("userEntity", user.getmEntityId().getEntityName());
					}

					userMap.put("userLocation", "");
					if (user.getmEntityId() != null) {
						if (user.getmEntityId().getLocationId() != null) {
							userMap.put("userLocation", user.getmEntityId().getLocationId().getLocationName());
						}
					}

					userMap.put("userZone", "");
					if (user.getmEntityId() != null) {
						if (user.getmEntityId().getLocationId() != null) {
							userMap.put("userZone", user.getmEntityId().getLocationId().getmZoneId().getZoneName());
						}
					}

					userMap.put("userRoles", user.getRolesAvailable());
					if (user.getUserActive().compareTo(1) == 0) {
						userMap.put("userActive", "<span class='badge sequence-bg-5'>Active</span>");
					} else {
						userMap.put("userActive", "<span class='badge sequence-bg-1'>In-Active</span>");
					}
					userMap.put("userAction", user.getAction());
					userMap.put("userEmailId", user.getUserLoginId());
					finalUserList.add(userMap);
					userMap = null;
				}
			}
			userList.clear();
			userList = getActiveUserByRole(1, "IFC Line Manager");
			for (M_User user : userList) {
				if (entity.getmEntityId().compareTo(user.getmEntityId().getmEntityId()) == 0) {
					Map<String, String> userMap = new HashMap<String, String>();
					userMap.put("mUserId", "" + user.getmUserId());
					userMap.put("mEntityId", "" + user.getmEntityId().getmEntityId());
					userMap.put("userFirstName", user.getUserFirstName());
					if (user.getUserMiddleName() != null) {
						userMap.put("userMiddleName", user.getUserMiddleName());
					} else {
						userMap.put("userMiddleName", "");
					}
					userMap.put("userLastName", user.getUserLastName());
					userMap.put("userEntity", "");
					if (user.getmEntityId() != null) {
						userMap.put("userEntity", user.getmEntityId().getEntityName());
					}

					userMap.put("userLocation", "");
					if (user.getmEntityId() != null) {
						if (user.getmEntityId().getLocationId() != null) {
							userMap.put("userLocation", user.getmEntityId().getLocationId().getLocationName());
						}
					}

					userMap.put("userZone", "");
					if (user.getmEntityId() != null) {
						if (user.getmEntityId().getLocationId() != null) {
							userMap.put("userZone", user.getmEntityId().getLocationId().getmZoneId().getZoneName());
						}
					}

					userMap.put("userRoles", user.getRolesAvailable());
					if (user.getUserActive().compareTo(1) == 0) {
						userMap.put("userActive", "<span class='badge sequence-bg-5'>Active</span>");
					} else {
						userMap.put("userActive", "<span class='badge sequence-bg-1'>In-Active</span>");
					}
					userMap.put("userAction", user.getAction());
					userMap.put("userEmailId", user.getUserLoginId());
					finalUserList.add(userMap);
					userMap = null;
				}
			}
			userList.clear();
			userList = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalUserList));
			gson = null;
		} catch (Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalUserList.clear();
		finalUserList = null;
		return response.toString();
	}

	@Override
	public List<M_User> getLineManagerList(HttpServletRequest request) {
		List<M_User> finalUserList = new ArrayList<>();
		try {
			List<M_User> userList = getActiveUserByRole(1, "IFC PRAAC");
			List<M_User> finalTempUserList = new ArrayList<>();
			if (request.getParameter("parentEntityId") != null
					&& Integer.parseInt(request.getParameter("parentEntityId")) != -1) {
				for (M_User user : userList) {
					if (user.getmEntityId().getEntitySource().getmEntityId()
							.compareTo(Long.parseLong(request.getParameter("parentEntityId"))) == 0) {
						finalTempUserList.add(user);
					}
					user = null;
				}
			}
			if (request.getParameter("plantId") != null && Integer.parseInt(request.getParameter("plantId")) != -1) {
				if (finalTempUserList != null && finalTempUserList.size() != 0) {
					for (M_User user : finalTempUserList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalUserList.add(user);
						}
						user = null;
					}
				} else {
					for (M_User user : userList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalTempUserList.add(user);
						}
						user = null;
					}
				}
			}
			userList.clear();
			userList = getActiveUserByRole(1, "IFC Line Manager");
			if (request.getParameter("parentEntityId") != null
					&& Integer.parseInt(request.getParameter("parentEntityId")) != -1) {
				for (M_User user : userList) {
					if (user.getmEntityId().getEntitySource().getmEntityId()
							.compareTo(Long.parseLong(request.getParameter("parentEntityId"))) == 0) {
						finalTempUserList.add(user);
					}
					user = null;
				}
			}
			if (request.getParameter("plantId") != null && Integer.parseInt(request.getParameter("plantId")) != -1) {
				if (finalTempUserList != null && finalTempUserList.size() != 0) {
					for (M_User user : finalTempUserList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalUserList.add(user);
						}
						user = null;
					}
				} else {
					for (M_User user : userList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalTempUserList.add(user);
						}
						user = null;
					}
				}
			}
			if (finalUserList.size() == 0) {
				finalUserList.addAll(finalTempUserList);
			}
			userList.clear();
			userList = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return finalUserList;
	}

	@Override
	public String getPraac(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalUserList = new ArrayList<Map<String, String>>();
		M_Entity entity = mEntityDao.findById(Long.parseLong("" + request.getParameter("mEntityId"))).get();
		try {
			List<M_User> userList = getActiveUserByRole(1, "IFC PRAAC");
			for (M_User user : userList) {
				System.out.println(user.getUserLoginId() + " - " + entity.getEntitySource().getmEntityId() + " - "
						+ user.getmEntityId().getEntitySource().getmEntityId());
				if (entity.getEntitySource().getmEntityId()
						.compareTo(user.getmEntityId().getEntitySource().getmEntityId()) == 0) {
					Map<String, String> userMap = new HashMap<String, String>();
					userMap.put("mUserId", "" + user.getmUserId());
					userMap.put("mEntityId", "" + user.getmEntityId().getmEntityId());
					userMap.put("userFirstName", user.getUserFirstName());
					if (user.getUserMiddleName() != null) {
						userMap.put("userMiddleName", user.getUserMiddleName());
					} else {
						userMap.put("userMiddleName", "");
					}
					userMap.put("userLastName", user.getUserLastName());
					userMap.put("userEntity", "");
					if (user.getmEntityId() != null) {
						userMap.put("userEntity", user.getmEntityId().getEntityName());
					}

					userMap.put("userLocation", "");
					if (user.getmEntityId() != null) {
						if (user.getmEntityId().getLocationId() != null) {
							userMap.put("userLocation", user.getmEntityId().getLocationId().getLocationName());
						}
					}

					userMap.put("userZone", "");
					if (user.getmEntityId() != null) {
						if (user.getmEntityId().getLocationId() != null) {
							userMap.put("userZone", user.getmEntityId().getLocationId().getmZoneId().getZoneName());
						}
					}

					userMap.put("userRoles", user.getRolesAvailable());
					if (user.getUserActive().compareTo(1) == 0) {
						userMap.put("userActive", "<span class='badge sequence-bg-5'>Active</span>");
					} else {
						userMap.put("userActive", "<span class='badge sequence-bg-1'>In-Active</span>");
					}
					userMap.put("userAction", user.getAction());
					userMap.put("userEmailId", user.getUserLoginId());
					finalUserList.add(userMap);
					userMap = null;
				}
			}
			userList.clear();
			userList = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalUserList));
			gson = null;
		} catch (Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		System.out.println("praac : " + finalUserList.size() + " - " + response.toString());
		finalUserList.clear();
		finalUserList = null;
		return response.toString();
	}

	@Override
	public List<M_User> getPraacList(HttpServletRequest request) {
		List<M_User> finalUserList = new ArrayList<>();
		try {
			List<M_User> userList = getActiveUserByRole(1, "IFC PRAAC");
			List<M_User> finalTempUserList = new ArrayList<>();
			if (request.getParameter("parentEntityId") != null
					&& Integer.parseInt(request.getParameter("parentEntityId")) != -1) {
				for (M_User user : userList) {
					if (user.getmEntityId().getEntitySource().getmEntityId()
							.compareTo(Long.parseLong(request.getParameter("parentEntityId"))) == 0) {
						finalTempUserList.add(user);
					}
					user = null;
				}
			}
			if (request.getParameter("plantId") != null && Integer.parseInt(request.getParameter("plantId")) != -1) {
				if (finalTempUserList != null && finalTempUserList.size() != 0) {
					for (M_User user : finalTempUserList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalUserList.add(user);
						}
						user = null;
					}
				} else {
					for (M_User user : userList) {
						if (user.getmEntityId().getmEntityId()
								.compareTo(Long.parseLong(request.getParameter("plantId"))) == 0) {
							finalTempUserList.add(user);
						}
						user = null;
					}
				}
			}
			if (finalUserList.size() == 0) {
				finalUserList.addAll(finalTempUserList);
			}
			userList.clear();
			userList = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return finalUserList;
	}

	@Override
	public List<M_User> getUserOfSameEntities() {
		List<M_User> userList = new ArrayList<M_User>();
		M_User currUser = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		List<M_User> tempUserList = null;
		try {
			tempUserList = mUserDao.findByUserActive(1);
			for (M_User user : tempUserList) {
				if (user.getmEntityId().getmEntityId().compareTo(currUser.getmEntityId().getmEntityId()) == 0) {
					userList.add(user);
				}
			}
			Collections.sort(userList);
		} catch (Exception e) {
			e.printStackTrace();
			userList.clear();
			userList = null;
		}
		tempUserList = null;
		currUser = null;
		return userList;
	}

	@Override
	@Transactional
	public String saveUserDetails(HttpServletRequest request, M_User user) throws Exception {
		StringBuilder response = new StringBuilder();
		M_User currUser = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		if (user.getmUserId() != null) {
			M_User userToEdit = mUserDao.findById(Long.parseLong("" + user.getmUserId())).get();

			Integer proceedFlag = 0;
			M_User userExists = mUserDao.findByUserLoginId(userToEdit.getUserLoginId());
			if (userExists != null) {
				if (userExists.getUserLoginId().equalsIgnoreCase(userToEdit.getUserLoginId())
						&& userExists.getmUserId().compareTo(userToEdit.getmUserId()) != 0) {
					proceedFlag = 1;
				}
			}
			userExists = null;
			if (proceedFlag.compareTo(0) == 0) {
				M_User_History userHistory = new M_User_History();
				userHistory.setmUserId(currUser);
				userHistory.setUserActive(currUser.getUserActive());
				userHistory.setUserLoginId(currUser.getUserLoginId());
				userHistory.setUserPassword(currUser.getUserPassword());
				userHistory.setUserPasswordTwo(currUser.getUserPasswordTwo());
				userHistory.setUserFirstName(currUser.getUserFirstName());
				userHistory.setUserMiddleName(null);
				if (currUser.getUserMiddleName() != null && !currUser.getUserMiddleName().isEmpty()) {
					userHistory.setUserMiddleName(currUser.getUserMiddleName());
				}
				userHistory.setUserLastName(currUser.getUserLastName());
				userHistory.setUserPhoneNumber(currUser.getUserPhoneNumber());
				/*
				 * userHistory.setUserReportingManagerMail(currUser.getUserReportingManagerMail(
				 * ));
				 * userHistory.setUserReportingManagerName(currUser.getUserReportingManagerName(
				 * ));
				 */
				userHistory.setmEntityId(currUser.getmEntityId());
				userHistory.setmDesignationId(currUser.getmDesignationId());
				userHistory.setmDepartmentId(currUser.getmDepartmentId());
				userHistory.setUserCreatedOn(currDate);
				userHistory.setUserCreatedBy(currUser);
				mUserHistoryDao.save(userHistory);
				for (M_User_Role_Map userRole : userToEdit.getUserInfoForRole()) {
					M_User_Role_Map_History userRoleMapHistory = new M_User_Role_Map_History();
					userRoleMapHistory.setmUserRoleMapId(userRole);
					userRoleMapHistory.setmUserHistoryId(userHistory);
					userRoleMapHistory.setmRoleId(userRole.getRoleInfoForUsers());
					userRoleMapHistory.setUserRoleActive(userRole.getUserRoleActive());
					userRoleMapHistory.setUserRoleCreatedOn(currDate);
					userRoleMapHistory.setUserRoleCreatedBy(currUser);
					mUserRoleMapHistoryDao.save(userRoleMapHistory);
					userRoleMapHistory = null;
				}
				userHistory = null;

				userToEdit.setUserFirstName(user.getUserFirstName());
				if (user.getUserMiddleName() != null && !user.getUserMiddleName().isEmpty()) {
					userToEdit.setUserMiddleName(user.getUserMiddleName());
				}
				userToEdit.setUserLastName(user.getUserLastName());
				userToEdit.setUserLoginId(user.getUserLoginId());
				userToEdit.setUserPhoneNumber(user.getUserPhoneNumber());
				userToEdit.setmEntityId(mEntityDao.findById(Long.parseLong("" + user.getTempEntityId())).get());
				userToEdit.setmDepartmentId(
						mDepartmentDao.findById(Long.parseLong("" + user.getTempDepartmentId())).get());
				userToEdit.setmDesignationId(
						mDesignationDao.findById(Long.parseLong("" + user.getTempDesignationId())).get());
				/*
				 * userToEdit.setUserReportingManagerMail(user.getUserReportingManagerMail());
				 * userToEdit.setUserReportingManagerName(user.getUserReportingManagerName());
				 */
				userToEdit.setUserActive(user.getUserActive());
				userToEdit.setUserLoginId(userToEdit.getUserLoginId());
				mUserDao.save(currUser);

				for (M_User_Role_Map userRole : userToEdit.getUserInfoForRole()) {
					if (!userRole.getRoleInfoForUsers().getRoleName().contains("Employee")) {
						userRole.setUserRoleActive(0);
						mUserRoleMapDao.save(userRole);
					}
				}
				String[] userRolesNow = user.getUserRolesTemp().split(",");
				for (int i = 0; i < userRolesNow.length; i++) {
					M_Role role = mRoleDao.findById(Long.parseLong("" + userRolesNow[i])).get();
					List<M_User_Role_Map> userRoleAvailable = mUserRoleMapDao
							.findByUserInfoForRoleAndRoleInfoForUsers(userToEdit, role);
					if (userRoleAvailable != null && userRoleAvailable.size() != 0) {
						for (M_User_Role_Map userRole : userRoleAvailable) {
							userRole.setUserRoleActive(1);
							mUserRoleMapDao.save(userRole);
						}
					} else {
						M_User_Role_Map userRoleMap = new M_User_Role_Map();
						userRoleMap.setUserInfoForRole(userToEdit);
						userRoleMap.setRoleInfoForUsers(role);
						userRoleMap.setUserRoleActive(1);
						userRoleMap.setUserRoleCreatedBy(currUser);
						userRoleMap.setUserRoleCreatedOn(currDate);
						mUserRoleMapDao.save(userRoleMap);
					}
					userRoleAvailable = null;
					role = null;
				}
				if (userToEdit.getUserInfoForApp() != null) {
					for (M_User_App_Map userApps : userToEdit.getUserInfoForApp()) {
						userApps.setUserAppActive(0);
						mUserAppMapDao.save(userApps);
					}
				}
				System.out.println("getUserAppsTemp : " + user.getUserAppsTemp());
				String[] userAppssNow = user.getUserAppsTemp().split(",");
				for (int i = 0; i < userAppssNow.length; i++) {
					M_App role = mAppsDao.findById(Long.parseLong("" + userAppssNow[i])).get();
					List<M_User_App_Map> userAppsAvailable = mUserAppMapDao
							.findByUserInfoForAppAndAppInfoForUsers(userToEdit, role);
					System.out.println(role.getAppName() + " : " + userAppsAvailable.size());
					if (userAppsAvailable != null && userAppsAvailable.size() != 0) {
						for (M_User_App_Map userApps : userAppsAvailable) {
							userApps.setUserAppActive(1);
							mUserAppMapDao.save(userApps);
						}
					} else {
						M_User_App_Map userAppsMap = new M_User_App_Map();
						userAppsMap.setUserInfoForApp(userToEdit);
						userAppsMap.setAppInfoForUsers(role);
						userAppsMap.setUserAppActive(1);
						userAppsMap.setUserAppCreatedBy(currUser);
						userAppsMap.setUserAppCreatedOn(currDate);
						mUserAppMapDao.save(userAppsMap);
						userAppsMap = null;
					}
					userAppsAvailable = null;
					role = null;
				}
				userToEdit = null;

				response.append("edit");
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
		} else {
			M_User userExists = mUserDao.findByUserLoginId(user.getUserLoginId());
			if (userExists != null) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
				if (user.getUserLastName() != null && !user.getUserLastName().isEmpty()) {
					user.setUserLastName(user.getUserLastName());
				} else {
					user.setUserLastName(null);
				}
				M_Entity entityInfo = mEntityDao.findById(Long.parseLong("" + user.getTempEntityId())).get();
				user.setmEntityId(entityInfo);
				user.setmDepartmentId(mDepartmentDao.findById(Long.parseLong("" + user.getTempDepartmentId())).get());
				user.setmDesignationId(
						mDesignationDao.findById(Long.parseLong("" + user.getTempDesignationId())).get());
				user.setUserPassword(bCryptPasswordEncoder.encode(user.getUserPassword()));
				user.setUserPasswordTwo(EncryptionDecryptionFunction.getEncryptedData(user.getUserPassword()));
				user.setUserActive(0);
				user.setUserApproved(0);
				user.setUserEmailVerifyToken(EncryptionDecryptionFunction.getEncryptedData(user.getUserLoginId()));
				user.setUserCreatedOn(currDate);

				M_User lastUser = mUserDao.getUserInfoWhichContainsUserCode(entityInfo.getEntityAcronym());
				if (lastUser != null) {
					String[] userCodeSplit = lastUser.getUserCode().split(entityInfo.getEntityAcronym());
					Integer lastValue = Integer.parseInt(userCodeSplit[1]);
					lastValue++;
					if (lastValue.compareTo(10) < 0) {
						user.setUserCode(entityInfo.getEntityAcronym() + "0000" + lastValue);
					} else if (lastValue.compareTo(100) < 0) {
						user.setUserCode(entityInfo.getEntityAcronym() + "000" + lastValue);
					} else if (lastValue.compareTo(1000) < 0) {
						user.setUserCode(entityInfo.getEntityAcronym() + "00" + lastValue);
					} else if (lastValue.compareTo(10000) < 0) {
						user.setUserCode(entityInfo.getEntityAcronym() + "0" + lastValue);
					} else {
						user.setUserCode(entityInfo.getEntityAcronym() + lastValue);
					}
					userCodeSplit = null;
					lastValue = null;
				} else {
					user.setUserCode(entityInfo.getEntityAcronym() + "00001");
				}
				lastUser = null;

				mUserDao.save(user);

				bCryptPasswordEncoder = null;
				user = null;
				response.append("add");
			}
			userExists = null;
		}
		return response.toString();
	}

	@Override
	@Transactional
	public String saveUserDetailsV1(HttpServletRequest request, M_User user) throws Exception {
		StringBuilder response = new StringBuilder();
		M_User currUser = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		M_User userExists = mUserDao.findByUserLoginId(user.getUserLoginId());
		if (userExists != null) {
			System.out.println("name exists");
			response.append("nameExists");
		} else {
			BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
			if (user.getUserMiddleName() != null && !user.getUserMiddleName().isEmpty()) {
				user.setUserMiddleName(user.getUserMiddleName());
			} else {
				user.setUserMiddleName(null);
			}
			M_Entity entityInfo = mEntityDao.findById(Long.parseLong("" + user.getTempEntityId())).get();
			user.setmEntityId(entityInfo);
			user.setmDepartmentId(mDepartmentDao.findById(Long.parseLong("" + user.getTempDepartmentId())).get());
			user.setmDesignationId(mDesignationDao.findById(Long.parseLong("" + user.getTempDesignationId())).get());
			user.setUserPassword(bCryptPasswordEncoder.encode(user.getUserPassword()));
			user.setUserPasswordTwo(EncryptionDecryptionFunction.getEncryptedData(user.getUserPassword()));
			user.setUserActive(1);
			user.setUserApproved(1);
			user.setUserEmailVerifyToken(EncryptionDecryptionFunction.getEncryptedData(user.getUserLoginId()));
			user.setUserCreatedOn(currDate);
			user.setUserCreatedBy(currUser);

			M_User lastUser = mUserDao.getUserInfoWhichContainsUserCode(entityInfo.getEntityAcronym());
			if (lastUser != null) {
				String[] userCodeSplit = lastUser.getUserCode().split(entityInfo.getEntityAcronym());
				Integer lastValue = Integer.parseInt(userCodeSplit[1]);
				lastValue++;
				if (lastValue.compareTo(10) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "0000" + lastValue);
				} else if (lastValue.compareTo(100) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "000" + lastValue);
				} else if (lastValue.compareTo(1000) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "00" + lastValue);
				} else if (lastValue.compareTo(10000) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "0" + lastValue);
				} else {
					user.setUserCode(entityInfo.getEntityAcronym() + lastValue);
				}
				userCodeSplit = null;
				lastValue = null;
			} else {
				user.setUserCode(entityInfo.getEntityAcronym() + "00001");
			}
			lastUser = null;

			mUserDao.save(user);

			M_Role mRole = mRoleDao.findByRoleName("Employee").get(0);
			M_User_Role_Map userRoleMap = new M_User_Role_Map();
			userRoleMap.setUserInfoForRole(user);
			userRoleMap.setRoleInfoForUsers(mRole);
			userRoleMap.setUserRoleActive(1);
			userRoleMap.setUserRoleCreatedBy(currUser);
			userRoleMap.setUserRoleCreatedOn(currDate);
			mUserRoleMapDao.save(userRoleMap);

			currUser = null;
			currDate = null;
			mRole = null;
			userRoleMap = null;
			bCryptPasswordEncoder = null;
			user = null;
			response.append("add");
		}
		userExists = null;
		return response.toString();
	}

	@Override
	@Transactional
	public String saveUserDetailsRegistration(HttpServletRequest request, M_User user) throws Exception {
		StringBuilder response = new StringBuilder();
		M_User currUser = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		M_Entity entityInfo = mEntityDao.findById(Long.parseLong("" + user.getTempEntityId())).get();
		if(user.getmUserId() != null) {
			M_User userExists = mUserDao.findById(user.getmUserId()).get();
			userExists.setUserFirstName(user.getUserFirstName());
			if (user.getUserMiddleName() != null && !user.getUserMiddleName().isEmpty()) {
				userExists.setUserMiddleName(user.getUserMiddleName());
			} else {
				userExists.setUserMiddleName(null);
			}
			userExists.setUserLastName(user.getUserLastName());
			userExists.setmEntityId(entityInfo);
			userExists.setmDepartmentId(mDepartmentDao.findById(Long.parseLong("" + user.getTempDepartmentId())).get());
			userExists.setmDesignationId(mDesignationDao.findById(Long.parseLong("" + user.getTempDesignationId())).get());
			userExists.setUserPassword(bCryptPasswordEncoder.encode(user.getUserPassword()));
			userExists.setUserPasswordTwo(EncryptionDecryptionFunction.getEncryptedData(user.getUserPasswordTwo()));
			userExists.setUserActive(1);
			userExists.setUserUpdatedBy(currUser);
			userExists.setUserUpdatedOn(currDate);
			mUserDao.save(userExists);
			for(M_User_Role_Map userRole: userExists.getUserInfoForRole()) {
				if(userRole.getRoleInfoForUsers().getRoleName().contains("VIMS")) {
					userRole.setUserRoleActive(0);
					mUserRoleMapDao.save(userRole);
				}
			}
			System.out.println("user.getUserRolesTemp(): "+user.getUserRolesTemp());
			String[] roles = user.getUserRolesTemp().split(",");
			for(int i=0; i<roles.length; i++) {
				System.out.println(roles[0]+" : RoleId");
				M_Role mRole = mRoleDao.findById(Long.parseLong(roles[i])).get();
				System.out.println(mRole.getRoleName());
				List<M_User_Role_Map> userRoleMapExists = mUserRoleMapDao.findByUserInfoForRoleAndRoleInfoForUsers(userExists, mRole);
				M_User_Role_Map userRoleMap;
				if(userRoleMapExists != null && userRoleMapExists.size() != 0) {
					System.out.println("exists");
					userRoleMap = userRoleMapExists.get(0);
					userRoleMap.setUserRoleActive(1);
				} else {
					System.out.println("new");
					userRoleMap = new M_User_Role_Map();
					userRoleMap.setUserInfoForRole(user);
					userRoleMap.setRoleInfoForUsers(mRole);
					userRoleMap.setUserRoleActive(1);
					userRoleMap.setUserRoleCreatedOn(currDate);
				}
				mUserRoleMapDao.save(userRoleMap);
				userRoleMap = null;
				mRole = null;
			}
			roles = null;
			for(M_User_Entity_Map userEntity: userExists.getUserInfoForEntity()) {
				userEntity.setUserEntityActive(0);
				mUserEntityMapDao.save(userEntity);
			}
			String[] userEntities = user.getUserEntitysTemp().split(",");
			for(int i=0; i<userEntities.length; i++) {
				M_Entity mEntity = mEntityDao.findById(Long.parseLong(userEntities[i])).get();
				List<M_User_Entity_Map> userEntityMapExists = mUserEntityMapDao.findByUserInfoForEntityAndEntityInfoForUsers(user, mEntity);
				M_User_Entity_Map userEntityMap;
				if(userEntityMapExists != null && userEntityMapExists.size() != 0) {
					userEntityMap = userEntityMapExists.get(0);
					userEntityMap.setUserEntityActive(1);
				} else {
					userEntityMap = new M_User_Entity_Map();
					userEntityMap.setUserInfoForEntity(user);
					userEntityMap.setEntityInfoForUsers(mEntity);
					userEntityMap.setUserEntityActive(1);
					userEntityMap.setUserEntityCreatedOn(currDate);
				}
				mUserEntityMapDao.save(userEntityMap);
				userEntityMap = null;
				mEntity = null;
			}
			userEntities = null;
			response.append("edit");
		} else {
			user.setUserFirstName(user.getUserFirstName());
			if (user.getUserMiddleName() != null && !user.getUserMiddleName().isEmpty()) {
				user.setUserMiddleName(user.getUserMiddleName());
			} else {
				user.setUserMiddleName(null);
			}
			user.setUserLastName(user.getUserLastName());
			user.setmEntityId(entityInfo);
			user.setmDepartmentId(mDepartmentDao.findById(Long.parseLong("" + user.getTempDepartmentId())).get());
			user.setmDesignationId(mDesignationDao.findById(Long.parseLong("" + user.getTempDesignationId())).get());
			user.setUserPassword(bCryptPasswordEncoder.encode(user.getUserPassword()));
			user.setUserPasswordTwo(EncryptionDecryptionFunction.getEncryptedData(user.getUserPasswordTwo()));
			user.setUserActive(1);
			user.setUserApproved(1);
			user.setUserCreatedOn(currDate);
			user.setUserCreatedBy(currUser);
			mUserDao.save(user);
			M_Role mRole = mRoleDao.findByRoleName("Employee").get(0);
			M_User_Role_Map userRoleMap = new M_User_Role_Map();
			userRoleMap.setUserInfoForRole(user);
			userRoleMap.setRoleInfoForUsers(mRole);
			userRoleMap.setUserRoleActive(1);
			userRoleMap.setUserRoleCreatedOn(currDate);
			mUserRoleMapDao.save(userRoleMap);
			userRoleMap = null;
			mRole = null;
			String[] roles = user.getUserRolesTemp().split(",");
			for(int i=0; i<roles.length; i++) {
				mRole = mRoleDao.findById(Long.parseLong(roles[0])).get();
				userRoleMap = new M_User_Role_Map();
				userRoleMap.setUserInfoForRole(user);
				userRoleMap.setRoleInfoForUsers(mRole);
				userRoleMap.setUserRoleActive(1);
				userRoleMap.setUserRoleCreatedOn(currDate);
				mUserRoleMapDao.save(userRoleMap);
				userRoleMap = null;
			}
			
			String[] userEntities = user.getUserEntitysTemp().split(",");
			for(int i=0; i<userEntities.length; i++) {
				M_Entity mEntity = mEntityDao.findById(Long.parseLong(userEntities[i])).get();
				M_User_Entity_Map userEntityMap = new M_User_Entity_Map();
				userEntityMap.setUserInfoForEntity(user);
				userEntityMap.setEntityInfoForUsers(mEntity);
				userEntityMap.setUserEntityActive(1);
				userEntityMap.setUserEntityCreatedOn(currDate);
				mUserEntityMapDao.save(userEntityMap);
				userEntityMap = null;
				mEntity = null;
			}
			userEntities = null;
			roles = null; mRole = null;
			response.append("add");
		}
		currUser = null; bCryptPasswordEncoder = null; user = null;
		System.out.println(response.toString());
		return response.toString();
	}

	@Override
	@Transactional
	public String saveUserDetailsRegistrationSso(HttpServletRequest request, M_User user) throws Exception {
		StringBuilder response = new StringBuilder();
		Date currDate = new Date();
		System.out.println("userId : "+user.getmUserId());
		System.out.println("add");
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		if(user.getUserMiddleName() != null && !user.getUserMiddleName().isEmpty()) {
			user.setUserMiddleName(user.getUserMiddleName());
		} else {
			user.setUserMiddleName(null);
		}
		M_Entity entityInfo = mEntityDao.findById(Long.parseLong(""+user.getTempEntityId())).get();
		user.setmEntityId(entityInfo);
		user.setmDepartmentId(mDepartmentDao.findById(Long.parseLong(""+user.getTempDepartmentId())).get());
		user.setmDesignationId(mDesignationDao.findById(Long.parseLong(""+user.getTempDesignationId())).get());
		user.setUserPassword(bCryptPasswordEncoder.encode(user.getUserFirstName()+"@123"));
		user.setUserPasswordTwo(EncryptionDecryptionFunction.getEncryptedData(user.getUserFirstName()+"@123"));
		user.setUserActive(1);
		user.setUserApproved(1);
		user.setUserEmailVerifyToken(EncryptionDecryptionFunction.getEncryptedData(user.getUserLoginId()));
		user.setUserCreatedOn(currDate);
		M_User lastUser = mUserDao.getUserInfoWhichContainsUserCode(entityInfo.getEntityAcronym());
		if(lastUser != null) {
			String[] userCodeSplit = lastUser.getUserCode().split(entityInfo.getEntityAcronym());
			Integer lastValue = Integer.parseInt(userCodeSplit[1]);
			lastValue++;
			if(lastValue.compareTo(10) < 0) {
				user.setUserCode(entityInfo.getEntityAcronym()+"0000"+lastValue);
			} else if(lastValue.compareTo(100) < 0) {
				user.setUserCode(entityInfo.getEntityAcronym()+"000"+lastValue);
			} else if(lastValue.compareTo(1000) < 0) {
				user.setUserCode(entityInfo.getEntityAcronym()+"00"+lastValue);
			} else if(lastValue.compareTo(10000) < 0) {
				user.setUserCode(entityInfo.getEntityAcronym()+"0"+lastValue);
			} else {
				user.setUserCode(entityInfo.getEntityAcronym()+lastValue);
			}
			userCodeSplit = null; lastValue = null;
		} else {
			user.setUserCode(entityInfo.getEntityAcronym()+"00001");
		}
		mUserDao.save(user);
		M_Role mRole = mRoleDao.findByRoleName("Employee").get(0);
		M_User_Role_Map userRoleMap = new M_User_Role_Map();
		userRoleMap.setUserInfoForRole(user);
		userRoleMap.setRoleInfoForUsers(mRole);
		userRoleMap.setUserRoleActive(1);
		userRoleMap.setUserRoleCreatedOn(currDate);
		mUserRoleMapDao.save(userRoleMap);
		userRoleMap = null; mRole = null;
		lastUser = null; bCryptPasswordEncoder = null; user = null;
		response.append("add");
		System.out.println(response.toString());
		return response.toString();
	}

	@Override
	public void sendRegistrationMail(HttpServletRequest request, M_User user) {
		try {
			M_User currUser = mUserDao.findByUserLoginId(user.getUserLoginId());
			StringBuilder body = new StringBuilder();
			body.append(Common_Constants.emailHeadNew);
			Date currDate = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
			body.append("<tr>" +
					"	<td style='padding: 10px 10px 10px 10px;'>" +
					"		<p style='margin: 0; padding:10px 0 0 0;color:#00AEEF;font-size:29px' class='namenow'>" +
					"			<strong>MESSAGE FROM<br>CORPORATE IFC PORTAL</strong>" +
					"		</p>" +
					"		<p style='margin: 0; padding:10px 0 0 0;color:#002E6D;font-size:21.5px' class='namenow'>" +
					"			Registration Complete - IFC Portal" +
					"		</p>" +
					"		<br>" +
					"		<p style='margin: 0; padding:10px 0 0 0;' class='namenow'>" +
					"			INTERNAL COMMUNICATION<br>" +
					"" + formatter.format(currDate) +
					"		</p>" +
					"	</td>" +
					"</tr>");
			System.out.println("token : " + currUser.getUserEmailVerifyToken());
			body.append("<tr>" +
					"	<td style='padding: 10px 10px 10px 10px;'>" +
					"		<p style='margin: 0;padding-bottom:10px;' class='namenow'>" +
					"			Dear " + currUser.getUserFirstName() + " " + currUser.getUserLastName() +
					"		</p><br>" +
					"		<p style='margin: 0; padding:10px 0 0 0;' class='namenow'>" +
					"			You successfully registered in the IAMS Portal." +
					"		</p>" +
					"		<p style='margin: 0; padding:10px 0 0 0;' class='namenow'>" +
					"			<a href='" + Common_Constants.applicationUrl
					+ "signup-verification?signup-verification="
					+ EncryptionDecryptionFunction.getEncryptedData(user.getUserLoginId())
					+ "'>Click Here</a> to verify your registration and wait for approval by Admin." +
					"		</p>" +
					"	</td>" +
					"</tr>");
			body.append(Common_Constants.emailFooterNew);
			List<String> to = new ArrayList<String>();
			if (!request.getRequestURL().toString().contains(Common_Constants.applicationUrl)) {
				to.add(Common_Constants.toMailIdTesting);
			} else {
				to.add(user.getUserLoginId());
			}
			mailService.sendToCcBccMail("Account Created - IFC Portal", body.toString(), to, null, null);
			to = null;
			body.setLength(0);
			body = null;
			currDate = null;
			formatter = null;
			currUser = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String getUserDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> userDetails = new HashMap<String, String>();
		try {
			M_User user = mUserDao.findById(Long.parseLong("" + request.getParameter("mUserId"))).get();
			userDetails.put("userFirstName", user.getUserFirstName());
			if (user.getUserMiddleName() != null) {
				userDetails.put("userMiddleName", user.getUserMiddleName());
			} else {
				userDetails.put("userMiddleName", "");
			}
			StringBuilder userRoles = new StringBuilder();
			for (M_User_Role_Map userRole : user.getUserInfoForRole()) {
				if (userRole.getUserRoleActive().compareTo(1) == 0) {
					if (!userRoles.toString().isEmpty()) {
						userRoles.append("," + userRole.getRoleInfoForUsers().getmRoleId());
					} else {
						userRoles.append("" + userRole.getRoleInfoForUsers().getmRoleId());
					}
				}
			}
			userDetails.put("userRoles", userRoles.toString());
			userRoles.setLength(0);
			userRoles = null;

			StringBuilder userApps = new StringBuilder();
			for (M_User_App_Map userApp : user.getUserInfoForApp()) {
				if (userApp.getUserAppActive().compareTo(1) == 0) {
					if (!userApps.toString().isEmpty()) {
						userApps.append("," + userApp.getAppInfoForUsers().getmAppId());
					} else {
						userApps.append("" + userApp.getAppInfoForUsers().getmAppId());
					}
				}
			}
			userDetails.put("userApps", userApps.toString());
			userApps.setLength(0);
			userApps = null;

			userDetails.put("userLastName", user.getUserLastName());
			userDetails.put("userActive", "" + user.getUserActive());
			userDetails.put("userPhoneNumber", "" + user.getUserPhoneNumber());
			userDetails.put("userEntityId", "" + user.getmEntityId().getmEntityId());
			userDetails.put("userEntityName", "" + user.getmEntityId().getEntityName());
			userDetails.put("userEntityLocationId", "" + user.getmEntityId().getLocationId().getmLocationId());
			userDetails.put("userEntityLocationName", "" + user.getmEntityId().getLocationId().getLocationName());
			userDetails.put("userLoginId", user.getUserLoginId());
			userDetails.put("userDesignation", "" + user.getmDesignationId().getDesignationName());
			userDetails.put("userDesignationId", "" + user.getmDesignationId().getmDesignationId());
			userDetails.put("userDepartment", "" + user.getmDepartmentId().getDepartmentName());
			userDetails.put("userDepartmentId", "" + user.getmDepartmentId().getmDepartmentId());
			/*
			 * userDetails.put("userReportingManagerMailId",
			 * ""+user.getUserReportingManagerMail());
			 * userDetails.put("userReportingManagerName",
			 * ""+user.getUserReportingManagerName());
			 */
			userDetails.put("userActive", "" + user.getUserActive());
			Gson gson = new Gson();
			response = gson.toJson(userDetails);
			gson = null;
			user = null;
			userDetails = null;
		} catch (Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@Override
	public String checkUserExists(HttpServletRequest request) {
		try {
			M_User user = mUserDao.findByUserLoginId("" + request.getParameter("userLoginId"));
			if (user != null) {
				if (request.getParameter("register") != null) {
					System.out.println("1");
					return "exists";
				} else if (request.getParameter("mUserId") != null
						&& user.getmUserId().compareTo(Long.parseLong("" + request.getParameter("mUserId"))) != 0) {
					System.out.println("2");
					return "exists";
				} else {
					System.out.println("3");
					return "proceed";
				}
			} else {
				System.out.println("4");
				return "proceed";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	@Override
	@Transactional
	public String verifyEmail(HttpServletRequest request) throws Exception {
		StringBuilder response = new StringBuilder();
		Date currDate = new Date();
		System.out.println(request.getParameter("signup-verification"));
		System.out.println(
				EncryptionDecryptionFunction.getDecryptedData("" + request.getParameter("signup-verification")));
		M_User user = mUserDao.findByUserLoginId(
				EncryptionDecryptionFunction.getDecryptedData("" + request.getParameter("signup-verification")));
		if (user != null) {
			if (user.getUserEmailVerifyToken() != null) {
				user.setUserActive(1);
				user.setUserApproved(1);
				user.setUserApprovedOn(currDate);
				user.setUserEmailVerifyToken(null);
				mUserDao.save(user);

				M_User_Role_Map userRoleMap = new M_User_Role_Map();
				userRoleMap.setUserInfoForRole(user);
				userRoleMap.setRoleInfoForUsers(mRoleDao.findByRoleNameAndRoleActive("Employee", 1).get(0));
				userRoleMap.setUserRoleActive(1);
				userRoleMap.setUserRoleCreatedBy(user);
				userRoleMap.setUserRoleCreatedOn(currDate);
				mUserRoleMapDao.save(userRoleMap);
				userRoleMap = null;
				response.append("verified");
			} else {
				response.append("alreadyverified");
			}
		} else {
			response.append("cannotVerify");
		}
		user = null;
		currDate = null;
		System.out.println(response.toString());
		return response.toString();
	}

	@Override
	public void sendVerificationMail(HttpServletRequest request) {
		try {
			M_User currUser = mUserDao.findByUserLoginId(
					EncryptionDecryptionFunction.getDecryptedData("" + request.getParameter("verifyEmail")));
			StringBuilder body = new StringBuilder();
			body.append(Common_Constants.emailHeadNew);
			Date currDate = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
			body.append("<tr>" +
					"	<td style='padding: 10px 10px 10px 10px;'>" +
					"		<p style='margin: 0; padding:10px 0 0 0;color:#00AEEF;font-size:29px' class='namenow'>" +
					"			<strong>MESSAGE FROM<br>CORPORATE IFC PORTAL</strong>" +
					"		</p>" +
					"		<p style='margin: 0; padding:10px 0 0 0;color:#002E6D;font-size:21.5px' class='namenow'>" +
					"			Email Verification Complete Complete - IFC Portal" +
					"		</p>" +
					"		<br>" +
					"		<p style='margin: 0; padding:10px 0 0 0;' class='namenow'>" +
					"			INTERNAL COMMUNICATION<br>" +
					"" + formatter.format(currDate) +
					"		</p>" +
					"	</td>" +
					"</tr>");
			body.append("<tr>" +
					"	<td style='padding: 10px 10px 10px 10px;'>" +
					"		<p style='margin: 0;padding-bottom:10px;' class='namenow'>" +
					"			Dear " + currUser.getUserFirstName() + " " + currUser.getUserLastName() +
					"		</p><br>" +
					"		<p style='margin: 0; padding:10px 0 0 0;' class='namenow'>" +
					"			Thanks you for verifying your email, your verification is complete.<br>" +
					"		</p>" +
					"	</td>" +
					"</tr>");
			currDate = null;
			formatter = null;
			body.append(Common_Constants.emailFooterNew);
			List<String> to = new ArrayList<String>();
			if (request.getRequestURL().toString().contains("localhost")) {
				to.add("sheshadhri.iyer@anandgroupindia.com");
			} else if (request.getRequestURL().toString().contains("172.16.6.42")) {
				to.add("sheshadhri.iyer@anandgroupindia.com");
			} else {
				to.add("sheshadhri.iyer@anandgroupindia.com");
			}
			mailService.sendToCcBccMail("Email Verification Complete - ANAND Project", body.toString(), to, null, null);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void resetLoginAttempts(String userLoginId) {
		try {
			M_User mUser = mUserDao.findByUserLoginId(userLoginId);
			mUser.setUserLoginCount(0);
			mUserDao.save(mUser);
		} catch (Exception e) {
			System.out.println("excep");
			e.printStackTrace();
		}
	}

	@Override
	public void incrementLoginCount(String userLoginId) {
		try {
			M_User mUser = mUserDao.findByUserLoginId(userLoginId);
			System.out.println("Login Count: " + mUser.getUserLoginCount());
			if (mUser.getUserLoginCount() != null) {
				mUser.setUserLoginCount(mUser.getUserLoginCount() + 1);
			} else {
				mUser.setUserLoginCount(1);
			}
			mUserDao.save(mUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<String> getUserRolesByUserLoginId(String userLoginId) {
		try {
			M_User user = mUserDao.findByUserLoginId(userLoginId);
			List<M_User_Role_Map> userRoleInfo = mUserRoleMapDao.findByUserInfoForRole(user);
			List<String> roles = new ArrayList<String>();
			for (M_User_Role_Map object : userRoleInfo) {
				if (object.getUserRoleActive().compareTo(1) == 0) {
					roles.add(object.getRoleInfoForUsers().getRoleName());
				}
			}
			userRoleInfo = null;
			user = null;
			return roles;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Boolean checkUserExists(String userEmailId) {
		try {
			if (mUserDao.findByUserLoginId(userEmailId) != null) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public String getUserPassword(String userEmailId) {
		try {
			return mUserDao.findByUserLoginId(userEmailId).getUserPassword();
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	@Override
	public String updateUserOtp(HttpServletRequest request, M_User user, Integer otp) throws Exception {
		System.out.println("=============" + otp);

		// Assuming user's email is available from the passed `user` object
		String email = user.getUserLoginId();

		// Fetch the existing user record based on email
		M_User existingUser = mUserDao.findByUserLoginId(email); // Adjust based on your DAO method

		if (existingUser != null) {
			existingUser.setUserOTP(otp);
			mUserDao.save(existingUser);
			System.out.println("OTP updated successfully for user: " + email);
		} else {
			System.out.println("User not found with email: " + email);
			// Optional: throw exception or handle gracefully
		}

		return "";
	}

	@Override
	public boolean otpValidate(M_User currUser, Integer requestOtp) {

		String email = currUser.getUserLoginId();

		// Fetch the existing user record based on email
		M_User existingUser = mUserDao.findByUserLoginId(email); // Adjust based on your DAO method

		// System.out.println(("existingUser==="+existingUser.getUserOTP()==requestOtp));
		boolean flag = false;
		if (existingUser != null) {
			System.out.println(("existingUser===" + existingUser.getUserOTP() + "==" + requestOtp));

			if (existingUser.getUserOTP() != null && existingUser.getUserOTP().equals(requestOtp)) {
				flag = true;
			} else {
				flag = false;
			}

		} else {
			System.out.println("User not found with email: " + email);
			// Optional: throw exception or handle gracefully
		}
		return flag;
	}

	@Override
    public String resetPassword(HttpServletRequest request) {
        StringBuilder response = new StringBuilder();
        try {
            char[] caps = new char[]{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
            int[] nums = new int[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
            char[] smalls = new char[]{'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'y', 'z'};
            char[] spl = new char[]{'!', '@', '#', '$', '%', '^'};
            String password = "";
            for (int i = 0; i < 4; i++) {
                password += "" + caps[new Random().nextInt(caps.length)];
            }
            for (int i = 0; i < 1; i++) {
                password += "" + spl[new Random().nextInt(spl.length)];
            }
            for (int i = 0; i < 3; i++) {
                password += "" + smalls[new Random().nextInt(smalls.length)];
            }
            for (int i = 0; i < 2; i++) {
                password += "" + nums[new Random().nextInt(nums.length)];
            }
            BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
            M_User user = mUserDao.findByUserLoginId(request.getParameter("email"));
            if(user != null){
            	user.setUserPassword(bCryptPasswordEncoder.encode(password));
                user.setUserPasswordTwo(EncryptionDecryptionFunction.getEncryptedData(password));
                /*String salt = PasswordSaltHashUtils.generateRandomSalt();
                user.setUserPasswordSalt(salt);
                String hashedPassword = PasswordSaltHashUtils.hashPassword(password,salt);
                user.setUserPasswordHash(hashedPassword);
                user.setForgotToken(password);*/
                mUserDao.save(user);
                StringBuilder body = new StringBuilder();
                body.append(Common_Constants.emailHeadNew);
                body.append("<tr>");
                body.append("<td class='bodyPadd' colspan='3' style='font-size:15px' >");
                body.append("<p style='margin: 0; font-size:15px;'>");
                body.append("Password has been changed successfully.<br><br>");
                body.append("Your new password for the tool : " + password + "<br><br>");
                body.append("For clarification mail to Tool SPOC.");
                body.append("</p><br>");
                body.append("</td>");
                body.append("</tr>");
                body.append(Common_Constants.emailFooterNew);
                mailService.sendEmail("Password Reset - ANAND Coaching Portal", body.toString(), user.getUserLoginId());
                response.append("done");
            } else {
            	response.append("Email does not exists.");
            }
            user = null; bCryptPasswordEncoder = null; password = null;
            spl = null; smalls = null; caps = null; nums = null;
        } catch (Exception e) {
            e.printStackTrace();
            response.setLength(0);
            response.append("error");
            response.append("Email does not exists.");
        }
        return response.toString();
    }

	@Override
	public List<M_Entity> getUserEntityMapForVimsRegistration(HttpServletRequest request) {
		// TODO Auto-generated method stub
		try {
			Integer activenessCheck = 1;
			if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) || 
					(request.getSession(true).getAttribute("vimAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimAdmin"))) == 0)) {
				return mEntityDao.findByEntityActiveAndEntitySourceIsNotNull(1);
			} else if(request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0) {
				M_User currUser = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
				List<M_Entity> entityList = new ArrayList<M_Entity>();
				for(M_User_Entity_Map userEntityMap : currUser.getUserInfoForEntity()) {
					if(userEntityMap.getUserEntityActive().compareTo(activenessCheck) == 0) {
						entityList.add(userEntityMap.getEntityInfoForUsers());
					}
				}
				currUser = null;
				return entityList;
			} else {
				return null;
			}
		} catch(Exception e) {
			return null;
		}
	}

	@Override
	public List<M_User> getUserByEntityId(Long mEntityId, HttpServletRequest request) {
		// TODO Auto-generated method stub
		try {
			Integer activenessCheck = 1;
			System.out.println("11");
			if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) || 
					(request.getSession(true).getAttribute("vimsAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsAdmin"))) == 0) ||
					(request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) {
				activenessCheck = null;
				System.out.println("22");
				return mUserDao.findBymEntityIdAndUserActive(mEntityDao.findById(mEntityId).get(), 1);
			} else {
				activenessCheck = null;
				System.out.println("33");
				List<M_User> userList = new ArrayList<M_User>();
				userList.add((M_User) request.getSession(true).getAttribute("sessionUserInfo"));
				return userList;
			}
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}