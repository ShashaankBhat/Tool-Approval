package com.anand.ta1;

import java.util.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.anand.common.InputValidation;
import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;
import com.google.gson.Gson;

@Service
public class Ta_Approval_Matrix_Service_Impl implements Ta_Approval_Matrix_Service {

	@Autowired Ta_Approval_Matrix_Dao taApprovalMatrixDao;
	@Autowired Ta_Approval_Matrix_History_Dao taApprovalMatrixHistoryDao;
	@Autowired Ta_Business_Unit_Dao taBusinessUnitDao;
	@Autowired M_User_Dao mUserDao;
	@Autowired InputValidation inputValidationService;

	@Override
	public List<Ta_Approval_Matrix> getApprovalMatrixList(HttpServletRequest request, Integer offset) {
		List<Ta_Approval_Matrix> finalApprovalMatrixList = new ArrayList<>();
    	try {
    		List<Ta_Approval_Matrix> list;
    		if (request.getParameter("all") != null) {
    			list = taApprovalMatrixDao.findAll();
    		} else {
    			Pageable pageable = PageRequest.of(offset/25, 25, Sort.by("taApprovalMatrixId").descending());
    			list = taApprovalMatrixDao.findAll(pageable).toList();
    			pageable = null;
    		}
    		Integer activenessCheck = 1;
    		for (Ta_Approval_Matrix approvalMatrix : list) {
    			if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
    				approvalMatrix.setActionForList("<a href='#' onclick='editApprovalMatrix("+ approvalMatrix.getTaApprovalMatrixId()+ ");'><i class='fas fa-edit'></i></a> "+
    					"&ensp;<a href='ta-approval-matrix-history?taApprovalMatrixId="+ approvalMatrix.getTaApprovalMatrixId()+"'><i class='fas fa-history'></i></a>");
    			}
    			finalApprovalMatrixList.add(approvalMatrix);
    		}
    		activenessCheck = null;
    		Collections.sort(finalApprovalMatrixList);
    	} catch (Exception e) {
    		finalApprovalMatrixList.clear(); finalApprovalMatrixList = null;
    		e.printStackTrace();
    	}
        return finalApprovalMatrixList;
	}

	@Override
	public List<Ta_Approval_Matrix> getApprovalMatrixByActiveStatus(Integer active) {
		List<Ta_Approval_Matrix> approvalMatrixList = null;
		try {
			approvalMatrixList = taApprovalMatrixDao.findByMatrixActive(active);
			Collections.sort(approvalMatrixList);
		} catch(Exception e) {
			e.printStackTrace();
			approvalMatrixList.clear(); approvalMatrixList = null;
		}
		return approvalMatrixList;
	}

	@Transactional
	@Override
	public String saveApprovalMatrixDetails(HttpServletRequest request, Ta_Approval_Matrix matrix) {
		StringBuilder response = new StringBuilder();
    	if(!inputValidationService.numberOnlyValidation(""+matrix.getTempBusinessUnit())) {
			System.out.println("business unit error");
			response.append("error");
		}
    	if(!inputValidationService.numberOnlyValidation(""+matrix.getTempLevelOneId())) {
			System.out.println("level one error");
			response.append("error");
		}
    	if(!inputValidationService.alphaNumericValidationWithSpace(matrix.getLevelOnePosition())) {
			System.out.println("level one position");
			response.append("error");
		}
    	if(!inputValidationService.numberOnlyValidation(""+matrix.getTempLevelTwoId())) {
			System.out.println("level two error");
			response.append("error");
		}
    	if(!inputValidationService.alphaNumericValidationWithSpace(matrix.getLevelTwoPosition())) {
			System.out.println("level two position");
			response.append("error");
		}
    	if(!inputValidationService.numberOnlyValidation(""+matrix.getTempLevelThreeId())) {
			System.out.println("level three error");
			response.append("error");
		}
    	if(!inputValidationService.alphaNumericValidationWithSpace(matrix.getLevelThreePosition())) {
			System.out.println("level three position");
			response.append("error");
		}
    	if(!inputValidationService.numberOnlyValidation(""+matrix.getTempLevelFourId())) {
			System.out.println("level four error");
			response.append("error");
		}
    	if(!inputValidationService.alphaNumericValidationWithSpace(matrix.getLevelFourPosition())) {
			System.out.println("level four position");
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
    	if (matrix.getTaApprovalMatrixId() != null) {
    		Ta_Approval_Matrix currApprovalMatrix = taApprovalMatrixDao.findById(matrix.getTaApprovalMatrixId()).get();
			Integer proceedFlag = 0;
			List<Ta_Approval_Matrix> approvalMatrixExists = taApprovalMatrixDao.findByApprovalMatrixForBusinessUnit(taBusinessUnitDao.findById(matrix.getTempBusinessUnit()).get());
			System.out.println("approvalMatrixExists: "+approvalMatrixExists.size());
			if(approvalMatrixExists != null && approvalMatrixExists.size() != 0) {
				for(Ta_Approval_Matrix approvalMatrixDetail : approvalMatrixExists) {
					System.out.println(approvalMatrixDetail.getTaApprovalMatrixId()+"-"+currApprovalMatrix.getTaApprovalMatrixId());
					if(approvalMatrixDetail.getApprovalMatrixForBusinessUnit().getTaBusinessUnitId().compareTo(matrix.getTempBusinessUnit()) == 0 && 
							approvalMatrixDetail.getTaApprovalMatrixId().compareTo(currApprovalMatrix.getTaApprovalMatrixId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			System.out.println("proceedFlag: "+proceedFlag);
			approvalMatrixExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				Ta_Approval_Matrix_History approvalMatrixHistory = new Ta_Approval_Matrix_History();
				approvalMatrixHistory.setTaApprovalMatrixId(currApprovalMatrix);
				approvalMatrixHistory.setTaBusinessUnitId(currApprovalMatrix.getApprovalMatrixForBusinessUnit());
				approvalMatrixHistory.setLevelOne(currApprovalMatrix.getLevelOne());
				approvalMatrixHistory.setLevelTwo(currApprovalMatrix.getLevelTwo());
				approvalMatrixHistory.setLevelThree(currApprovalMatrix.getLevelThree());
				approvalMatrixHistory.setLevelFour(currApprovalMatrix.getLevelFour());
				approvalMatrixHistory.setLevelOnePosition(currApprovalMatrix.getLevelOnePosition());
				approvalMatrixHistory.setLevelTwoPosition(currApprovalMatrix.getLevelTwoPosition());
				approvalMatrixHistory.setLevelThreePosition(currApprovalMatrix.getLevelThreePosition());
				approvalMatrixHistory.setLevelFourPosition(currApprovalMatrix.getLevelFourPosition());
				approvalMatrixHistory.setCreatedBy(user);
				approvalMatrixHistory.setCreatedOn(currDate);
        		taApprovalMatrixHistoryDao.save(approvalMatrixHistory);
        		approvalMatrixHistory = null;
	            
				currApprovalMatrix.setApprovalMatrixForBusinessUnit(taBusinessUnitDao.findById(matrix.getTempBusinessUnit()).get());
				currApprovalMatrix.setLevelOne(mUserDao.findById(matrix.getTempLevelOneId()).get());
				currApprovalMatrix.setLevelTwo(mUserDao.findById(matrix.getTempLevelTwoId()).get());
				currApprovalMatrix.setLevelThree(mUserDao.findById(matrix.getTempLevelThreeId()).get());
				currApprovalMatrix.setLevelFour(mUserDao.findById(matrix.getTempLevelFourId()).get());
				currApprovalMatrix.setLevelOnePosition(matrix.getLevelOnePosition());
				currApprovalMatrix.setLevelTwoPosition(matrix.getLevelTwoPosition());
				currApprovalMatrix.setLevelThreePosition(matrix.getLevelThreePosition());
				currApprovalMatrix.setLevelFourPosition(matrix.getLevelFourPosition());
				currApprovalMatrix.setMatrixActive(matrix.getMatrixActive());
				currApprovalMatrix.setUpdatedBy(user);
				currApprovalMatrix.setUpdatedOn(currDate);
				taApprovalMatrixDao.save(currApprovalMatrix);
				response.append("edit");
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
        } else {
        	List<Ta_Approval_Matrix> approvalMatrixExists = taApprovalMatrixDao.findByApprovalMatrixForBusinessUnit(taBusinessUnitDao.findById(matrix.getTempBusinessUnit()).get());
			if(approvalMatrixExists != null && approvalMatrixExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				matrix.setApprovalMatrixForBusinessUnit(taBusinessUnitDao.findById(matrix.getTempBusinessUnit()).get());
				matrix.setLevelOne(mUserDao.findById(matrix.getTempLevelOneId()).get());
				matrix.setLevelTwo(mUserDao.findById(matrix.getTempLevelTwoId()).get());
				matrix.setLevelThree(mUserDao.findById(matrix.getTempLevelThreeId()).get());
				matrix.setLevelFour(mUserDao.findById(matrix.getTempLevelFourId()).get());
				matrix.setLevelOnePosition(matrix.getLevelOnePosition());
				matrix.setLevelTwoPosition(matrix.getLevelTwoPosition());
				matrix.setLevelThreePosition(matrix.getLevelThreePosition());
				matrix.setLevelFourPosition(matrix.getLevelFourPosition());
				matrix.setCreatedBy(user);
				matrix.setCreatedOn(currDate);
				taApprovalMatrixDao.save(matrix);
				response.append("add");
			}
			approvalMatrixExists = null;
        }
    	return response.toString();
	}

	@Override
	public String getApprovalMatrixDetails(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		Map<String, String> matrixDetails = new HashMap<String, String>();
		try {
			Ta_Approval_Matrix matrixDetail = taApprovalMatrixDao.findById(Long.parseLong(""+request.getParameter("taApprovalMatrixId"))).get();
			matrixDetails.put("businessUnit", ""+matrixDetail.getApprovalMatrixForBusinessUnit().getTaBusinessUnitId());
			matrixDetails.put("levelOne", ""+matrixDetail.getLevelOne().getmUserId());
			matrixDetails.put("levelTwo", ""+matrixDetail.getLevelTwo().getmUserId());
			matrixDetails.put("levelThree", ""+matrixDetail.getLevelThree().getmUserId());
			matrixDetails.put("levelFour", ""+matrixDetail.getLevelFour().getmUserId());
			matrixDetails.put("levelOnePosition", ""+matrixDetail.getLevelOnePosition());
			matrixDetails.put("levelTwoPosition", ""+matrixDetail.getLevelTwoPosition());
			matrixDetails.put("levelThreePosition", ""+matrixDetail.getLevelThreePosition());
			matrixDetails.put("levelFourPosition", ""+matrixDetail.getLevelFourPosition());
			matrixDetails.put("matrixActive", ""+matrixDetail.getMatrixActive());
			Gson gson = new Gson();
			response.append(gson.toJson(matrixDetails));
			gson = null; matrixDetail = null; matrixDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		return response.toString();
	}

	@Override
    public List<Ta_Approval_Matrix_History> getApprovalMatrixHistoryByTaApprovalMatrixId(Long taApprovalMatrixId) {
        List<Ta_Approval_Matrix_History> list = taApprovalMatrixHistoryDao.findByTaApprovalMatrixId(taApprovalMatrixDao.findById(Long.parseLong(""+taApprovalMatrixId)).get());
        list.sort((a,b) ->b.getTaApprovalMatrixHistoryId().compareTo(a.getTaApprovalMatrixHistoryId()));
        return list;
    }
}