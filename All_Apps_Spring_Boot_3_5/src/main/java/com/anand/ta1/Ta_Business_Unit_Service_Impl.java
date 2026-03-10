package com.anand.ta1;

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
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.common.InputValidation;
import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;
import com.google.gson.Gson;

@Service
public class Ta_Business_Unit_Service_Impl implements Ta_Business_Unit_Service {

    @Autowired private Ta_Business_Unit_Dao taBusinessUnitDao;
    @Autowired private Ta_Business_Unit_History_Dao taBusinessUnitHistoryDao;
    @Autowired private M_User_Dao mUserDao;
    @Autowired private InputValidation inputValidationService;

    @Override
    public List<Ta_Business_Unit> getBusinessUnitList(HttpServletRequest request, Integer offset) {
    	List<Ta_Business_Unit> finalList = new ArrayList<>();
    	try {
    		List<Ta_Business_Unit> list;
    		if (request.getParameter("all") != null) {
    			list = taBusinessUnitDao.findAll();
    		} else {
    			Pageable pageable = PageRequest.of(offset/25, 25, Sort.by("taBusinessUnitId").descending());
    			list = taBusinessUnitDao.findAll(pageable).toList();
    			pageable = null;
    		}
    		for (Ta_Business_Unit bu : list) {
    			bu.setActionForList(
    				"<a href='#' onclick='editBusinessUnit("+ bu.getTaBusinessUnitId()+ ");'><i class='fas fa-edit'></i></a> "+
    				"&ensp;<a href='ta-business-unit-history?taBusinessUnitId="+ bu.getTaBusinessUnitId()+"'><i class='fas fa-history'></i></a>");
    			finalList.add(bu);
    		}
    		Collections.sort(finalList);
    	} catch (Exception e) {
    		if(finalList != null) {
    			finalList.clear();
    			finalList = null;
    		}
    		e.printStackTrace();
    	}
        return finalList;
    }

    @Override
    public List<Ta_Business_Unit> getBusinessUnitByActiveStatus(Integer active) {
        List<Ta_Business_Unit> businessUnitList = null;
		try {
			businessUnitList = taBusinessUnitDao.findByTaBusinessUnitActive(active);
			Collections.sort(businessUnitList);
		} catch(Exception e) {
			e.printStackTrace();
			businessUnitList.clear(); businessUnitList = null;
		}
		return businessUnitList;
    }

    @Override
    @Transactional
    public String saveBusinessUnitDetails(HttpServletRequest request,Ta_Business_Unit bu) {
    	StringBuilder response = new StringBuilder();
    	if(!inputValidationService.onlyAlpabetCheckWithSpace(bu.getTaBusinessUnitName())) {
			System.out.println("name error");
			response.append("error");
		}
		if(!inputValidationService.alphaNumericValidationWithSpace(bu.getTaBusinessUnitDescription())) {
			System.out.println("description");
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
    	if (bu.getTaBusinessUnitId() != null) {
    		
    		Ta_Business_Unit currBusinessUnit = taBusinessUnitDao.findById(Long.parseLong(""+bu.getTaBusinessUnitId())).get();
			Integer proceedFlag = 0;
			List<Ta_Business_Unit> buExists = taBusinessUnitDao.findByTaBusinessUnitName(bu.getTaBusinessUnitName());
			if(buExists != null && buExists.size() != 0) {
				for(Ta_Business_Unit buDetails : buExists) {
					if(bu.getTaBusinessUnitName().equalsIgnoreCase(buDetails.getTaBusinessUnitName()) && currBusinessUnit.getTaBusinessUnitId().compareTo(buDetails.getTaBusinessUnitId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			buExists = null;
			if(proceedFlag.compareTo(0) == 0) {
	    		Ta_Business_Unit_History buHistory = new Ta_Business_Unit_History();
	    		buHistory.setTaBusinessUnit(currBusinessUnit);
	    		buHistory.setBusinessUnitName(currBusinessUnit.getTaBusinessUnitName());
	    		buHistory.setBusinessUnitDescription(currBusinessUnit.getTaBusinessUnitDescription());
	    		buHistory.setBusinessUnitActive(currBusinessUnit.getTaBusinessUnitActive());
	    		buHistory.setCreatedBy(currBusinessUnit.getCreatedBy());
	    		buHistory.setCreatedOn(currBusinessUnit.getCreatedOn());
	    		buHistory.setUpdatedBy(user);
	    		buHistory.setUpdatedOn(currDate);
	            taBusinessUnitHistoryDao.save(buHistory);
	            buHistory = null;
	            
	            currBusinessUnit.setTaBusinessUnitName(bu.getTaBusinessUnitName());
	            currBusinessUnit.setTaBusinessUnitDescription(bu.getTaBusinessUnitDescription());
	            currBusinessUnit.setTaBusinessUnitActive(bu.getTaBusinessUnitActive());
	            currBusinessUnit.setUpdatedBy(user);
	            currBusinessUnit.setUpdatedOn(currDate);
	            taBusinessUnitDao.save(currBusinessUnit);
	            return "edit";
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
        } else {
        	List<Ta_Business_Unit> buExists = taBusinessUnitDao.findByTaBusinessUnitName(bu.getTaBusinessUnitName());
			if(buExists != null && buExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				bu.setCreatedBy(user);
	        	bu.setCreatedOn(currDate);
	        	if (bu.getTaBusinessUnitActive() == null) {
	        		bu.setTaBusinessUnitActive(1);
	        	}
	        	taBusinessUnitDao.save(bu);
			}
			buExists = null;
        }
    	return response.toString();
    }

    @Override
    public List<Ta_Business_Unit_History> getBusinessUnitHistoryById(Long id) {
    	List<Ta_Business_Unit_History> list = taBusinessUnitHistoryDao.findByTaBusinessUnit_TaBusinessUnitId(id);
        Collections.sort(list);
        return list;
    }

    @Override
    public String getBusinessUnitDetails(HttpServletRequest request) {
        try {
        	Ta_Business_Unit bu = taBusinessUnitDao.findById(Long.parseLong(request.getParameter("taBusinessUnitId"))).get();
            Map<String, String> map = new HashMap<>();
            map.put("taBusinessUnitName", bu.getTaBusinessUnitName());
            map.put("taBusinessUnitDescription", bu.getTaBusinessUnitDescription());
            map.put("taBusinessUnitActive", String.valueOf(bu.getTaBusinessUnitActive()));
            return new Gson().toJson(map);
        } catch (Exception e) {
        	e.printStackTrace();
        	return "error";
        }
    }
}