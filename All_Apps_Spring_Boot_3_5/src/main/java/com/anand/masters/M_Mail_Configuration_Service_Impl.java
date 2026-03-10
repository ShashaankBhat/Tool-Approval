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

import com.anand.common.EncryptionDecryptionFunction;
import com.anand.common.InputValidation;
import com.google.gson.Gson;

@Service
public class M_Mail_Configuration_Service_Impl implements M_Mail_Configuration_Service {

	@Autowired private M_Mail_Configuration_Dao mMailConfigurationDao;
	@Autowired private M_Mail_Configuration_History_Dao mMailConfigurationHistoryDao;
	@Autowired private M_User_Dao mUserDao;
	@Autowired private InputValidation inputValidationService;

	@Override
	public List<M_Mail_Configuration> getMailConfigurationList(HttpServletRequest request, Integer offset) {
		List<M_Mail_Configuration> mailConfigurationListFinal = new ArrayList<M_Mail_Configuration>();
		try {
			List<M_Mail_Configuration> mailConfigurationList = new ArrayList<M_Mail_Configuration>();
			Integer activenessCheck = 1;
			if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
				mailConfigurationList.addAll(mMailConfigurationDao.findAll());
			} else {
				Pageable pageable = PageRequest.of(offset/20, 20);
				mailConfigurationList.addAll(mMailConfigurationDao.findAll(pageable).toList());
				pageable = null;
			}
			for(M_Mail_Configuration mailConfiguration : mailConfigurationList) {
				if(request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) {
					mailConfiguration.setActionForList("<a href='#' title='Edit Mail Configuration' onclick='editMailConfiguration("+mailConfiguration.getmMailConfigurationId()+");'><i class='fas fa-edit'></i></a>");
					mailConfiguration.setMailId(EncryptionDecryptionFunction.getDecryptedData(mailConfiguration.getMailId()));
					mailConfiguration.setMailAppPassword(EncryptionDecryptionFunction.getDecryptedData(mailConfiguration.getMailAppPassword()));
				}
				mailConfigurationListFinal.add(mailConfiguration);
			}
			activenessCheck = null;
			mailConfigurationList.clear(); mailConfigurationList = null;
			Collections.sort(mailConfigurationListFinal);
		} catch(Exception e) {
			e.printStackTrace();
			mailConfigurationListFinal.clear();
			mailConfigurationListFinal = null;
		}
		return mailConfigurationListFinal;
	}

	@Override
	public List<M_Mail_Configuration> getMailConfigurationByActiveStatus(Integer mailConfigurationActive) {
		List<M_Mail_Configuration> mailConfigurationList = null;
		try {
			mailConfigurationList = mMailConfigurationDao.findByActive(mailConfigurationActive);
			Collections.sort(mailConfigurationList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mailConfigurationList;
	}

	@Override
	@Transactional
	public String saveMailConfigurationDetails(HttpServletRequest request, M_Mail_Configuration mailConfiguration) throws Exception {
		StringBuilder response = new StringBuilder();
		if(!inputValidationService.emailIdValidation(mailConfiguration.getMailId())) {
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
		if(mailConfiguration.getmMailConfigurationId() != null) {
			M_Mail_Configuration currMailConfiguration = mMailConfigurationDao.findById(Long.parseLong(""+mailConfiguration.getmMailConfigurationId())).get();
			Integer proceedFlag = 0;
			List<M_Mail_Configuration> mailConfigurationExists = mMailConfigurationDao.findByMailId(EncryptionDecryptionFunction.getEncryptedData(mailConfiguration.getMailId()));
			if(mailConfigurationExists != null && mailConfigurationExists.size() != 0) {
				for(M_Mail_Configuration mailConfigurationDetails : mailConfigurationExists) {
					if(mailConfiguration.getMailId().equalsIgnoreCase(EncryptionDecryptionFunction.getDecryptedData(mailConfigurationDetails.getMailId())) 
							&& currMailConfiguration.getmMailConfigurationId().compareTo(mailConfigurationDetails.getmMailConfigurationId()) != 0) {
						proceedFlag = 1;
					}
				}
			}
			mailConfigurationExists = null;
			if(proceedFlag.compareTo(0) == 0) {
				M_Mail_Configuration_History mailConfigurationHistory = new M_Mail_Configuration_History();
				mailConfigurationHistory.setmMailConfigurationId(currMailConfiguration);
				mailConfigurationHistory.setActive(currMailConfiguration.getActive());
				mailConfigurationHistory.setMailId(EncryptionDecryptionFunction.getEncryptedData(currMailConfiguration.getMailId()));
				mailConfigurationHistory.setMailAppPassword(EncryptionDecryptionFunction.getEncryptedData(currMailConfiguration.getMailAppPassword()));
				mailConfigurationHistory.setmUserId(user);
				mailConfigurationHistory.setCreatedOn(currDate);
				mMailConfigurationHistoryDao.save(mailConfigurationHistory);
				mailConfigurationHistory = null;

				currMailConfiguration.setMailId(EncryptionDecryptionFunction.getEncryptedData(mailConfiguration.getMailId()));
				currMailConfiguration.setMailAppPassword(EncryptionDecryptionFunction.getEncryptedData(mailConfiguration.getMailAppPassword()));
				currMailConfiguration.setActive(mailConfiguration.getActive());
				currMailConfiguration.setmUserIdUpdate(user);
				currMailConfiguration.setUpdatedOn(currDate);
				mMailConfigurationDao.save(currMailConfiguration);
				currMailConfiguration = null;
				response.append("edit");
			} else {
				response.append("nameExists");
			}
			proceedFlag = null;
		} else {
			List<M_Mail_Configuration> mailConfigurationExists = mMailConfigurationDao.findByMailId(EncryptionDecryptionFunction.getEncryptedData(mailConfiguration.getMailId()));
			if(mailConfigurationExists != null && mailConfigurationExists.size() != 0) {
				System.out.println("name exists");
				response.append("nameExists");
			} else {
				mailConfiguration.setmUserId(user);
				mailConfiguration.setCreatedOn(currDate);
				mailConfiguration.setMailId(EncryptionDecryptionFunction.getEncryptedData(mailConfiguration.getMailId()));
				mailConfiguration.setMailAppPassword(EncryptionDecryptionFunction.getEncryptedData(mailConfiguration.getMailAppPassword()));
				mMailConfigurationDao.save(mailConfiguration);
				response.append("add");
			}
			mailConfigurationExists = null;
		}
		user = null;
		return response.toString();
	}

	@Override
	public String getMailConfigurationDetails(HttpServletRequest request) {
		String response = "";
		Map<String, String> mailConfigurationDetails = new HashMap<String, String>();
		try {
			/*M_Mail_Configuration mailConfiguration = mMailConfigurationDao.getOne(Integer.parseInt(""+request.getParameter("mMailConfigurationId")));*/
			M_Mail_Configuration mailConfiguration = mMailConfigurationDao.findById(Long.parseLong(""+request.getParameter("mMailConfigurationId"))).get();
			mailConfigurationDetails.put("mailId", EncryptionDecryptionFunction.getDecryptedData(mailConfiguration.getMailId()));
			mailConfigurationDetails.put("mailAppPassword", EncryptionDecryptionFunction.getDecryptedData(mailConfiguration.getMailAppPassword()));
			mailConfigurationDetails.put("active", ""+mailConfiguration.getActive());
			Gson gson = new Gson();
			response = gson.toJson(mailConfigurationDetails);
			gson = null; mailConfiguration = null; mailConfigurationDetails = null;
		} catch(Exception e) {
			e.printStackTrace();
			response = "error";
		}
		return response;
	}
}