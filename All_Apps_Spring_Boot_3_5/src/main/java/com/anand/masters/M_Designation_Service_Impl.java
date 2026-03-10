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
public class M_Designation_Service_Impl implements M_Designation_Service {

	@Autowired private M_Designation_Dao mDesignationDao;
	@Autowired private M_Designation_History_Dao mDesignationHistoryDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private InputValidation inputValidationService;

	@Override
	public List<M_Designation> getDesignationList(HttpServletRequest request, Integer offset) {
		List<M_Designation> finalDesignationList = new ArrayList<M_Designation>();
		try {
			List<M_Designation> designationList = new ArrayList<M_Designation>();
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				designationList.addAll(mDesignationDao.findAll());
			} else {
				Pageable pageable = PageRequest.of(offset/20, 20);
				designationList.addAll(mDesignationDao.findAll(pageable).toList());
				pageable = null;
			}
			for(M_Designation designation : designationList) {
				designation.setActionForList("");
				if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
					|| (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
					designation.setActionForList("<a href='#' title='Edit Designation' onclick='editDesignation("+designation.getmDesignationId()+");'><i class='fas fa-edit'></i></a>");
				}
				finalDesignationList.add(designation);
			}
			activenessCheck = null;
			designationList = mDesignationDao.findAll();
			Collections.sort(finalDesignationList);
			designationList.clear();designationList = null;
		} catch(Exception e) {
			e.printStackTrace();
			finalDesignationList.clear();finalDesignationList = null;
		}
		return finalDesignationList;
	}

	@Override
	public List<M_Designation> getDesignationByActiveStatus(Integer designationActive) {
		List<M_Designation> designationList = null;
		try {
			designationList = mDesignationDao.findByDesignationActive(designationActive);
			System.out.println("designationList : "+designationList.size());
			Collections.sort(designationList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return designationList;
	}

	@Override
	@Transactional
	public String saveDesignationDetails(HttpServletRequest request, M_Designation designation) {
		StringBuilder response = new StringBuilder();
		if(!inputValidationService.stringOnlyValidation(designation.getDesignationName())) {
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
		if(designation.getmDesignationId() != null) {
			M_Designation currDesignation = mDesignationDao.findById(Long.parseLong(""+designation.getmDesignationId())).get();
			Integer proceedFlag = 0;
			List<M_Designation> designationExists = mDesignationDao.findByDesignationName(designation.getDesignationName());
			if(designationExists != null && designationExists.size() != 0) {
				for(M_Designation designationDetails : designationExists) {
					if(designation.getDesignationName().equalsIgnoreCase(designationDetails.getDesignationName()) && currDesignation.getmDesignationId().compareTo(designationDetails.getmDesignationId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			designationExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				if(designation.getDesignationName().equalsIgnoreCase(currDesignation.getDesignationName())) {
					response.append("noChange");
				} else {
					M_Designation_History designationHistory = new M_Designation_History();
					designationHistory.setmDesignationId(currDesignation);
					designationHistory.setDesignationActive(currDesignation.getDesignationActive());
					designationHistory.setDesignationName(currDesignation.getDesignationName());
					designationHistory.setmUserId(user);
					designationHistory.setCreatedOn(currDate);
					mDesignationHistoryDao.save(designationHistory);
					designationHistory = null;

					currDesignation.setDesignationName(designation.getDesignationName());
					currDesignation.setDesignationActive(designation.getDesignationActive());
					currDesignation.setmUserIdUpdate(user);
					currDesignation.setUpdatedOn(currDate);
					mDesignationDao.save(currDesignation);
					currDesignation = null;
					response.append("edit");
				}
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
		} else {
			List<M_Designation> designationExists = mDesignationDao.findByDesignationName(designation.getDesignationName());
			if(designationExists != null && designationExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				designation.setmUserId(user);
				designation.setCreatedOn(currDate);
				mDesignationDao.save(designation);
				
				response.append("add");
			}
			designationExists = null;
		}
		user = null;
		return response.toString();
	}

	@Override
	public String getDesignationDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> designationDetails = new HashMap<String, String>();
		try {
			/*M_Designation designation = mDesignationDao.getOne(Integer.parseInt(""+request.getParameter("mDesignationId")));*/
			M_Designation designation = mDesignationDao.findById(Long.parseLong(""+request.getParameter("mDesignationId"))).get();
			designationDetails.put("designationName", designation.getDesignationName());
			designationDetails.put("designationActive", ""+designation.getDesignationActive());
			Gson gson = new Gson();
			response = gson.toJson(designationDetails);
			gson = null; designation = null; designationDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}
}