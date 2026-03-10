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
public class M_App_Service_Impl implements M_App_Service {

	@Autowired private M_App_Dao mAppDao;
	@Autowired private M_App_History_Dao mAppHistoryDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private InputValidation inputVaildationService;

	@Override
	public List<M_App> getAppList(HttpServletRequest request, Integer offset) {
		List<M_App> finalAppList = new ArrayList<M_App>();
		try {
			List<M_App> appList = null;
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				appList = mAppDao.findAll();
			} else {
				Pageable pageable = PageRequest.of(offset/20, 20);
				appList = mAppDao.findAll(pageable).toList();
				pageable = null;
			}
			for(M_App app : appList) {
				app.setActionForList("");
				if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
					|| (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
					app.setActionForList("<a href='#' title='Edit App' onclick='editApp("+app.getmAppId()+");'><i class='fas fa-edit'></i></a>");
				}
				finalAppList.add(app);
			}
			Collections.sort(finalAppList);
		} catch(Exception e) {
			e.printStackTrace();
			finalAppList.clear(); finalAppList = null;
		}
		return finalAppList;
	}

	@Override
	public List<M_App> getAppByActiveStatus(Integer appActive) {
		List<M_App> appList = null;
		try {
			appList = mAppDao.findByAppActive(appActive);
			Collections.sort(appList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return appList;
	}

	@Override
	@Transactional
	public String saveAppDetails(HttpServletRequest request, M_App app) {
		StringBuilder response = new StringBuilder();
		if(!inputVaildationService.stringOnlyValidation(app.getAppName())) {
			System.out.println("name");
			response.append("error");
		}
		if(!inputVaildationService.alphaNumericValidationWithoutSpace(app.getAppLink())) {
			System.out.println("link");
			response.append("error");
		}
		if(!inputVaildationService.alphaNumericValidationWithSpace(app.getAppDescription())) {
			System.out.println("Desc 1");
			response.append("error");
		}
		if(!inputVaildationService.alphaNumericValidationWithSpace(app.getAppDescription2())) {
			System.out.println("Desc 2");
			response.append("error");
		}
		if(response.toString().contains("error")) {
			response.setLength(0);
			response.append("error");
			return response.toString();
		}
		response.setLength(0);
		M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		if(app.getmAppId() != null) {
			/*M_App currApp = mAppDao.getOne(app.getmAppId());*/
			M_App currApp = mAppDao.findById(Long.parseLong(""+app.getmAppId())).get();
			Integer proceedFlag = 0;
			List<M_App> appExists = mAppDao.findByAppName(app.getAppName());
			if(appExists != null && appExists.size() != 0) {
				for(M_App appDetails : appExists) {
					if(app.getAppName().equalsIgnoreCase(appDetails.getAppName()) && currApp.getmAppId().compareTo(appDetails.getmAppId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			appExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				M_App_History appHistory = new M_App_History();
				appHistory.setmAppId(currApp);
				appHistory.setAppActive(currApp.getAppActive());
				appHistory.setAppName(currApp.getAppName());
				appHistory.setAppLink(currApp.getAppLink());
				appHistory.setAppDescription(currApp.getAppDescription());
				appHistory.setAppDescription2(currApp.getAppDescription2());
				appHistory.setmUserId(user);
				appHistory.setCreatedOn(currDate);
				mAppHistoryDao.save(appHistory);
				appHistory = null;

				currApp.setAppName(app.getAppName());
				currApp.setAppLink(app.getAppLink());
				currApp.setAppDescription(app.getAppDescription());
				currApp.setAppDescription2(app.getAppDescription2());
				currApp.setAppActive(app.getAppActive());
				currApp.setAppUpdatedBy(user);
				currApp.setAppUpdatedOn(currDate);
				mAppDao.save(currApp);
				currApp = null;
				response.append("edit");
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
		} else {
			List<M_App> appExists = mAppDao.findByAppName(app.getAppName());
			if(appExists != null && appExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				app.setAppCreatedBy(user);
				app.setAppCreatedOn(currDate);
				mAppDao.save(app);
				response.append("add");
			}
			appExists = null;
		}
		currDate = null; user = null;
		return response.toString();
	}

	@Override
	public String getAppDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> appDetails = new HashMap<String, String>();
		try {
			M_App app = mAppDao.findById(Long.parseLong(""+request.getParameter("mAppId"))).get();
			appDetails.put("appName", app.getAppName());
			appDetails.put("appLink", app.getAppLink());
			appDetails.put("appDescription", app.getAppDescription());
			appDetails.put("appDescription2", app.getAppDescription2());
			appDetails.put("appActive", ""+app.getAppActive());
			Gson gson = new Gson();
			response = gson.toJson(appDetails);
			gson = null; app = null; appDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}
}