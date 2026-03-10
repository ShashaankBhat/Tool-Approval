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
public class Ta_Status_Service_Impl implements Ta_Status_Service {

    @Autowired private Ta_Status_Dao statusDao;
    @Autowired private Ta_Status_History_Dao statusHistoryDao;
    @Autowired private M_User_Dao mUserDao;
    @Autowired private InputValidation inputValidationService;

    @Override
    public List<Ta_Status> getStatusList(HttpServletRequest request, Integer offset) {
        List<Ta_Status> finalStatusList = new ArrayList<Ta_Status>();
		try {
			List<Ta_Status> statusList = null;
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				statusList = statusDao.findAll();
			} else {
				Pageable pageable = PageRequest.of(offset/25, 25, Sort.by("taStatusId").descending());
				statusList = statusDao.findAll(pageable).toList();
				pageable = null;
			}
			for(Ta_Status status : statusList) {
				status.setActionForList("");
				if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
					|| (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
					status.setActionForList("<a href='#' title='Edit Status' onclick='editStatus("+status.getTaStatusId()+");'><i class='fas fa-edit'></i></a>"
							+"&ensp;<a href='ta-status-history?taStatusId="+ status.getTaStatusId()+ "' title='View History'><i class='fas fa-history'></i></a>");
				}
				finalStatusList.add(status);
			}
			Collections.sort(finalStatusList);
		} catch(Exception e) {
			e.printStackTrace();
			finalStatusList.clear(); finalStatusList = null;
		}
		return finalStatusList;
    }

    @Override
    public List<Ta_Status> getStatusByActiveStatus(Integer active) {
        List<Ta_Status> statusList = null;
		try {
			statusList = statusDao.findByTaStatusActive(active);
			Collections.sort(statusList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return statusList;
    }

    @Override
    @Transactional
    public String saveStatusDetails(HttpServletRequest request, Ta_Status status) {
    	StringBuilder response = new StringBuilder();
    	if(!inputValidationService.onlyAlpabetCheckWithSpace(status.getTaStatusName())) {
			System.out.println("name error");
			response.append("error");
		}
		if(!inputValidationService.alphaNumericValidationWithSpace(status.getTaStatusDescription())) {
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
        if (status.getTaStatusId() != null) {
        	Ta_Status currStatus = statusDao.findById(status.getTaStatusId()).get();
			Integer proceedFlag = 0;
			List<Ta_Status> statusExists = statusDao.findByTaStatusName(status.getTaStatusName());
			if(statusExists != null && statusExists.size() != 0) {
				for(Ta_Status statusDetail : statusExists) {
					if(status.getTaStatusName().equalsIgnoreCase(statusDetail.getTaStatusName()) && currStatus.getTaStatusId().compareTo(statusDetail.getTaStatusId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			statusExists.clear(); statusExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				 Ta_Status_History history = new Ta_Status_History();
				 history.setTaStatus(currStatus);
				 history.setTaStatusName(currStatus.getTaStatusName());
				 history.setTaStatusDescription(currStatus.getTaStatusDescription());
				 history.setTaStatusActive(currStatus.getTaStatusActive());
				 if(currStatus.getUpdatedBy() != null) {
					 history.setCreatedBy(currStatus.getUpdatedBy());
					 history.setCreatedOn(currStatus.getUpdatedOn());
				 } else {
					 history.setCreatedBy(user);
					 history.setCreatedOn(currDate);
				 }
				 statusHistoryDao.save(history);
				 history = null;
	            
				 currStatus.setTaStatusName(status.getTaStatusName());
				 currStatus.setTaStatusDescription(status.getTaStatusDescription());
				 currStatus.setTaStatusActive(status.getTaStatusActive());
				 currStatus.setUpdatedBy(user);
				 currStatus.setUpdatedOn(currDate);
				 statusDao.save(currStatus);
				 response.append("edit"); 
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
        } else {
        	List<Ta_Status> statusExists = statusDao.findByTaStatusName(status.getTaStatusName());
			if(statusExists != null && statusExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				status.setCreatedBy(user);
				status.setCreatedOn(currDate);
				status.setTaStatusActive(status.getTaStatusActive());
				statusDao.save(status);
			}
			statusExists = null;
        }
    	return response.toString();
    }

    @Override
    public String getStatusDetails(HttpServletRequest request) {
    	String response = "";
		Map<String, String> statusDetails = new HashMap<String, String>();
		try {
			Ta_Status status = statusDao.findById(Long.parseLong(request.getParameter("taStatusId"))).get();
			statusDetails.put("taStatusName", status.getTaStatusName());
			statusDetails.put("taStatusDescription", status.getTaStatusDescription());
			statusDetails.put("taStatusActive", ""+status.getTaStatusActive());
			Gson gson = new Gson();
			response = gson.toJson(statusDetails);
			gson = null; status = null; statusDetails.clear(); statusDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			statusDetails.clear(); statusDetails = null;
			response = "error";
		}
		return response;
    }

    @Override
    public List<Ta_Status_History> getStatusHistoryByStatusId(Long taStatusId) {
        List<Ta_Status_History> list =statusHistoryDao.findByTaStatus_TaStatusId(taStatusId);
        list.sort((a,b) ->b.getTaStatusHistoryId().compareTo(a.getTaStatusHistoryId()));
        return list;
    }
}
