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
import org.springframework.web.multipart.MultipartFile;

import com.anand.common.InputValidation;
import com.anand.masters.M_Entity_Dao;
import com.anand.masters.M_Entity_History_Dao;
import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;
import com.google.gson.Gson;

@Service
public class Ta_Tool_Request_1_Service_Impl implements Ta_Tool_Request_1_Service {

	@Autowired Ta_Tool_Request_Dao_1 taToolRequestDao;
	@Autowired Ta_Tool_Request_Cost_Detail_Dao taToolRequestCostDetailDao;
	@Autowired Ta_Business_Unit_Dao taBusinessUnitDao;
	@Autowired InputValidation inputValidationService;
	@Autowired M_User_Dao mUserDao;
	@Autowired M_Entity_Dao mEntityDao;
	@Autowired Ta_Attachments_Service taAttachmentsService;

    @Override
    @Transactional
    public String saveTaToolRequestDetails(HttpServletRequest request, Ta_Tool_Request_1 taToolRequest) {
    	StringBuilder response = new StringBuilder();
    	if(!inputValidationService.alphaNumericValidationWithSpace(taToolRequest.getCustomerName())) {
			System.out.println("getCustomerName error");
			response.append("error");
		}
		if(!inputValidationService.alphaNumericValidationWithSpace(taToolRequest.getProjectName())) {
			System.out.println("getProjectName error");
			response.append("error");
		}
		if(!inputValidationService.numberOnlyValidation(""+taToolRequest.getTempEntityId())) {
			System.out.println("getTempEntityId error"+taToolRequest.getTempEntityId());
			response.append("error");
		}
		if(!inputValidationService.decimalNumberCheck(""+taToolRequest.getPeakAnnualVolume())) {
			System.out.println("getPeakAnnualVolume error");
			response.append("error");
		}
		if(!inputValidationService.numberOnlyValidation(""+taToolRequest.getUnit())) {
			System.out.println("getUnit error"+taToolRequest.getUnit());
			response.append("error");
		}
		if(!inputValidationService.numberOnlyValidation(""+taToolRequest.getExpenseType())) {
			System.out.println("getExpenseType error");
			response.append("error");
		}
		if(!inputValidationService.numberOnlyValidation(""+taToolRequest.getTempBusinessUnitId())) {
			System.out.println("getTempBusinessUnitId error");
			response.append("error");
		}
		if(!inputValidationService.numberOnlyValidation(""+taToolRequest.getTempCommodityManagerId())) {
			System.out.println("getTempCommodityManagerId error");
			response.append("error");
		}
		if(!inputValidationService.textareaValidation(taToolRequest.getBackground())) {
			System.out.println("getBackground error");
			response.append("error");
		}
		if(!inputValidationService.textareaValidation(taToolRequest.getRemark())) {
			System.out.println("getRemark error");
			response.append("error");
		}
		for(Ta_Tool_Request_Cost_Detail costDetail: taToolRequest.getTempToolRequestCostDetail()) {
			if(costDetail.getCostActive().compareTo(1) == 0) {
				if(!inputValidationService.alphaNumericValidationWithSpace(costDetail.getToolPartNumber())) {
					System.out.println("getToolPartNumber error");
					response.append("error");
				}
				if(!inputValidationService.alphaNumericValidationWithSpace(costDetail.getPartDescription())) {
					System.out.println("getPartDescription error");
					response.append("error");
				}
				if(!inputValidationService.numberOnlyValidation(""+costDetail.getCurrency())) {
					System.out.println("getCurrency error");
					response.append("error");
				}
				if(!inputValidationService.decimalNumberCheck(""+costDetail.getQuotedCost())) {
					System.out.println("getQuotedCost error");
					response.append("error");
				}
				if(!inputValidationService.decimalNumberCheck(""+costDetail.getNegotiatedCost())) {
					System.out.println("getNegotiatedCost error");
					response.append("error");
				}
				if(!inputValidationService.decimalNumberCheck(""+costDetail.getUpfrontCost())) {
					System.out.println("getUpfrontCost error");
					response.append("error");
				}
				if(!inputValidationService.decimalNumberCheck(""+costDetail.getAmortizationCost())) {
					System.out.println("getAmortizationCost error");
					response.append("error");
				}
				if(!inputValidationService.textareaValidation(costDetail.getSupplierName())) {
					System.out.println("getSupplierName error");
					response.append("error");
				}
				if(!inputValidationService.numberOnlyValidation(""+costDetail.getDevelopmentLeadTime())) {
					System.out.println("getDevelopmentLeadTime error");
					response.append("error");
				}
				if(!inputValidationService.textareaValidation(costDetail.getRemarks())) {
					System.out.println("getRemarks cost detail error");
					response.append("error");
				}
			}
		}
		if(response.toString().contains("error")) {
			response.setLength(0);
			response.append("error");
			return response.toString();
		}
		response.setLength(0);
        M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
        Date currDate = new Date();
        System.out.println(taToolRequest.getTaToolRequestId()+"----------");
        if (taToolRequest.getTaToolRequestId() != null) {
        	Ta_Tool_Request_1 currTaToolRequest = taToolRequestDao.findById(taToolRequest.getTaToolRequestId()).get();
        	currTaToolRequest.setCustomerName(taToolRequest.getCustomerName());
        	currTaToolRequest.setProjectName(taToolRequest.getProjectName());
        	currTaToolRequest.setEntityId(mEntityDao.findById(taToolRequest.getTempEntityId()).get());
        	currTaToolRequest.setPeakAnnualVolume(taToolRequest.getPeakAnnualVolume());
        	currTaToolRequest.setUnit(taToolRequest.getUnit());
        	currTaToolRequest.setExpenseType(taToolRequest.getExpenseType());
        	currTaToolRequest.setCommodityManagerUserId(mUserDao.findById(taToolRequest.getTempCommodityManagerId()).get());
        	currTaToolRequest.setBackground(taToolRequest.getBackground());
        	currTaToolRequest.setRemark(taToolRequest.getRemark());
        	currTaToolRequest.setUpdatedBy(user);
        	currTaToolRequest.setUpdatedOn(currDate);
        	currTaToolRequest.setRequestActive(1);
        	taToolRequestDao.save(currTaToolRequest);
        	for(Ta_Tool_Request_Cost_Detail costDetail: taToolRequest.getTempToolRequestCostDetail()) {
    			if(costDetail.getCostActive().compareTo(1) == 0) {
    				if(costDetail.getTaToolRequestCostDetailId() != null) {
    					Ta_Tool_Request_Cost_Detail currCostDetail = taToolRequestCostDetailDao.findById(costDetail.getTaToolRequestCostDetailId()).get();
    					currCostDetail.setUpdatedBy(user);
    					currCostDetail.setUpdatedOn(currDate);
    					taToolRequestCostDetailDao.save(currCostDetail);
    					currCostDetail = null;
    				} else {
    					costDetail.setToolReqeustCostDetail(currTaToolRequest);
    					costDetail.setToolReqeustCostDetail(taToolRequest);
        				costDetail.setCreatedBy(user);
        				costDetail.setCreatedOn(currDate);
        				costDetail.setCostActive(0);
        				taToolRequestCostDetailDao.save(costDetail);
    				}
    			} else {
    				if(costDetail.getTaToolRequestCostDetailId() != null) {
    					Ta_Tool_Request_Cost_Detail currCostDetail = taToolRequestCostDetailDao.findById(costDetail.getTaToolRequestCostDetailId()).get();
    					currCostDetail.setCostActive(0);
    					currCostDetail.setUpdatedBy(user);
    					currCostDetail.setUpdatedOn(currDate);
    					taToolRequestCostDetailDao.save(currCostDetail);
    					currCostDetail = null;
    				}
    			}
        	}
        	response.append("edit");
        } else {
        	taToolRequest.setCustomerName(taToolRequest.getCustomerName());
        	taToolRequest.setProjectName(taToolRequest.getProjectName());
        	taToolRequest.setEntityId(mEntityDao.findById(taToolRequest.getTempEntityId()).get());
        	taToolRequest.setTaBusinessUnitId(taBusinessUnitDao.findById(taToolRequest.getTempBusinessUnitId()).get());
        	taToolRequest.setRequestNumber("TA-"+mEntityDao.findById(taToolRequest.getTempEntityId()).get().getEntityAcronym()+"-"+taBusinessUnitDao.findById(taToolRequest.getTempBusinessUnitId()).get().getTaBusinessUnitName());
        	taToolRequest.setPeakAnnualVolume(taToolRequest.getPeakAnnualVolume());
        	taToolRequest.setUnit(taToolRequest.getUnit());
        	taToolRequest.setExpenseType(taToolRequest.getExpenseType());
        	taToolRequest.setCommodityManagerUserId(mUserDao.findById(taToolRequest.getTempCommodityManagerId()).get());
        	taToolRequest.setBackground(taToolRequest.getBackground());
        	taToolRequest.setRemark(taToolRequest.getRemark());
        	taToolRequest.setCreatedBy(user);
        	taToolRequest.setCreatedOn(currDate);
        	taToolRequest.setRequestActive(1);
        	taToolRequest.setSopDate(currDate);
        	taToolRequestDao.save(taToolRequest);
        	taToolRequest = taToolRequestDao.findById(taToolRequest.getTaToolRequestId()).get();
        	taToolRequest.setRequestNumber("TA-"+mEntityDao.findById(taToolRequest.getTempEntityId()).get().getEntityAcronym()+"-"+taBusinessUnitDao.findById(taToolRequest.getTempBusinessUnitId()).get().getTaBusinessUnitName()+"-"+taToolRequest.getTaToolRequestId());
        	for(Ta_Tool_Request_Cost_Detail costDetail: taToolRequest.getTempToolRequestCostDetail()) {
    			if(costDetail.getCostActive().compareTo(1) == 0) {
    				costDetail.setToolReqeustCostDetail(taToolRequest);
    				costDetail.setCreatedBy(user);
    				costDetail.setCreatedOn(currDate);
    				taToolRequestCostDetailDao.save(costDetail);
    			}
        	}
        	response.append("add");
        }
    	return response.toString();
    }

	@Override
	@Transactional
	public void saveTaToolRequestDetails(
			Ta_Tool_Request_1 taToolRequest,
			MultipartFile[] backgroundAttachments,
			MultipartFile[] remarkAttachments){

		Ta_Tool_Request_1 savedRequest = taToolRequestDao.save(taToolRequest);

		if(backgroundAttachments != null && backgroundAttachments.length > 0){

			taAttachmentsService.saveAttachments(
					savedRequest,
					backgroundAttachments,
					Ta_Attachments.SECTION_BACKGROUND
			);

		}

		if(remarkAttachments != null && remarkAttachments.length > 0){

			taAttachmentsService.saveAttachments(
					savedRequest,
					remarkAttachments,
					Ta_Attachments.SECTION_REMARK
			);

		}

	}

	@Override
	public Ta_Tool_Request_1 getTaToolRequestDetail(HttpServletRequest request) {
		if(request.getParameter("taToolRequestId") != null) {
			Ta_Tool_Request_1 taToolRequest = taToolRequestDao.findById(Long.parseLong(""+request.getParameter("taToolRequestId"))).get();
			return taToolRequest;
		} else {
			return null;
		}
	}
}
