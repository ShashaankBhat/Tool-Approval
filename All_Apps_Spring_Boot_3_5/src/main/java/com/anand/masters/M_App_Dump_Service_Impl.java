/**
 * *******************************************************************************************
 * Copyright © 2025 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - S Iyer
 */
package com.anand.masters;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.common.InputValidation;
import com.google.gson.Gson;

@Service
public class M_App_Dump_Service_Impl implements M_App_Dump_Service {

	@Autowired private M_App_Dump_Dao mAppDumpDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private M_Entity_Dao mEntityDao;
	@Autowired private M_Department_Dao mDepartmentDao;
	@Autowired private InputValidation inputVaildationService;

	@Override
	public List<M_App_Dump> getAppDumpList(HttpServletRequest request, Integer offset) {
		List<M_App_Dump> finalAppList = new ArrayList<M_App_Dump>();
		try {
			List<M_App_Dump> appList = new ArrayList<M_App_Dump>();
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				appList.addAll(mAppDumpDao.findAll());
			} else {
				/* appList = mAppDumpDao.getAppDumpWithOffset(offset); */
				Pageable pageable = PageRequest.of(offset/20, 20);
				appList.addAll(mAppDumpDao.findAll(pageable).toList());
				pageable = null;
			}
			for(M_App_Dump app : appList) {
				app.setActionForList("");
				StringBuilder action = new StringBuilder();
				if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
					|| (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
					action.append("<a href='#' title='Edit App Dump' onclick='editApp("+app.getmAppDumpId()+");'><i class='fas fa-edit'></i></a>");
					/*app.setActionForList("<a href='#' title='Edit App Dump' onclick='editApp("+app.getmAppDumpId()+");'><i class='fas fa-edit'></i></a>");*/
				}
				if(action.toString().isEmpty()) {
					action.append("<a class='small-box-footer' target='_target' href='"+app.getAppDumpLink()+"'><i class='fas fa-arrow-circle-right'></i></a>");
				} else {
					action.append("&ensp;<a title='"+app.getAppDumpName()+"' class='small-box-footer' target='_target' href='"+app.getAppDumpLink()+"'><i class='fas fa-arrow-circle-right'></i></a>");
				}
				app.setActionForList(action.toString());
				finalAppList.add(app);
			}
			Collections.sort(finalAppList);
			appList.clear(); appList = null;
		} catch(Exception e) {
			e.printStackTrace();
			finalAppList.clear(); finalAppList = null;
		}
		return finalAppList;
	}

	@Override
	public List<M_App_Dump> getAppDumpByActiveStatus(Integer appActive) {
		List<M_App_Dump> appList = null;
		try {
			appList = mAppDumpDao.findByAppDumpActive(appActive);
			Collections.sort(appList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return appList;
	}

	@Override
	@Transactional
	public String saveAppDumpDetails(HttpServletRequest request, M_App_Dump appDump) {
		StringBuilder response = new StringBuilder();
		if(!inputVaildationService.stringOnlyValidation(appDump.getAppDumpName())) {
			System.out.println("name");
			response.append("error");
		}
		if(!inputVaildationService.urlValidation(appDump.getAppDumpLink())) {
			System.out.println("Link Error");
			response.append("error");
		}
		if(!inputVaildationService.alphaNumericValidationWithSpace(appDump.getAppDumpDescription())) {
			System.out.println("Desc 1");
			response.append("error");
		}
		if(!inputVaildationService.alphaNumericValidationWithSpace(appDump.getAppDumpDescription2())) {
			System.out.println("Desc 2");
			response.append("error");
		}
		/*response.append("error");*/
		if(response.toString().contains("error")) {
			response.setLength(0);
			response.append("error");
			return response.toString();
		}
		response.setLength(0);
		M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		if(appDump.getmAppDumpId() != null) {
			M_App_Dump currAppDump = mAppDumpDao.findById(Long.parseLong(""+appDump.getmAppDumpId())).get();
			Integer proceedFlag = 0;
			List<M_App_Dump> appExists = mAppDumpDao.findByAppDumpName(appDump.getAppDumpName());
			List<M_App_Dump> appExistsTemp = appExists.stream()
				.filter(appExist -> appDump.getAppDumpName().equalsIgnoreCase(appExist.getAppDumpName()))
				.filter(appExist -> appDump.getmAppDumpId() != appExist.getmAppDumpId())
				.collect(Collectors.toList());
			if(appExistsTemp != null) {
				System.out.println("appExistsTemp: "+appExistsTemp.size());
			} else {
				System.out.println("appExistsTemp: null");
			}
			appExistsTemp = null;
			if(appExists != null && appExists.size() != 0) {
				for(M_App_Dump appDetails : appExists) {
					if(appDump.getAppDumpName().equalsIgnoreCase(appDetails.getAppDumpName()) && 
							currAppDump.getmAppDumpId().compareTo(appDetails.getmAppDumpId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			appExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				currAppDump.setAppDumpName(appDump.getAppDumpName());
				currAppDump.setAppDumpLink(appDump.getAppDumpLink());
				currAppDump.setAppDumpDescription(appDump.getAppDumpDescription());
				currAppDump.setAppDumpDescription2(appDump.getAppDumpDescription2());
				currAppDump.setAppDumpActive(appDump.getAppDumpActive());
				if(appDump.getTempEntityId() != null) {
					if(appDump.getTempEntityId().compareTo(-1l) == 0) {
						currAppDump.setAppDumpEntity(null);
					} else {
						currAppDump.setAppDumpEntity(mEntityDao.findById(appDump.getTempEntityId()).get());
					}
				} else {
					currAppDump.setAppDumpEntity(null);
				}
				if(appDump.getTempDepartmentId() != null) {
					if(appDump.getTempDepartmentId().compareTo(-1l) == 0) {
						currAppDump.setAppDumpDepartment(null);
					} else {
						currAppDump.setAppDumpDepartment(mDepartmentDao.findById(appDump.getTempDepartmentId()).get());
					}
				} else {
					currAppDump.setAppDumpDepartment(null);
				}
				currAppDump.setAppDumpUpdatedBy(user);
				currAppDump.setAppDumpUpdatedOn(currDate);
				mAppDumpDao.save(currAppDump);
				currAppDump = null;
				response.append("edit");
			} else {
				response.append("nameExists1");
			}
			proceedFlag = null;
		} else {
			List<M_App_Dump> appExists = mAppDumpDao.findByAppDumpName(appDump.getAppDumpName());
			if(appExists != null && appExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				if(appDump.getTempEntityId().compareTo(-1l) != 0) {
					appDump.setAppDumpEntity(mEntityDao.findById(appDump.getTempEntityId()).get());
				}
				if(appDump.getTempDepartmentId().compareTo(-1l) != 0) {
					appDump.setAppDumpDepartment(mDepartmentDao.findById(appDump.getTempDepartmentId()).get());
				}
				appDump.setAppDumpCreatedBy(user);
				appDump.setAppDumpCreatedOn(currDate);
				mAppDumpDao.save(appDump);
				response.append("add");
			}
			appExists = null;
		}
		currDate = null; user = null;
		return response.toString();
	}

	@Override
	public String getAppDumpDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> appDetails = new HashMap<String, String>();
		try {
			M_App_Dump app = mAppDumpDao.findById(Long.parseLong(""+request.getParameter("mAppDumpId"))).get();
			appDetails.put("appDumpName", app.getAppDumpName());
			appDetails.put("appDumpLink", app.getAppDumpLink());
			appDetails.put("appDumpDescription", app.getAppDumpDescription());
			appDetails.put("appDumpDescription2", app.getAppDumpDescription2());
			appDetails.put("appDumpActive", ""+app.getAppDumpActive());
			if(app.getAppDumpEntity() != null) {
				appDetails.put("appDumpEntityId", ""+app.getAppDumpEntity().getmEntityId());
			}
			if(app.getAppDumpDepartment() != null) {
				appDetails.put("appDumpDepartmentId", ""+app.getAppDumpDepartment().getmDepartmentId());
			}
			Gson gson = new Gson();
			response = gson.toJson(appDetails);
			gson = null; app = null; appDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

	@Override
	public List<M_App_Dump> getAppDumpListByEntity(Long mEntityId) {
		try {
			List<M_App_Dump> finalAppDumpList = new ArrayList<M_App_Dump>();
			if(mEntityId.compareTo(-1l) == 0) {
				finalAppDumpList = mAppDumpDao.findByAppDumpEntity(null);
			} else {
				finalAppDumpList = mAppDumpDao.findByAppDumpEntity(mEntityDao.findById(mEntityId).get());
			}
			return finalAppDumpList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<M_App_Dump> getAppDumpListByEntityName(String entityName) {
		try {
			List<M_App_Dump> finalAppDumpList = new ArrayList<M_App_Dump>();
			finalAppDumpList = mAppDumpDao.findByAppDumpEntity(mEntityDao.findByEntitySourceAndEntityName(null, entityName).get(0));
			return finalAppDumpList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}