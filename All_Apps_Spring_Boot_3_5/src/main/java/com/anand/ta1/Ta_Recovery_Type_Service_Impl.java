package com.anand.ta1;

import java.util.*;

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
public class Ta_Recovery_Type_Service_Impl implements Ta_Recovery_Type_Service {

    @Autowired private Ta_Recovery_Type_Dao taRecoveryTypeDao;
    @Autowired private Ta_Recovery_Type_History_Dao taRecoveryTypeHistoryDao;
    @Autowired private M_User_Dao mUserDao;
    @Autowired private InputValidation inputValidationService;

    @Override
    public List<Ta_Recovery_Type> getRecoveryTypeList(HttpServletRequest request, Integer offset) {
    	List<Ta_Recovery_Type> finalList = new ArrayList<>();
    	try {
    		List<Ta_Recovery_Type> list;
    		if (request.getParameter("all") != null) {
    			list = taRecoveryTypeDao.findAll();
    		} else {
    			Pageable pageable = PageRequest.of(offset/25, 25, Sort.by("taRecoveryTypeId").descending());
    			list = taRecoveryTypeDao.findAll(pageable).toList();
    			pageable = null;
    		}
    		for (Ta_Recovery_Type rt : list) {
    			rt.setActionForList("<a href='#' onclick='editRecoveryType("+ rt.getTaRecoveryTypeId()+ ");'><i class='fas fa-edit'></i></a> "
    				+"&ensp;<a href='ta-recovery-type-history?taRecoveryTypeId="+ rt.getTaRecoveryTypeId()+ "'><i class='fas fa-history'></i></a>");
    			finalList.add(rt);
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
    public List<Ta_Recovery_Type> getRecoveryTypeByActiveStatus(Integer active) {
        List<Ta_Recovery_Type> recoveryTypeList = null;
		try {
			recoveryTypeList = taRecoveryTypeDao.findByTaRecoveryTypeActive(active);
			Collections.sort(recoveryTypeList);
		} catch(Exception e) {
			e.printStackTrace();
			recoveryTypeList.clear(); recoveryTypeList = null;
		}
		return recoveryTypeList;
    }

    @Override
    @Transactional
    public String saveRecoveryTypeDetails(HttpServletRequest request, Ta_Recovery_Type recoveryType) {
    	StringBuilder response = new StringBuilder();
    	if(!inputValidationService.onlyAlpabetCheckWithSpace(recoveryType.getTaRecoveryTypeName())) {
			System.out.println("name");
			response.append("error");
		}
		if(!inputValidationService.alphaNumericValidationWithSpace(recoveryType.getTaRecoveryTypeDescription())) {
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
    	if (recoveryType.getTaRecoveryTypeId() != null) {
    		Ta_Recovery_Type currRecoveryType = taRecoveryTypeDao.findById(Long.parseLong(""+recoveryType.getTaRecoveryTypeId())).get();
			Integer proceedFlag = 0;
			List<Ta_Recovery_Type> recoveryTypeExists = taRecoveryTypeDao.findByTaRecoveryTypeName(recoveryType.getTaRecoveryTypeName());
			if(recoveryTypeExists != null && recoveryTypeExists.size() != 0) {
				for(Ta_Recovery_Type recoveryTypeDetails : recoveryTypeExists) {
					if(recoveryType.getTaRecoveryTypeName().equalsIgnoreCase(recoveryTypeDetails.getTaRecoveryTypeName()) && currRecoveryType.getTaRecoveryTypeId().compareTo(recoveryTypeDetails.getTaRecoveryTypeId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			recoveryTypeExists = null;
			if(proceedFlag.compareTo(0) == 0) {
	    		Ta_Recovery_Type_History recoveryTypeHistory = new Ta_Recovery_Type_History();
	    		recoveryTypeHistory.setTaRecoveryType(currRecoveryType);
	    		recoveryTypeHistory.setTaRecoveryTypeName(currRecoveryType.getTaRecoveryTypeName());
	    		recoveryTypeHistory.setTaRecoveryTypeDescription(currRecoveryType.getTaRecoveryTypeDescription());
	    		recoveryTypeHistory.setTaRecoveryTypeActive(currRecoveryType.getTaRecoveryTypeActive());
	    		if(currRecoveryType.getUpdatedBy() != null) {
	    			recoveryTypeHistory.setCreatedBy(currRecoveryType.getUpdatedBy());
		    		recoveryTypeHistory.setCreatedOn(currRecoveryType.getUpdatedOn());
	    		} else {
	    			recoveryTypeHistory.setCreatedBy(user);
		    		recoveryTypeHistory.setCreatedOn(currDate);
	    		}
	            taRecoveryTypeHistoryDao.save(recoveryTypeHistory);
	            recoveryTypeHistory = null;
	            
	            currRecoveryType.setTaRecoveryTypeName(recoveryType.getTaRecoveryTypeName());
	            currRecoveryType.setTaRecoveryTypeDescription(recoveryType.getTaRecoveryTypeDescription());
	            currRecoveryType.setTaRecoveryTypeActive(recoveryType.getTaRecoveryTypeActive());
	            currRecoveryType.setUpdatedBy(user);
	            currRecoveryType.setUpdatedOn(currDate);
	            taRecoveryTypeDao.save(currRecoveryType);
	            response.append("edit");
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
        } else {
        	List<Ta_Recovery_Type> recoveryTypeExists = taRecoveryTypeDao.findByTaRecoveryTypeName(recoveryType.getTaRecoveryTypeName());
			if(recoveryTypeExists != null && recoveryTypeExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				recoveryType.setCreatedBy(user);
	        	recoveryType.setCreatedOn(currDate);
	        	recoveryType.setTaRecoveryTypeActive(1);
	        	taRecoveryTypeDao.save(recoveryType);
	        	
	        	for(int i=0; i<50; i++) {
	        		Ta_Recovery_Type newone = new Ta_Recovery_Type();
	        		newone.setCreatedBy(user);
	        		newone.setCreatedOn(currDate);
	        		newone.setTaRecoveryTypeActive(1);
	        		newone.setTaRecoveryTypeName(recoveryType.getTaRecoveryTypeName()+" "+i);
	        		newone.setTaRecoveryTypeDescription(recoveryType.getTaRecoveryTypeDescription());
	        		taRecoveryTypeDao.save(newone);
	        		newone = null;
	        	}
	        	response.append("add");
			}
			recoveryTypeExists = null;
        }
    	return response.toString();
    }

    @Override
    public String getRecoveryTypeDetails(HttpServletRequest request) {
        Map<String, String> map = new HashMap<>();
        Ta_Recovery_Type rt = taRecoveryTypeDao.findById(
                        Long.parseLong(request.getParameter("taRecoveryTypeId"))).get();
        map.put("taRecoveryTypeName", rt.getTaRecoveryTypeName());
        map.put("taRecoveryTypeDescription", rt.getTaRecoveryTypeDescription());
        map.put("taRecoveryTypeActive", String.valueOf(rt.getTaRecoveryTypeActive()));
        return new Gson().toJson(map);
    }

    @Override
    public List<Ta_Recovery_Type_History> getRecoveryTypeHistoryById(Long id) {
    	List<Ta_Recovery_Type_History> list = taRecoveryTypeHistoryDao.findByTaRecoveryType_TaRecoveryTypeId(id);
    	Collections.sort(list);
    	return list;
    }
}