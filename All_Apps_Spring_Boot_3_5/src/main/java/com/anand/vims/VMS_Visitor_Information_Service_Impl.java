package com.anand.vims;

import com.anand.common.Common_Constants;
import com.anand.common.InputValidation;
import com.anand.common.MailService;
import com.anand.masters.*;
import com.google.gson.Gson;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;


@Service
public class VMS_Visitor_Information_Service_Impl implements VMS_Visitor_Information_Service{

	@Autowired private VMS_Visitor_Information_Dao mvisitorInfoDao;
	@Autowired private VMS_Visitor_Dao mVisitorDao;
	@Autowired private VMS_M_Visitor_Govt_Type_Dao mVisitorGovtTypeDao;
    @Autowired private M_User_Dao mUserDao;
    @Autowired private M_User_Entity_Map_Dao mUserEntityMapDao;
    @Autowired private InputValidation inputVaildationService;
    @Autowired private MailService mailService;

    @Override
    public List<VMS_Visitor_Information> getVisitorInfoList(HttpServletRequest request, Integer offset) {
        List<VMS_Visitor_Information> finalvisitorList = new ArrayList<>(0);
        try {
            List<VMS_Visitor_Information> visitorList = null;
            Integer activenessCheck = 1;
            if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
                visitorList = mvisitorInfoDao.findAll();
            } else {
                visitorList = mvisitorInfoDao.getVisitorInfoByOffset(offset);
            }
            for(VMS_Visitor_Information visitor : visitorList) {
                visitor.setActionForList("");
                if((request.getSession(true).getAttribute("admin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("admin"))) == 0)
                        || (request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)) {
                    /*visitor.setActionForList("<a href='#' title='Edit visitor' onclick='editVisitor(" + visitor.getVisitorId() + ");'><i class='fas fa-edit'></i></a>");*/
                    visitor.setActionForList("<a href='visitor-information?id="+visitor.getVisitorInformationId()+"' title='Edit visitor Info'><i class='fas fa-edit'></i></a>");
                }
                finalvisitorList.add(visitor);
            }
            Collections.sort(finalvisitorList);
        } catch(Exception e) {
            e.printStackTrace();
            finalvisitorList.clear(); finalvisitorList = null;
        }
        return finalvisitorList;
    }

    @Override
    public List<VMS_Visitor_Information> getVisitorYetToPunchOut(HttpServletRequest request) {
        List<VMS_Visitor_Information> finalvisitorList = new ArrayList<>(0);
        try {
            finalvisitorList = mvisitorInfoDao.findByOutTimeIsNull();
            Collections.sort(finalvisitorList);
        } catch(Exception e) {
            e.printStackTrace();
            finalvisitorList.clear(); finalvisitorList = null;
        }
        return finalvisitorList;
    }

    @Override
    public List<VMS_Visitor_Information> getVisitorInfoByActiveStatus(Integer visitorActive) {
        List<VMS_Visitor_Information> visitorList = null;
        try {
            visitorList = mvisitorInfoDao.findByVisitorActive(visitorActive);
            Collections.sort(visitorList);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return visitorList;
    }

    @Override
    @Transactional
    public String saveVisitorInfoDetails(HttpServletRequest request, VMS_Visitor_Information visitorInformation) {
        StringBuilder response = new StringBuilder();
        if(!inputVaildationService.stringOnlyValidation(visitorInformation.getVisitorName())) {
            System.out.println("name");
            response.append("error");
        }
        if(!inputVaildationService.emailIdValidation(visitorInformation.getVisitorEmail())) {
            System.out.println("email error");
            response.append("error");
        }
        if(visitorInformation.getVisitorGovtIdTemp().compareTo(-1l) !=0 && !inputVaildationService.numberOnlyValidation(String.valueOf(visitorInformation.getVisitorGovtIdTemp()))) {
            System.out.println("Id Type name");
            response.append("error");
        }
        if(!visitorInformation.getVisitorGovtIdNumber().isEmpty() && !inputVaildationService.alphaNumericValidationWithSpace(visitorInformation.getVisitorGovtIdNumber())) {
            System.out.println("Govt ID Reference");
            response.append("error");
        }
        if(!visitorInformation.getVisitorBatch().isEmpty() && !inputVaildationService.alphaNumericValidationWithoutSpace(visitorInformation.getVisitorBatch())) {
            System.out.println("Batch Number");
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
        if(visitorInformation.getVisitorInformationId() != null) {
            VMS_Visitor_Information currvisitorinfo = mvisitorInfoDao.findById(Long.parseLong(""+visitorInformation.getVisitorInformationId())).get();
            currvisitorinfo.setVisitorInformationDetail(visitorInformation.getVisitorInformationDetail());
            currvisitorinfo.setVisitorInformationId(visitorInformation.getVisitorInformationId());
            currvisitorinfo.setVisitorName(visitorInformation.getVisitorName());
            currvisitorinfo.setVisitorGovtId(visitorInformation.getVisitorGovtId());
            currvisitorinfo.setVisitorBatch(visitorInformation.getVisitorBatch());
            currvisitorinfo.setVisitorImage(String.valueOf(visitorInformation.getVisitorImage()));
            currvisitorinfo.setCreatedBy(visitorInformation.getCreatedBy());
            currvisitorinfo.setCreatedOn(visitorInformation.getCreatedOn());
            mvisitorInfoDao.save(currvisitorinfo);
            currvisitorinfo = null;
            response.append("edit");
        } else {
            List<VMS_Visitor_Information> visitorExists = mvisitorInfoDao.findByVisitorActive(visitorInformation.getVisitorActive());
            if(visitorExists != null && visitorExists.size() != 0) {
                System.out.println("name exists");
                response.append("nameExists");
            } else {
                visitorInformation.setCreatedBy(user);
                visitorInformation.setCreatedOn(currDate);
                mvisitorInfoDao.save(visitorInformation);
                response.append("add");
            }
            visitorExists = null;
        }
        currDate = null; user = null;
        return response.toString();
    }

    @Override
    @Transactional
    public String saveVisitorInfoDetails(HttpServletRequest request, VMS_Visitor visitor) {
        StringBuilder response = new StringBuilder();
        Date currDate = new Date();
        M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
        for(VMS_Visitor_Information visitorInfo: visitor.getVisitorInformationList()) {
        	if(visitorInfo.getVisitorActive().compareTo(1) == 0) {
        		System.out.println("active 1");
        		if(!inputVaildationService.onlyAlpabetCheckWithSpace(visitorInfo.getVisitorName())) {
                    System.out.println(visitorInfo.getVisitorName()+" - name");
                    response.append("error");
                }
                if(!inputVaildationService.emailIdValidation(visitorInfo.getVisitorEmail())) {
                    System.out.println(inputVaildationService.emailIdValidation(visitorInfo.getVisitorEmail())+" - "+visitorInfo.getVisitorEmail()+" - email error");
                    response.append("error");
                }
                if(visitorInfo.getVisitorGovtIdTemp().compareTo(-1l) !=0 && !inputVaildationService.numberOnlyValidation(String.valueOf(visitorInfo.getVisitorGovtIdTemp()))) {
                    System.out.println("Id Type name");
                    response.append("error");
                }
                if(!visitorInfo.getVisitorGovtIdNumber().isEmpty() && !inputVaildationService.alphaNumericValidationWithSpace(visitorInfo.getVisitorGovtIdNumber())) {
                    System.out.println("Govt ID Reference");
                    response.append("error");
                }
                if(!visitorInfo.getVisitorBatch().isEmpty() && !inputVaildationService.alphaNumericValidationWithoutSpace(visitorInfo.getVisitorBatch())) {
                    System.out.println("Batch Number");
                    response.append("error");
                }
        	}
        }
        System.out.println(response.toString()+" - Response");
        if(response.toString().contains("error")) {
            response.setLength(0);
            response.append("error");
            return response.toString();
        }
        response.setLength(0);
        VMS_Visitor visitorDet = mVisitorDao.findById(visitor.getVisitorId()).get();
        for(VMS_Visitor_Information visitorInfo: visitorDet.getVisitorInformationDetail()) {
        	visitorInfo.setVisitorActive(0);
        	mvisitorInfoDao.save(visitorInfo);
        }
        for(VMS_Visitor_Information visitorInfo: visitor.getVisitorInformationList()) {
        	if(visitorInfo.getVisitorActive().compareTo(1) == 0) {
        		if(visitorInfo.getVisitorInformationId() != null) {
        			VMS_Visitor_Information currvisitorInfo = mvisitorInfoDao.findById(visitorInfo.getVisitorInformationId()).get();
        			currvisitorInfo.setVisitorInformationDetail(visitorDet);
        			currvisitorInfo.setVisitorName(visitorInfo.getVisitorName());
        			currvisitorInfo.setVisitorEmail(visitorInfo.getVisitorEmail());
        			currvisitorInfo.setVisitorGovtId(mVisitorGovtTypeDao.findById(visitorInfo.getVisitorGovtIdTemp()).get());
        			currvisitorInfo.setVisitorGovtIdNumber(visitorInfo.getVisitorGovtIdNumber());
        			currvisitorInfo.setVisitorImage(visitorInfo.getVisitorImage());
        			currvisitorInfo.setVisitorBatch(visitorInfo.getVisitorBatch());
        			currvisitorInfo.setVisitorActive(1);
        			currvisitorInfo.setUpdatedBy(user);
        			currvisitorInfo.setUpdatedOn(currDate);
        			mvisitorInfoDao.save(currvisitorInfo);
        			currvisitorInfo = null;
        		} else {
        			visitorInfo.setVisitorInformationDetail(visitorDet);
        			visitorInfo.setVisitorName(visitorInfo.getVisitorName());
        			visitorInfo.setVisitorEmail(visitorInfo.getVisitorEmail());
        			visitorInfo.setVisitorGovtId(mVisitorGovtTypeDao.findById(visitorInfo.getVisitorGovtIdTemp()).get());
        			visitorInfo.setVisitorGovtIdNumber(visitorInfo.getVisitorGovtIdNumber());
        			visitorInfo.setVisitorImage(visitorInfo.getVisitorImage());
        			visitorInfo.setVisitorBatch(visitorInfo.getVisitorBatch());
        			visitorInfo.setVisitorActive(1);
        			visitorInfo.setCreatedBy(user);
        			visitorInfo.setCreatedOn(currDate);
        			mvisitorInfoDao.save(visitorInfo);
        			SimpleDateFormat dateFormatTime = new SimpleDateFormat("dd/MMM/yyyy HH:MM a");
        			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MMM/yyyy");
        			System.out.println("visitor image: "+visitorInfo.getVisitorImage());
        			System.out.println("visitor email: "+visitorInfo.getVisitorEmail());
        			StringBuilder emailContent = new StringBuilder("<!DOCTYPE html>" + 
        					"<html xmlns='http://www.w3.org/1999/xhtml' lang='en-US'>" + 
        					"	<head>" + 
        					"		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />" + 
        					"		<title>Visitor Badge</title>" + 
        					"		<meta name='viewport' content='width=device-width, initial-scale=1.0'/>" + 
        					"		<style text='css'>" + 
        					"			.footlast {" + 
        					"				font-family: Helvetica;" + 
        					"				color: #444444;" + 
        					"				font-size: 9pt;" + 
        					"				background-color: #ffffff;" + 
        					"			}" + 
        					"			.namenow {" + 
        					"				font-family: Helvetica;" + 
        					"			}" + 
        					"			table {" + 
        					"				font-family: Helvetica;" + 
        					"				border-width: thin;" + 
        					"				border-spacing: 1px;" + 
        					"				border-style: ridge;" + 
        					"				border-color: #d9d9d9;" + 
        					"			}" + 
        					"			.center {" + 
        					"				display: block;" + 
        					"				margin-left: auto;" + 
        					"				margin-right: auto;" + 
        					"				width: 47%;" + 
        					"			}" + 
        					"			.stable {" + 
        					"				font-family: Helvetica;" + 
        					"				border-collapse: collapse;" + 
        					"			}" + 
        					"			.stable td {" + 
        					"				border: 1px solid #ddd;" + 
        					"				padding: 8px;" + 
        					"			}" + 
        					"			.stable tr{background-color: #deeaf6;}" + 
        					"			.stable th {" + 
        					"				padding-top: 12px;" + 
        					"				padding-bottom: 12px;" + 
        					"				text-align: left;" + 
        					"				background-color: #deeaf6;" + 
        					"				color: white;" + 
        					"			}" + 
        					"			.stable1 {" + 
        					"				border: 1px solid #000;" + 
        					"				border-collapse: collapse;" + 
        					"			}" + 
        					"		</style>" + 
        					"	</head>" + 
        					"	<body style='margin: 0; padding: 0;'>" + 
        					"		<table align='center' width='620px' class='stable1'>" + 
        					"			<tr>" + 
        					"				<td style='padding-top:20px'>" + 
        					"					<img class='' height='32' style='padding-right:30px;float:right' src='cid:logoImage' alt='Anand Group Logo.' />" + 
        					"				</td>" + 
        					"			</tr>" + 
        					"			<tr>" + 
        					"				<td style='padding: 10px 10px 10px 10px;'>" + 
        					"					<p style='margin: 0; padding:10px 0 0 0;color:#00AEEF;font-size:29px' class='namenow'>" + 
        					"					<strong>MESSAGE FROM ADMINISTRATION</strong>" + 
        					"					</p>" + 
        					"					<p style='margin: 0; padding:10px 0 0 0;color:#002E6D;font-size:26.5px' class='namenow'>" + 
        					"					VISITOR E-BADGE" + 
        					"					</p><br>" + 
        					"					<p style='margin: 0; padding:10px 0 0 0;' class='namenow'>" + 
        					"					" + dateFormat.format(currDate) + 
        					"					</p>" + 
        					"				</td>" + 
        					"			</tr>" + 
        					"			<tr>" + 
        					"				<td style='padding: 10px 10px 10px 10px;'>" + 
        					"					<br>" + 
        					"					<p style='margin: 0;padding-bottom:10px;' class='namenow'>" + 
        					"						Dear Visitor,<br>" + 
        					"						Welcome to "+visitorDet.getVisitingLocation().getEntitySource().getEntityName()+" - "+visitorDet.getVisitingLocation().getLocationId().getLocationName()+", you are here to meet "+visitorDet.getHostName().getUserFirstName()+" "+visitorDet.getHostName().getUserLastName()+"." + 
        					"						<br>Details as follows:" + 
        					"					</p>" + 
        					"				</td>" + 
        					"			</tr>" + 
        					"			<tr style='color: #485F86;'>" + 
        					"				<td style='padding: 10px 10px 10px 10px;'>" + 
        					"					<table class='stable' width='100%' style='background-color: #ededed ;'>" + 
        					"						<tr style='background-color:#D1D7E2'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #D1D7E2;text-align: center;' colspan=\"2\">" + 
        					"								<img style='align-items: center;' src='"+visitorInfo.getVisitorImage()+"' />" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"						<tr style='background-color:#EDEEEE'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
        					"								Visitor Name</p>" + 
        					"							</td>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitorInfo.getVisitorName()+"</p>" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"						<tr style='background-color:#D1D7E2'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #D1D7E2;'>" + 
        					"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
        					"								Visitor Company</p>" + 
        					"							</td>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #D1D7E2;'>" + 
        					"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitorInfo.getVisitorInformationDetail().getVisitorCompanyName()+"</p>" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"						<tr style='background-color:#EDEEEE'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
        					"								Host</p>" + 
        					"							</td>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitorDet.getHostName().getUserFirstName()+" "+visitorDet.getHostName().getUserLastName()+"</p>" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"						<tr style='background-color:#D1D7E2'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #D1D7E2;'>" + 
        					"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
        					"								Department</p>" + 
        					"							</td>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #D1D7E2;'>" + 
        					"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitorDet.getHostName().getmDepartmentId().getDepartmentName()+"</p>" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"						<tr style='background-color:#EDEEEE'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
        					"								Time In</p>" + 
        					"							</td>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+dateFormatTime.format(visitorDet.getMeetingDate())+"</p>" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"						<tr style='background-color:#D1D7E2'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #D1D7E2;'>" + 
        					"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
        					"								Valid Upto</p>" + 
        					"							</td>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #D1D7E2;'>" + 
        					"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+dateFormatTime.format(visitorDet.getVisitorAllowedUntil())+"</p>" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"						<tr style='background-color:#EDEEEE'>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
        					"								Badge Number</p>" + 
        					"							</td>" + 
        					"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #EDEEEE;'>" + 
        					"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitorInfo.getVisitorBatch()+"</p>" + 
        					"							</td>" + 
        					"						</tr>" + 
        					"					</table>" + 
        					"				</td>" + 
        					"			</tr>" + 
        					"			<tr>" + 
        					"				<td style='padding: 10px 10px 10px 10px;'>" + 
        					"					<p class='namenow' style='margin: 0;'>" + 
        					"						Warm Regards,<br>" + 
        					"						Administration Team" + 
        					"					</p>" + 
        					"				</td>" + 
        					"			</tr>" + 
        					"			<tr>" + 
        					"				<td style='padding-top:20px'>" + 
        					"					<a title='Anand Group India' href='https://www.anandgroupindia.com/'></a>" + 
        					"				</td>" + 
        					"			</tr>" + 
        					"		</table>" + 
        					"	</body>" + 
        					"</html>");
        			List<String> to = new ArrayList<String>();
        	        if(request.getRequestURL().toString().contains("127.0.0.1") || request.getRequestURL().toString().contains("localhost")) {
        	        	to.add(Common_Constants.toMailIdTesting);
        	        } else {
        	        	to.add(visitorInfo.getVisitorEmail());
        	        }
        	        List<String> cc = new ArrayList<String>();
        	        List<String> bcc = new ArrayList<String>();
        	        System.out.println("ebadge");
        	        mailService.sendEmailToCcAndBcc("Your Visitor e-Badge", emailContent.toString(), to, cc, bcc);
        	        to = null;cc = null;bcc = null;
        			dateFormatTime = null; dateFormat = null;
        			emailContent.setLength(0);  emailContent = null;
        		}
        	}
        }
        visitorDet = null;
        response.append("edit");
        currDate = null; user = null;
        return response.toString();
    }

    @Override
    public String getVisitorInfoDetails(HttpServletRequest request) {
        String response = "";
        Map<String, String> visitorDetails = new HashMap<String, String>();
        try {
            /*VMS_Visitor visitor = mvisitorDao.getOne(Integer.parseInt(""+request.getParameter("mvisitorId")));*/
            VMS_Visitor_Information visitor = mvisitorInfoDao.findById(Long.parseLong(""+request.getParameter("visitorInfoId"))).get();
            visitorDetails.put("visitorInfoName", visitor.getVisitorName());
            visitorDetails.put("visitorInfoIdentificationType", String.valueOf(visitor.getVisitorGovtId()));
            //visitorDetails.put("visitorInfoImageString", String.valueOf(visitor.getVisitorImageBlob()));
            visitorDetails.put("visitorInfoBadgeNumber", String.valueOf(visitor.getVisitorBatch()));
            visitorDetails.put("visitorInfoCreatedBy", String.valueOf(visitor.getCreatedBy()));
            visitorDetails.put("visitorInfoCreatedOn", String.valueOf(visitor.getCreatedOn()));
            Gson gson = new Gson();
            response = gson.toJson(visitorDetails);
            gson = null; visitor = null; visitorDetails = null;
        } catch(Exception e) {
            e.printStackTrace();
            response = "error";
        }
        return response;
    }

    @Override
    public List<VMS_Visitor_Information> getVisitorInformation(HttpServletRequest request) {
    	VMS_Visitor visitor = mVisitorDao.findById(Long.parseLong(request.getParameter("id"))).get();
    	List<VMS_Visitor_Information> visitorInformation = mvisitorInfoDao.findByVisitorInformationDetailAndVisitorActive(visitor,1);
    	List<VMS_Visitor_Information> visitorInformationTemp = mvisitorInfoDao.findByVisitorInformationDetailAndVisitorActive(visitor,1);
        try {
            if(visitorInformationTemp != null && visitorInformationTemp.size() != 0) {
            	visitor = null;
            	for(VMS_Visitor_Information visitorInfo: visitorInformationTemp) {
            		if(visitorInfo.getVisitorActive().compareTo(1) == 0) {
            			visitorInfo.setVisitorGovtIdTemp(visitorInfo.getVisitorGovtId().getMVisitorTypeId());
            			visitorInformation.add(visitorInfo);
            		}
            	}
            	return visitorInformation;
            } else {
            	System.out.println("came here --- ");
            	visitorInformation = new ArrayList<VMS_Visitor_Information>();
            	for(int i = 0; i < visitor.getTotalVisitor(); i++) {
            		VMS_Visitor_Information visitorInfo = new VMS_Visitor_Information();
            		System.out.println("came here --- "+i);
            		if(i == 0) {
            			visitorInfo.setVisitorName(visitor.getVisitorName());
            			visitorInfo.setVisitorEmail(visitor.getVisitorEmail());
            		}
            		visitorInfo.setVisitorActive(1);
            		visitorInfo.setParentVisitorId(visitor.getVisitorId());
            		visitorInformation.add(visitorInfo);
            		visitorInfo = null;
            	}
            	visitor = null;
            	return visitorInformation;
            }
        } catch(Exception e) {
            e.printStackTrace();
            visitor = null; visitorInformation.clear(); visitorInformation = null;
            return null;
        }
    }

	@Override
	@Transactional
	public String punchOutVisitor(HttpServletRequest request) {
		System.out.println(request.getParameter("id"));
		VMS_Visitor_Information visitorInfo = mvisitorInfoDao.findById(Long.parseLong(""+request.getParameter("id"))).get();
		Date currDate = new Date();
		visitorInfo.setOutTime(currDate);
		mvisitorInfoDao.save(visitorInfo);
		currDate = null; visitorInfo = null;
		return "success";
	}

	@Override
	public List<VMS_Visitor_Information> getVisitorInfoList(VMS_Visitor_Information visitorInformation, HttpServletRequest request, Integer getFlag) {
	    List<VMS_Visitor_Information> finalvisitorInfoList = new ArrayList<VMS_Visitor_Information>();
	    Integer activenessCheck = 1;
	    M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
	    List<VMS_Visitor_Information> visitorInfoList = null;
	    try {
	        if (getFlag == 1){ // Checks for Get Mapping
	            System.out.println("getFlag raised");
	            List<VMS_Visitor> visitorList1 = mVisitorDao.findByVisitorActive(1);
	            for (VMS_Visitor visitor : visitorList1){
	                visitorInformation.setVisitorInformationDetail(visitor);
	            }
	        }else {
	            System.out.println("getFlag down");
	        }
	        if(visitorInformation.getVisitorInformationDetail().getVisitingLocationTemp() == null) { // Initialize the location filter
	            if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) ||
	                    (request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) { //Checks for Authorized roles
	                visitorInformation.getVisitorInformationDetail().setVisitingLocationTemp(mUserEntityMapDao.findByUserInfoForEntityAndUserEntityActive(user, 1).get(0).getEntityInfoForUsers().getmEntityId()); // Set first entity mapped to authorized user in the filter
	            } else {
	                visitorInformation.getVisitorInformationDetail().setVisitingLocationTemp(user.getmEntityId().getmEntityId());// Set filter value to entity of employee user
	            }
	        }
	        if(visitorInformation.getVisitorInformationDetail().getMeetingStartDateTemp() == null || visitorInformation.getVisitorInformationDetail().getMeetingStartDateTemp().isEmpty()) { //Initialize date filter
	            visitorInformation.getVisitorInformationDetail().setMeetingStartDateTemp(LocalDate.now().format(DateTimeFormatter.ISO_DATE)); //set value of date filter to today
	        }
	        visitorInfoList = new ArrayList<VMS_Visitor_Information>();
	        List<VMS_Visitor_Information> visitorListTemp = mvisitorInfoDao.findVisitorInformationByDateAndEntity(visitorInformation.getVisitorInformationDetail().getVisitingLocationTemp(), visitorInformation.getVisitorInformationDetail().getMeetingStartDateTemp());// DAO method to filter data
	        if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) ||
	                (request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) {
	            if(visitorInformation.getVisitorInformationDetail().getHostNameTemp() != null && visitorInformation.getVisitorInformationDetail().getHostNameTemp().compareTo(-1L) != 0) {// Check if the host name filter is turned on(off by default)
	            	visitorInfoList = visitorListTemp.stream()
	                        .filter(tempVisitor -> tempVisitor.getVisitorInformationDetail().getHostName().getmUserId().compareTo(visitorInformation.getVisitorInformationDetail().getHostNameTemp()) == 0) //filter for hostname if yes
	                        .collect(Collectors.toList());
	            } else {
	            	visitorInfoList.addAll(visitorListTemp);
	            }
	        } else {
	        	visitorInfoList = visitorListTemp.stream()
	                    .filter(tempVisitor -> tempVisitor.getVisitorInformationDetail().getHostName().getmUserId().compareTo(user.getmUserId()) == 0)
	                    .collect(Collectors.toList());
	        }
	        finalvisitorInfoList.addAll(visitorInfoList);
	        activenessCheck = null;
	        visitorInfoList.clear(); visitorInfoList = null;
	        getFlag = null;
	    } catch (Exception e) {
	        e.printStackTrace();
	        activenessCheck = null;
	        finalvisitorInfoList.clear(); finalvisitorInfoList = null;
	        visitorInfoList.clear(); visitorInfoList = null;
	    }
	    Collections.sort(finalvisitorInfoList);
	    return finalvisitorInfoList;
	}
} 