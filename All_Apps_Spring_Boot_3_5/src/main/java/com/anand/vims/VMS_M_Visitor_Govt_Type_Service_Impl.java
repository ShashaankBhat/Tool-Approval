/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - R S Iyer
 */
package com.anand.vims;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.common.InputValidation;
import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;
import com.google.gson.Gson;

@Service
public class VMS_M_Visitor_Govt_Type_Service_Impl implements VMS_M_Visitor_Govt_Type_Service {

	@Autowired private VMS_M_Visitor_Govt_Type_Dao mVisitorTypeDao;
	@Autowired private VMS_M_Visitor_Govt_Type_History_Dao mVisitorTypeHistoryDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private InputValidation inputVaildationService;

	@Override
	public List<VMS_M_Visitor_Govt_Type> getVisitorTypeList(HttpServletRequest request, Integer offset) {
		List<VMS_M_Visitor_Govt_Type> finalVisitorTypeList = new ArrayList<VMS_M_Visitor_Govt_Type>();
		try {
			List<VMS_M_Visitor_Govt_Type> visitorTypeList = null;
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				visitorTypeList = mVisitorTypeDao.findAll();
			} else {
				visitorTypeList = mVisitorTypeDao.getVisitorTypeWithOffset(offset);
			}
			for(VMS_M_Visitor_Govt_Type visitorType : visitorTypeList) {
				visitorType.setActionForList("");
				if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
					|| (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
					visitorType.setActionForList("<a href='#' title='Edit Visitor Type' onclick='editVisitorType("+visitorType.getMVisitorTypeId()+");'><i class='fas fa-edit'></i></a>");
				}
				finalVisitorTypeList.add(visitorType);
			}
			Collections.sort(finalVisitorTypeList);
		} catch(Exception e) {
			e.printStackTrace();
			finalVisitorTypeList.clear(); finalVisitorTypeList = null;
		}
		return finalVisitorTypeList;
	}

	@Override
	public List<VMS_M_Visitor_Govt_Type> getVisitorTypeByActiveStatus(Integer visitorTypeGovtActive) {
		List<VMS_M_Visitor_Govt_Type> visitorTypeList = null;
		try {
			visitorTypeList = mVisitorTypeDao.findByVisitorTypeActive(visitorTypeGovtActive);
			Collections.sort(visitorTypeList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return visitorTypeList;
	}

	@Override
	@Transactional
	public String saveVisitorTypeDetails(HttpServletRequest request, VMS_M_Visitor_Govt_Type visitorType) {
		StringBuilder response = new StringBuilder();
		if(!inputVaildationService.stringOnlyValidation(visitorType.getVisitorTypeName())) {
			System.out.println("name");
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
		if(visitorType.getMVisitorTypeId() != null) {
			VMS_M_Visitor_Govt_Type currVisitorType = mVisitorTypeDao.findById(Long.parseLong(""+visitorType.getMVisitorTypeId())).get();
			Integer proceedFlag = 0;
			List<VMS_M_Visitor_Govt_Type> visitorTypeExists = mVisitorTypeDao.findByVisitorTypeName(visitorType.getVisitorTypeName());
			if(visitorTypeExists != null && visitorTypeExists.size() != 0) {
				for(VMS_M_Visitor_Govt_Type visitorTypeDetails : visitorTypeExists) {
					if(visitorType.getVisitorTypeName().equalsIgnoreCase(visitorTypeDetails.getVisitorTypeName()) && currVisitorType.getMVisitorTypeId().compareTo(visitorTypeDetails.getMVisitorTypeId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			visitorTypeExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				if(currVisitorType.getVisitorTypeName().equalsIgnoreCase(visitorType.getVisitorTypeName()) &&
				currVisitorType.getVisitorTypeActive().compareTo(visitorType.getVisitorTypeActive()) == 0) {
					response.append("noChange");
				} else {
					VMS_M_Visitor_Govt_Type_History visitorTypeHistory = new VMS_M_Visitor_Govt_Type_History();
					visitorTypeHistory.setParentVisitorType(currVisitorType);
					visitorTypeHistory.setVisitorTypeActive(currVisitorType.getVisitorTypeActive());
					visitorTypeHistory.setVisitorTypeName(currVisitorType.getVisitorTypeName());
					visitorTypeHistory.setVisitorTypeHistoryCreatedBy(user);
					visitorTypeHistory.setVisitorTypeHistoryCreatedOn(currDate);
					mVisitorTypeHistoryDao.save(visitorTypeHistory);
					visitorTypeHistory = null;

					currVisitorType.setVisitorTypeName(visitorType.getVisitorTypeName());
					currVisitorType.setVisitorTypeActive(visitorType.getVisitorTypeActive());
					currVisitorType.setVisitorTypeUpdatedBy(user);
					currVisitorType.setVisitorTypeUpdatedOn(currDate);
					mVisitorTypeDao.save(currVisitorType);
					currVisitorType = null;
					response.append("edit");
				}
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
		} else {
			List<VMS_M_Visitor_Govt_Type> visitorTypeExists = mVisitorTypeDao.findByVisitorTypeName(visitorType.getVisitorTypeName());
			if(visitorTypeExists != null && visitorTypeExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				visitorType.setVisitorTypeCreatedBy(user);
				visitorType.setVisitorTypeCreatedOn(currDate);
				visitorType.setVisitorTypeActive(visitorType.getVisitorTypeActive());
				mVisitorTypeDao.save(visitorType);
				response.append("add");
			}
			visitorTypeExists = null;
		}
		currDate = null; user = null;
		return response.toString();
	}

	@Override
	public String getVisitorTypeDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> visitorTypeDetails = new HashMap<String, String>();
		try {
			/*VMS_M_Visitor_Govt_Type visitorType = mVisitorTypeDao.getOne(Integer.parseInt(""+request.getParameter("mVisitorTypeId")));*/
			VMS_M_Visitor_Govt_Type visitorType = mVisitorTypeDao.findById(Long.parseLong(""+request.getParameter("mVisitorTypeId"))).get();
			visitorTypeDetails.put("visitorTypeName", visitorType.getVisitorTypeName());
			visitorTypeDetails.put("visitorTypeActive", ""+visitorType.getVisitorTypeActive());
			Gson gson = new Gson();
			response = gson.toJson(visitorTypeDetails);
			gson = null; visitorType = null; visitorTypeDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

}