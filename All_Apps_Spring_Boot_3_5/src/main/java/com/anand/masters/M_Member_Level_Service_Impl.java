/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - R S Iyer
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
public class M_Member_Level_Service_Impl implements M_Member_Level_Service {

	@Autowired private M_Member_Level_Dao mMemberLevelDao;
	@Autowired private M_Member_Level_History_Dao mMemberLevelHistoryDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private InputValidation inputValidationService;

	@Override
	public List<M_Member_Level> getMemberLevelList(HttpServletRequest request, Integer offset) {
		List<M_Member_Level> finalMemberLevelList = new ArrayList<M_Member_Level>();
		try {
			List<M_Member_Level> memberLevelList = new ArrayList<M_Member_Level>();
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				memberLevelList.addAll(mMemberLevelDao.findAll());
			} else {
				Pageable pageable = PageRequest.of(offset/20, 20);
				memberLevelList.addAll(mMemberLevelDao.findAll(pageable).toList());
				pageable = null;
			}
			for(M_Member_Level memberLevel : memberLevelList) {
				memberLevel.setActionForList("");
				if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
					|| (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
					memberLevel.setActionForList("<a href='#' title='Edit Member Level' onclick='editMemberLevel("+memberLevel.getmMemberLevelId()+");'><i class='fas fa-edit'></i></a>");
				}
				finalMemberLevelList.add(memberLevel);
			}
			Collections.sort(finalMemberLevelList);
			memberLevelList.clear(); memberLevelList = null;
		} catch(Exception e) {
			e.printStackTrace();
			finalMemberLevelList.clear(); finalMemberLevelList = null;
		}
		return finalMemberLevelList;
	}

	@Override
	public List<M_Member_Level> getMemberLevelByActiveStatus(Integer memberLevelActive) {
		List<M_Member_Level> memberLevelList = null;
		try {
			memberLevelList = mMemberLevelDao.findByMemberLevelActive(memberLevelActive);
			Collections.sort(memberLevelList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return memberLevelList;
	}

	@Override
	@Transactional
	public String saveMemberLevelDetails(HttpServletRequest request, M_Member_Level memberLevel) {
		StringBuilder response = new StringBuilder();
		if(!inputValidationService.alphaNumericValidationWithSpace(memberLevel.getMemberLevelName())) {
			System.out.println("name");
			response.append("error");
		}
		if(!inputValidationService.alphaNumericValidationWithSpace(memberLevel.getMemberLevelDescription())) {
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
		if(memberLevel.getmMemberLevelId() != null) {
			M_Member_Level currMemberLevel = mMemberLevelDao.findById(Long.parseLong(""+memberLevel.getmMemberLevelId())).get();
			Integer proceedFlag = 0;
			List<M_Member_Level> memberLevelExists = mMemberLevelDao.findByMemberLevelName(memberLevel.getMemberLevelName());
			if(memberLevelExists != null && memberLevelExists.size() != 0) {
				for(M_Member_Level memberLevelDetails : memberLevelExists) {
					if(memberLevel.getMemberLevelName().equalsIgnoreCase(memberLevelDetails.getMemberLevelName()) && currMemberLevel.getmMemberLevelId().compareTo(memberLevelDetails.getmMemberLevelId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			memberLevelExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				if(memberLevel.getMemberLevelName().equalsIgnoreCase(currMemberLevel.getMemberLevelName()) &&
						memberLevel.getMemberLevelDescription().equalsIgnoreCase(currMemberLevel.getMemberLevelDescription())) {
					response.append("noChange");
				} else {
					M_Member_Level_History memberLevelHistory = new M_Member_Level_History();
					memberLevelHistory.setParentMemberLevel(currMemberLevel);
					memberLevelHistory.setMemberLevelActive(currMemberLevel.getMemberLevelActive());
					memberLevelHistory.setMemberLevelName(currMemberLevel.getMemberLevelName());
					memberLevelHistory.setMemberLevelDescription(currMemberLevel.getMemberLevelDescription());
					memberLevelHistory.setMemberLevelCreatedBy(user);
					memberLevelHistory.setMemberLevelCreatedOn(currDate);
					mMemberLevelHistoryDao.save(memberLevelHistory);
					memberLevelHistory = null;

					currMemberLevel.setMemberLevelName(memberLevel.getMemberLevelName());
					currMemberLevel.setMemberLevelDescription(memberLevel.getMemberLevelDescription());
					currMemberLevel.setMemberLevelActive(memberLevel.getMemberLevelActive());
					currMemberLevel.setMemberLevelUpdatedBy(user);
					currMemberLevel.setMemberLevelUpdatedOn(currDate);
					mMemberLevelDao.save(currMemberLevel);
					currMemberLevel = null;
					response.append("edit");
				}
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
		} else {
			List<M_Member_Level> memberLevelExists = mMemberLevelDao.findByMemberLevelName(memberLevel.getMemberLevelName());
			if(memberLevelExists != null && memberLevelExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				memberLevel.setMemberLevelCreatedBy(user);
				memberLevel.setMemberLevelCreatedOn(currDate);
				mMemberLevelDao.save(memberLevel);
				response.append("add");
			}
			memberLevelExists = null;
		}
		currDate = null; user = null;
		return response.toString();
	}

	@Override
	public String getMemberLevelDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> memberLevelDetails = new HashMap<String, String>();
		try {
			M_Member_Level memberLevel = mMemberLevelDao.findById(Long.parseLong(""+request.getParameter("mMemberLevelId"))).get();
			System.out.println(request.getParameter("mMemberLevelId"));
			memberLevelDetails.put("memberLevelName", memberLevel.getMemberLevelName());
			memberLevelDetails.put("memberLevelDescription", memberLevel.getMemberLevelDescription());
			memberLevelDetails.put("memberLevelActive", ""+memberLevel.getMemberLevelActive());
			Gson gson = new Gson();
			response = gson.toJson(memberLevelDetails);
			gson = null; memberLevel = null; memberLevelDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}

}