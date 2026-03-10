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
public class VMS_M_Visitor_Purpose_Service_Impl implements VMS_M_Visitor_Purpose_Service {

	@Autowired private VMS_M_Visitor_Purpose_Dao mVisitorPurposeDao;
	@Autowired private VMS_M_Visitor_Purpose_History_Dao mVisitorPurposeHistoryDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private InputValidation inputVaildationService;

	@Override
	public List<VMS_M_Visitor_Purpose> getVisitorPurposeList(HttpServletRequest request, Integer offset) {
		List<VMS_M_Visitor_Purpose> finalVisitorPurposeList = new ArrayList<VMS_M_Visitor_Purpose>();
		try {
			List<VMS_M_Visitor_Purpose> visitorPurposeList = null;
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				visitorPurposeList = mVisitorPurposeDao.findAll();
			} else {
				visitorPurposeList = mVisitorPurposeDao.getVisitorPurposeWithOffset(offset);
			}
			for(VMS_M_Visitor_Purpose visitorPurpose : visitorPurposeList) {
				visitorPurpose.setActionForList("");
				if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
					|| (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
					visitorPurpose.setActionForList("<a href='#' title='Edit Visitor Purpose' onclick='editVisitorPurpose("+visitorPurpose.getMVisitorPurposeId()+");'><i class='fas fa-edit'></i></a>");
				}
				finalVisitorPurposeList.add(visitorPurpose);
			}
			Collections.sort(finalVisitorPurposeList);
		} catch(Exception e) {
			e.printStackTrace();
			finalVisitorPurposeList.clear(); finalVisitorPurposeList = null;
		}
		return finalVisitorPurposeList;
	}

	@Override
	public List<VMS_M_Visitor_Purpose> getVisitorPurposeByActiveStatus(Integer visitorPurposeActive) {
		List<VMS_M_Visitor_Purpose> visitorPurposeList = null;
		try {
			visitorPurposeList = mVisitorPurposeDao.findByVisitorPurposeActive(visitorPurposeActive);
			Collections.sort(visitorPurposeList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return visitorPurposeList;
	}

	@Override
	@Transactional
	public String saveVisitorPurposeDetails(HttpServletRequest request, VMS_M_Visitor_Purpose visitorPurpose) {
		StringBuilder response = new StringBuilder();
		if(!inputVaildationService.stringOnlyValidation(visitorPurpose.getVisitorPurposeName())) {
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
		if(visitorPurpose.getMVisitorPurposeId() != null) {
			VMS_M_Visitor_Purpose currVisitorPurpose = mVisitorPurposeDao.findById(Long.parseLong(""+visitorPurpose.getMVisitorPurposeId())).get();
			Integer proceedFlag = 0;
			List<VMS_M_Visitor_Purpose> visitorPurposeExists = mVisitorPurposeDao.findByVisitorPurposeName(visitorPurpose.getVisitorPurposeName());
			if(visitorPurposeExists != null && visitorPurposeExists.size() != 0) {
				for(VMS_M_Visitor_Purpose visitorPurposeDetails : visitorPurposeExists) {
					if(visitorPurpose.getVisitorPurposeName().equalsIgnoreCase(visitorPurposeDetails.getVisitorPurposeName()) && currVisitorPurpose.getMVisitorPurposeId().compareTo(visitorPurposeDetails.getMVisitorPurposeId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			visitorPurposeExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				if(currVisitorPurpose.getVisitorPurposeName().equalsIgnoreCase(visitorPurpose.getVisitorPurposeName()) &&
						currVisitorPurpose.getVisitorPurposeActive().compareTo(visitorPurpose.getVisitorPurposeActive()) == 0) {
					response.append("noChange");
				} else {
					VMS_M_Visitor_Purpose_History visitorPurposeHistory = new VMS_M_Visitor_Purpose_History();
					visitorPurposeHistory.setParentVisitorPurpose(currVisitorPurpose);
					visitorPurposeHistory.setVisitorPurposeActive(currVisitorPurpose.getVisitorPurposeActive());
					visitorPurposeHistory.setVisitorPurposeName(currVisitorPurpose.getVisitorPurposeName());
					visitorPurposeHistory.setVisitorPurposeHistoryCreatedBy(user);
					visitorPurposeHistory.setVisitorPurposeHistoryCreatedOn(currDate);
					mVisitorPurposeHistoryDao.save(visitorPurposeHistory);
					visitorPurposeHistory = null;

					currVisitorPurpose.setVisitorPurposeName(visitorPurpose.getVisitorPurposeName());
					currVisitorPurpose.setVisitorPurposeActive(visitorPurpose.getVisitorPurposeActive());
					currVisitorPurpose.setVisitorPurposeUpdatedBy(user);
					currVisitorPurpose.setVisitorPurposeUpdatedOn(currDate);
					mVisitorPurposeDao.save(currVisitorPurpose);
					currVisitorPurpose = null;
					response.append("edit");
				}
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
		} else {
			List<VMS_M_Visitor_Purpose> visitorPurposeExists = mVisitorPurposeDao.findByVisitorPurposeName(visitorPurpose.getVisitorPurposeName());
			if(visitorPurposeExists != null && visitorPurposeExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				visitorPurpose.setVisitorPurposeCreatedBy(user);
				visitorPurpose.setVisitorPurposeCreatedOn(currDate);
				visitorPurpose.setVisitorPurposeActive(visitorPurpose.getVisitorPurposeActive());
				mVisitorPurposeDao.save(visitorPurpose);
				response.append("add");
			}
			visitorPurposeExists = null;
		}
		currDate = null; user = null;
		return response.toString();
	}

	@Override
	public String getVisitorPurposeDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> visitorPurposeDetails = new HashMap<String, String>();
		try {
			/*VMS_M_Visitor_Purpose visitorPurpose = mVisitorPurposeDao.getOne(Integer.parseInt(""+request.getParameter("mVisitorPurposeId")));*/
			VMS_M_Visitor_Purpose visitorPurpose = mVisitorPurposeDao.findById(Long.parseLong(""+request.getParameter("mVisitorPurposeId"))).get();
			visitorPurposeDetails.put("visitorPurposeName", visitorPurpose.getVisitorPurposeName());
			visitorPurposeDetails.put("visitorPurposeActive", ""+visitorPurpose.getVisitorPurposeActive());
			Gson gson = new Gson();
			response = gson.toJson(visitorPurposeDetails);
			gson = null; visitorPurpose = null; visitorPurposeDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

}