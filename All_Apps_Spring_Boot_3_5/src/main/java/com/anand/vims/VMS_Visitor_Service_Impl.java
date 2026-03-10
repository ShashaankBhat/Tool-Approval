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
import jakarta.servlet.http.HttpServletRequest;

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

@Service
public class VMS_Visitor_Service_Impl implements VMS_Visitor_Service {

	@Autowired private M_User_Dao mUserDao;
	@Autowired private M_User_Entity_Map_Dao mUserEntityMapDao;
	@Autowired private M_Entity_Dao mEntityDao;
	@Autowired private VMS_Visitor_Dao vmsVisitorDao;
	@Autowired private VMS_Visitor_Information_Dao vmsVisitorInfoDao;
    @Autowired private VMS_M_Visitor_Purpose_Dao visitorPurposeDao;
    @Autowired private VMS_M_Visitor_Type_Dao visitorTypeDao;
    @Autowired private InputValidation inputVaildationService;
    @Autowired private MailService mailService;

    @Override
    public List<VMS_Visitor> getVisitorList(HttpServletRequest request, Integer offset) {
        List<VMS_Visitor> finalvisitorList = new ArrayList<VMS_Visitor>();
        try {
            List<VMS_Visitor> visitorList = null;
            Integer activenessCheck = 1;
            if(request.getParameter("all") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getParameter("all"))) == 0) {
                visitorList = vmsVisitorDao.findAll();
            } else {
                visitorList = vmsVisitorDao.getVisitorWithOffset(offset);
            }
            for(VMS_Visitor visitor : visitorList) {
                visitor.setActionForList("");
                if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0)
                        || (request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) {
                    visitor.setActionForList("<a href='book-appointment?id="+visitor.getVisitorId()+"' title='Edit visitor'><i class='fas fa-edit'></i></a>&ensp;"
                    	+ "<a href='visitor-information?id="+visitor.getVisitorId()+"' title='Add Visitor Information'><i class='fas fa-plus'></i></a>");
                    	/*+ "&ensp;<a target='_blank' href='print?id="+visitor.getVisitorId()+"'' title='Print Visitor Pass'><i class='fas fa-print'></i></a>");*/
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
    public List<VMS_Visitor> getVisitorByActiveStatus(Integer visitorActive) {
        List<VMS_Visitor> visitorList = null;
        try {
        	//M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
        	visitorList = vmsVisitorDao.findByVisitorActive(visitorActive);
            /*Integer activenessCheck = 1;
            if(request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0) {
            	
            } else {
            	visitorList = vmsVisitorDao.findByVisitingLocationAndMeetingDateAndHostName(user.getmEntityId(), new Date(), user);
            }*/
            	
            Collections.sort(visitorList);
            //activenessCheck = null;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return visitorList;
    }

    @Override
    @Transactional
    public String saveVisitorDetails(HttpServletRequest request, VMS_Visitor visitor) throws Exception {
        StringBuilder response = new StringBuilder();
        if(!inputVaildationService.stringOnlyValidation(visitor.getVisitorName())) {
            System.out.println("Visitor Name Error");
            response.append("error");
        }
        if(!inputVaildationService.emailIdValidation(visitor.getVisitorEmail())) {
            System.out.println("Visitor Email Error");
            response.append("error");
        }
        if(!inputVaildationService.numberOnlyValidation(""+visitor.getTotalVisitor())) {
            System.out.println("Total Visitor Error");
            response.append("error");
        }
        if(!inputVaildationService.stringOnlyValidation(visitor.getVisitorCompanyName())) {
            System.out.println("Visitor Company Name Error");
            response.append("error");
        }
        if(!inputVaildationService.textareaValidation(visitor.getVisitorCompanyAddress())) {
            System.out.println("Visitor Company Address Error");
            response.append("error");
        }
        if(!inputVaildationService.textareaValidation(visitor.getVisitorRemarks())) {
            System.out.println("Remarks Error");
            response.append("error");
        }
        if(visitor.getHostExtensionNumber() != null && !inputVaildationService.numberOnlyValidation(""+visitor.getHostExtensionNumber())) {
            System.out.println("Host Extension Error");
            response.append("error");
        }
        if(!visitor.getMeetingPlace().isEmpty() && !inputVaildationService.alphaNumericValidationWithSpace(""+visitor.getMeetingPlace())) {
            System.out.println("Meeting Place Error");
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
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
        if(visitor.getVisitorId() != null) {
            VMS_Visitor currvisitor = vmsVisitorDao.findById(Long.parseLong(""+visitor.getVisitorId())).get();
            currvisitor.setVisitorActive(1);
            currvisitor.setVisitorName(visitor.getVisitorName());
            currvisitor.setVisitorEmail(visitor.getVisitorEmail());
            currvisitor.setMVisitorType(visitorTypeDao.findById(visitor.getVisitorTypeTemp()).get());
            currvisitor.setMVisitorPurpose(visitorPurposeDao.findById(visitor.getVisitorPurposeTemp()).get());
            currvisitor.setVisitingLocation(mEntityDao.findById(visitor.getVisitingLocationTemp()).get());
            currvisitor.setVisitorPlantEntry(visitor.getVisitorPlantEntry());

            
            currvisitor.setTotalVisitor(visitor.getTotalVisitor() + 1);
            System.out.println(visitor.getTotalVisitor()+" Total Visitor");
            currvisitor.setTotalVisitor(visitor.getTotalVisitor() + 1);
            System.out.println(currvisitor.getTotalVisitor()+" Total Visitor");
            
            
            currvisitor.setVisitorCompanyName(visitor.getVisitorCompanyName());
            currvisitor.setVisitorCompanyAddress(visitor.getVisitorCompanyAddress());
            System.out.println(visitor.getVisitorCanteenAccess());
            System.out.println(visitor.getVisitorLaptopAllowed());
            System.out.println(visitor.getVisitorCellPhoneAllowed());
            System.out.println(visitor.getVisitorEscortRequired());
            if(visitor.getVisitorCanteenAccess() != null) {
            	currvisitor.setVisitorCanteenAccess(visitor.getVisitorCanteenAccess());
            } else {
            	currvisitor.setVisitorCanteenAccess(0);
            }
            if(visitor.getVisitorLaptopAllowed() != null) {
            	currvisitor.setVisitorLaptopAllowed(visitor.getVisitorLaptopAllowed());
            } else {
            	currvisitor.setVisitorLaptopAllowed(0);
            }
            if(visitor.getVisitorCellPhoneAllowed() != null) {
            	currvisitor.setVisitorCellPhoneAllowed(visitor.getVisitorCellPhoneAllowed());
            } else {
            	currvisitor.setVisitorCellPhoneAllowed(0);
            }
            if(visitor.getVisitorEscortRequired() != null) {
            	currvisitor.setVisitorEscortRequired(visitor.getVisitorEscortRequired());
            } else {
            	currvisitor.setVisitorEscortRequired(0);
            }
            currvisitor.setVisitorRemarks(visitor.getVisitorRemarks());
            currvisitor.setHostName(mUserDao.findById(visitor.getHostNameTemp()).get());
            currvisitor.setHostExtensionNumber(visitor.getHostExtensionNumber());
            currvisitor.setMeetingPlace(visitor.getMeetingPlace());
            currvisitor.setMeetingDate(dateFormat.parse(visitor.getMeetingStartDateTemp()+" "+visitor.getMeetingStartTimeTemp()));
            currvisitor.setVisitorAllowedUntil(dateFormat.parse(visitor.getMeetingEndDateTemp()+" "+visitor.getMeetingEndTimeTemp()));
            currvisitor.setVisitorUpdatedBy(user);
            currvisitor.setVisitorUpdatedOn(currDate);
            vmsVisitorDao.save(currvisitor);
            response.append("edit-"+currvisitor.getVisitorId());
            currvisitor = null;
        } else {
        	visitor.setVisitorActive(1);
            visitor.setVisitorName(visitor.getVisitorName());
            visitor.setVisitorEmail(visitor.getVisitorEmail());
            visitor.setMVisitorType(visitorTypeDao.findById(visitor.getVisitorTypeTemp()).get());
            visitor.setMVisitorPurpose(visitorPurposeDao.findById(visitor.getVisitorPurposeTemp()).get());
            visitor.setVisitingLocation(mEntityDao.findById(visitor.getVisitingLocationTemp()).get());
            visitor.setVisitorPlantEntry(visitor.getVisitorPlantEntry());
            System.out.println(visitor.getTotalVisitor()+" Total Visitor");
            visitor.setTotalVisitor(visitor.getTotalVisitor() + 1);
            System.out.println(visitor.getTotalVisitor()+" Total Visitor");
            visitor.setVisitorCompanyName(visitor.getVisitorCompanyName());
            visitor.setVisitorCompanyAddress(visitor.getVisitorCompanyAddress());
            if(visitor.getVisitorCanteenAccess() != null) {
            	visitor.setVisitorCanteenAccess(visitor.getVisitorCanteenAccess());
            } else {
            	visitor.setVisitorCanteenAccess(0);
            }
            if(visitor.getVisitorLaptopAllowed() != null) {
            	visitor.setVisitorLaptopAllowed(visitor.getVisitorLaptopAllowed());
            } else {
            	visitor.setVisitorLaptopAllowed(0);
            }
            if(visitor.getVisitorCellPhoneAllowed() != null) {
            	visitor.setVisitorCellPhoneAllowed(visitor.getVisitorCellPhoneAllowed());
            } else {
            	visitor.setVisitorCellPhoneAllowed(0);
            }
            if(visitor.getVisitorEscortRequired() != null) {
            	visitor.setVisitorEscortRequired(visitor.getVisitorEscortRequired());
            } else {
            	visitor.setVisitorEscortRequired(0);
            }
            visitor.setVisitorRemarks(visitor.getVisitorRemarks());
            visitor.setHostName(mUserDao.findById(visitor.getHostNameTemp()).get());
            visitor.setHostExtensionNumber(visitor.getHostExtensionNumber());
            visitor.setMeetingPlace(visitor.getMeetingPlace());
            visitor.setMeetingDate(dateFormat.parse(visitor.getMeetingStartDateTemp()+" "+visitor.getMeetingStartTimeTemp()));
            visitor.setVisitorAllowedUntil(dateFormat.parse(visitor.getMeetingEndDateTemp()+" "+visitor.getMeetingEndTimeTemp()));
            visitor.setVisitorCreatedBy(user);
            visitor.setVisitorCreatedOn(currDate);
            vmsVisitorDao.save(visitor);
            response.append("add-"+visitor.getVisitorId());
        }
        currDate = null; user = null;
        return response.toString();
    }

    @Override
    public String getVisitorDetails(HttpServletRequest request) {
        String response = "";
        Map<String, String> visitorDetails = new HashMap<String, String>();
        try {
            /*VMS_Visitor visitor = vmsVisitorDao.getOne(Integer.parseInt(""+request.getParameter("mvisitorId")));*/
            VMS_Visitor visitor = vmsVisitorDao.findById(Long.parseLong(""+request.getParameter("visitorID"))).get();
            visitorDetails.put("visitorName", visitor.getVisitorName());
            visitorDetails.put("companyName", visitor.getVisitorCompanyName());
            visitorDetails.put("companyAddress", visitor.getVisitorCompanyAddress());
            visitorDetails.put("visitorEmail", visitor.getVisitorEmail());
            visitorDetails.put("visitorPurpose", String.valueOf(visitor.getMVisitorPurpose()));
            visitorDetails.put("location", String.valueOf(visitor.getVisitingLocation()));
            visitorDetails.put("visitorType",String.valueOf(visitor.getMVisitorType()));
            visitorDetails.put("visitorPlantEntry", String.valueOf(visitor.getVisitorPlantEntry()));
            visitorDetails.put("hostName", String.valueOf(visitor.getHostName()));
            visitorDetails.put("visitorAmount", String.valueOf(visitor.getTotalVisitor()));
            visitorDetails.put("visitorRemarks", visitor.getVisitorRemarks());
            visitorDetails.put("hostExtensionNumber", String.valueOf(visitor.getHostExtensionNumber()));
            visitorDetails.put("hostMobileNumber", String.valueOf(visitor.getHostMobileNumber()));
            visitorDetails.put("duration", String.valueOf(visitor.getDuration()));
            visitorDetails.put("visitorAllowedUntil", String.valueOf(visitor.getVisitorAllowedUntil()));
            visitorDetails.put("visitorLaptopAllowed", String.valueOf(visitor.getVisitorLaptopAllowed()));
            visitorDetails.put("visitorCellPhoneAllowed", String.valueOf(visitor.getVisitorCellPhoneAllowed()));
            visitorDetails.put("visitorEscortRequired", String.valueOf(visitor.getVisitorEscortRequired()));
            visitorDetails.put("meetingDate",String.valueOf(visitor.getMeetingDate()));
            visitorDetails.put("meetingStartTime",String.valueOf(visitor.getMeetingStartTime()));
            visitorDetails.put("meetingEndTime",String.valueOf(visitor.getMeetingEndTime()));
            visitorDetails.put("visitorCanteenAccess", String.valueOf(visitor.getVisitorCanteenAccess()));
            visitorDetails.put("visitorCreatedBy", String.valueOf(visitor.getVisitorCreatedBy()));
            visitorDetails.put("visitorCreatedOn", String.valueOf(visitor.getVisitorCreatedOn()));
            visitorDetails.put("visitorUpdatedBy", String.valueOf(visitor.getVisitorUpdatedBy()));
            visitorDetails.put("visitorUpdatedOn", String.valueOf(visitor.getVisitorUpdatedOn()));

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
	public String saveUserRegistraiton(HttpServletRequest request, M_User user) {
		StringBuilder response = new StringBuilder();
		/*M_User currUser = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		M_User userExists = mUserDao.findByUserLoginId(user.getUserLoginId());
		if (userExists != null) {
			System.out.println("name exists");
			response.append("nameExists");
		} else {
			BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
			if (user.getUserMiddleName() != null && !user.getUserMiddleName().isEmpty()) {
				user.setUserMiddleName(user.getUserMiddleName());
			} else {
				user.setUserMiddleName(null);
			}
			M_Entity entityInfo = mEntityDao.findById(Long.parseLong("" + user.getTempEntityId())).get();
			user.setmEntityId(entityInfo);
			user.setmDepartmentId(mDepartmentDao.findById(Long.parseLong("" + user.getTempDepartmentId())).get());
			user.setmDesignationId(mDesignationDao.findById(Long.parseLong("" + user.getTempDesignationId())).get());
			user.setUserPassword(bCryptPasswordEncoder.encode(user.getUserPassword()));
			user.setUserPasswordTwo(EncryptionDecryptionFunction.getEncryptedData(user.getUserPassword()));
			user.setUserActive(1);
			user.setUserApproved(1);
			user.setUserEmailVerifyToken(EncryptionDecryptionFunction.getEncryptedData(user.getUserLoginId()));
			user.setUserCreatedOn(currDate);
			user.setUserCreatedBy(currUser);

			M_User lastUser = mUserDao.getUserInfoWhichContainsUserCode(entityInfo.getEntityAcronym());
			if (lastUser != null) {
				String[] userCodeSplit = lastUser.getUserCode().split(entityInfo.getEntityAcronym());
				Integer lastValue = Integer.parseInt(userCodeSplit[1]);
				lastValue++;
				if (lastValue.compareTo(10) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "0000" + lastValue);
				} else if (lastValue.compareTo(100) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "000" + lastValue);
				} else if (lastValue.compareTo(1000) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "00" + lastValue);
				} else if (lastValue.compareTo(10000) < 0) {
					user.setUserCode(entityInfo.getEntityAcronym() + "0" + lastValue);
				} else {
					user.setUserCode(entityInfo.getEntityAcronym() + lastValue);
				}
				userCodeSplit = null;
				lastValue = null;
			} else {
				user.setUserCode(entityInfo.getEntityAcronym() + "00001");
			}
			lastUser = null;

			mUserDao.save(user);

			M_Role mRole = mRoleDao.findByRoleName("Employee").get(0);
			M_User_Role_Map userRoleMap = new M_User_Role_Map();
			userRoleMap.setUserInfoForRole(user);
			userRoleMap.setRoleInfoForUsers(mRole);
			userRoleMap.setUserRoleActive(1);
			userRoleMap.setUserRoleCreatedBy(currUser);
			userRoleMap.setUserRoleCreatedOn(currDate);
			mUserRoleMapDao.save(userRoleMap);

			currUser = null;
			currDate = null;
			mRole = null;
			userRoleMap = null;
			bCryptPasswordEncoder = null;
			user = null;
			response.append("add");
		}
		userExists = null;*/
		return response.toString();
	}

	@Override
	public VMS_Visitor getAppointmentInformationUsingId(HttpServletRequest request) {
		try {
			VMS_Visitor visitor = vmsVisitorDao.findById(Long.parseLong(""+request.getParameter("id"))).get();
			SimpleDateFormat formatDate = new SimpleDateFormat("dd/MMM/yyyy");
            SimpleDateFormat formatTime = new SimpleDateFormat("hh:mm a");
            visitor.setMeetingStartDateTemp(formatDate.format(visitor.getMeetingDate()));
            visitor.setMeetingStartTimeTemp(formatTime.format(visitor.getMeetingDate()));
            visitor.setMeetingEndDateTemp(formatDate.format(visitor.getVisitorAllowedUntil()));
            visitor.setMeetingEndTimeTemp(formatTime.format(visitor.getVisitorAllowedUntil()));
            List<VMS_Visitor_Information> visitorInformation = vmsVisitorInfoDao.findByVisitorInformationDetailAndVisitorActive(visitor,1);
            System.out.println("came here 1");
            if(visitorInformation != null && visitorInformation.size() != 0) {
            	visitor.setVisitorInformationList(visitorInformation);
            	System.out.println("came here 3");
            } else {
            	visitorInformation = new ArrayList<VMS_Visitor_Information>();
            	for(int i =0; i< visitor.getTotalVisitor(); i++) {
            		VMS_Visitor_Information visitorInfo = new VMS_Visitor_Information();
            		System.out.println("came here 2");
                	if(i == 0) {
                		visitorInfo.setVisitorName(visitor.getVisitorName());
            			visitorInfo.setVisitorEmail(visitor.getVisitorEmail());
                	}
            		visitorInfo.setVisitorActive(1);
            		visitorInfo.setParentVisitorId(visitor.getVisitorId());
            		visitorInformation.add(visitorInfo);
            		visitorInfo = null;
            	}
            	visitor.setVisitorInformationList(visitorInformation);
            }
            
            formatDate = null; formatTime = null;
			return visitor;
		} catch(Exception e) {
			return null;
		}
	}

	@Override
	public void sendVisitingInformationEmail(Long visitorId, HttpServletRequest request) {
		try {
			VMS_Visitor visitor = vmsVisitorDao.findById(visitorId).get();
	        Date currDate = new Date();
	        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
	        SimpleDateFormat dateFormatTime = new SimpleDateFormat("dd-MMM-yyyy HH:MM a");
	        StringBuilder emailBody = new StringBuilder("<!DOCTYPE html>" + 
	        		"<html xmlns='http://www.w3.org/1999/xhtml' lang='en-US'>" + 
	        		"	<head>" + 
	        		"		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />" + 
	        		"		<title>Appointment Booked</title>" + 
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
	        		"				<td>" + 
	        		"					<img class='' height='32' style='padding-right:30px;float:right' src='cid:logoImage' alt='Anand Group Logo.' />" + 
	        		"				</td>" + 
	        		"			</tr>" + 
	        		"			<tr>" + 
	        		"				<td style='padding: 10px 10px 10px 10px;'>" + 
	        		"					<p style='margin: 0; padding:10px 0 0 0;color:#00AEEF;font-size:29px' class='namenow'>" + 
	        		"					<strong>MESSAGE FROM ADMINISTRATION</strong>" + 
	        		"					</p>" + 
	        		"					<p style='margin: 0; padding:10px 0 0 0;color:#002E6D;font-size:26.5px' class='namenow'>" + 
	        		"					APPOINTMENT BOOKED" + 
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
	        		"						Dear "+visitor.getVisitorName()+",<br>" + 
	        		"						Your appointment has been booked with "+visitor.getHostName().getUserFirstName()+" "+visitor.getHostName().getUserLastName()+".<br>Details as follows:" + 
	        		"					</p>" + 
	        		"				</td>" + 
	        		"			</tr>" + 
	        		"			<tr>" + 
	        		"				<td style='padding: 10px 10px 10px 10px;'>" + 
	        		"					<table class='stable' width='100%' style='background-color: #ededed ;'>" + 
	        		"						<tr>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
	        		"								Location </p>" + 
	        		"							</td>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitor.getVisitingLocation().getEntityName() +" - "+visitor.getVisitingLocation().getLocationId().getLocationName()+"</p>" + 
	        		"							</td>" + 
	        		"						</tr>" + 
	        		"						<tr>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
	        		"								Total Visitors</p>" + 
	        		"							</td>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitor.getTotalVisitor()+"</p>" + 
	        		"							</td>" + 
	        		"						</tr>" + 
	        		"						<tr>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
	        		"								Purpose </p>" + 
	        		"							</td>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitor.getMVisitorPurpose().getVisitorPurposeName()+"</p>" + 
	        		"							</td>" + 
	        		"						</tr>" + 
	        		"						<tr>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
	        		"								Meeting Start Date &amp; Time</p>" + 
	        		"							</td>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+dateFormatTime.format(visitor.getMeetingDate())+"</p>" + 
	        		"							</td>" + 
	        		"						</tr>" + 
	        		"						<tr>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
	        		"								Meeting End Date &amp; Time</p>" + 
	        		"							</td>" + 
	        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+dateFormatTime.format(visitor.getVisitorAllowedUntil())+"</p>" + 
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
	        List<String> cc = new ArrayList<String>();
	        if(request.getRequestURL().toString().contains("127.0.0.1") || request.getRequestURL().toString().contains("localhost")) {
	        	to.add(Common_Constants.toMailIdTesting);
	        } else {
	        	to.add(visitor.getVisitorEmail());
	        	cc.add(visitor.getHostName().getUserLoginId());
	        }
	        List<String> bcc = new ArrayList<String>();
	        mailService.sendEmailToCcAndBcc("Appointment Booked with "+visitor.getHostName().getUserFirstName()+" "+visitor.getHostName().getUserLastName(), emailBody.toString(), to, cc, bcc);
	        to = null;cc = null;bcc = null;
	        dateFormatTime = null; dateFormat = null; currDate = null; visitor = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List <VMS_Visitor> passVisitorListAccordingToRole(HttpServletRequest request, Long entity, String date, Long userId) {
	    List<VMS_Visitor> finalvisitorList = new ArrayList<VMS_Visitor>();
	    M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
	    try{
	        List<VMS_Visitor> visitorList = null;
	        Integer activenessCheck =1;
	        System.out.println("User is:" + userId);
	        System.out.println("Entity is:" + entity);
	        System.out.println("Date is:" + date);
	        
	        if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) || 
	        	(request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) {
	            System.out.println("Authorised Role");
	            if (userId != null && userId != -1) {
	                visitorList = vmsVisitorDao.getVisitorWithDateAndEntityIdAndUserID(entity, date, userId);
	            } else {
	                
	            }
	            visitorList = vmsVisitorDao.getVisitorWithDateAndEntityId(entity, date);
	            visitorList.stream()
	              .filter(visitor -> visitor.getHostName().getmUserId().compareTo(userId) == 0)
	              .collect(Collectors.toList());
	            for (VMS_Visitor visitor: visitorList){
	                visitor.setActionForList("<a href='book-appointment?id="+visitor.getVisitorId()+"' title='Edit visitor'><i class='fas fa-edit'></i></a>");
	                visitor.setActionForList("&ensp;<a href='visitor-information?id="+visitor.getVisitorId()+"'' title='addVisitorInfo'><i class='fas fa-plus'></i></a>");
	                /*visitor.setActionForList("&ensp;<a href='print?id="+visitor.getVisitorId()+"'' title='addVisitorPrint'><i class='fas fa-print'></i></a>");*/
	                finalvisitorList.add(visitor);
	            }
	        }
	        else{
	            System.out.println("Employee Role");
	            visitorList = vmsVisitorDao.getVisitorWithCurrentDate(user.getmUserId(),date);
	            for (VMS_Visitor visitor : visitorList) {
	                visitor.setActionForList("<a href='book-appointment?id=" + visitor.getVisitorId() + "' title='Edit visitor'><i class='fas fa-edit'></i></a>"); // Removes actions for VIMS-User roles
	            }
	            user = null;
	        }
	        finalvisitorList.addAll(visitorList);
	        Collections.sort(finalvisitorList);
	        visitorList = null;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	    return finalvisitorList;
	}

	@Override
	public List<VMS_Visitor> getVisitorList(VMS_Visitor visitor, HttpServletRequest request) {
		List<VMS_Visitor> finalvisitorList = new ArrayList<VMS_Visitor>();
		Integer activenessCheck = 1;
		M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
		Date currDate = new Date();
		List<VMS_Visitor> visitorList = null;
		try {
			
			if(visitor.getVisitingLocationTemp() == null) {
				if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) || 
				        (request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) {
					visitor.setVisitingLocationTemp(mUserEntityMapDao.findByUserInfoForEntityAndUserEntityActive(user, 1).get(0).getEntityInfoForUsers().getmEntityId());
				} else {
					visitor.setVisitingLocationTemp(user.getmEntityId().getmEntityId());
				}
			}
			if(visitor.getMeetingStartDateTemp() == null || visitor.getMeetingStartDateTemp().isEmpty()) {
				visitor.setMeetingStartDateTemp(LocalDate.now().format(DateTimeFormatter.ISO_DATE));
			}
			visitorList = new ArrayList<VMS_Visitor>();
			List<VMS_Visitor> visitorListTemp = vmsVisitorDao.getVisitorWithDateAndEntityId(visitor.getVisitingLocationTemp(), visitor.getMeetingStartDateTemp());
			if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) || 
		        (request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) {
				if(visitor.getHostNameTemp() != null && visitor.getHostNameTemp().compareTo(-1l) != 0) {
					visitorList = visitorListTemp.stream()
	            	.filter(tempVisitor -> tempVisitor.getHostName().getmUserId().compareTo(visitor.getHostNameTemp()) == 0)
	            	.collect(Collectors.toList());
				} else {
					visitorList.addAll(visitorListTemp);
				}
			} else {
				visitorList = visitorListTemp.stream()
					.filter(tempVisitor -> tempVisitor.getHostName().getmUserId().compareTo(user.getmUserId()) == 0)
					.collect(Collectors.toList());
			}
			for (VMS_Visitor tempVisitor: visitorList) {
				if(currDate.compareTo(tempVisitor.getVisitorAllowedUntil()) <= 0) {
					tempVisitor.setActionForList("<a href='book-appointment?id="+tempVisitor.getVisitorId()+"' title='Edit visitor'><i class='fas fa-edit'></i></a>");
					if((request.getSession(true).getAttribute("itAdmin") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("itAdmin"))) == 0) || 
					        (request.getSession(true).getAttribute("vimsReception") != null && activenessCheck.compareTo(Integer.parseInt(""+request.getSession(true).getAttribute("vimsReception"))) == 0)) {
						tempVisitor.setActionForList(tempVisitor.getActionForList()+"&ensp;<a href='visitor-information?id="+tempVisitor.getVisitorId()+"' title='Add Visitor Information'><i class='fas fa-plus'></i></a>");
						/*tempVisitor.setActionForList(tempVisitor.getActionForList()+"&ensp;<a href='print?id="+tempVisitor.getVisitorId()+"' title='addVisitorPrint'><i class='fas fa-print'></i></a>");*/
					}
				} else {
					tempVisitor.setActionForList("<i title='Action Expired' class='fas fa-ban sequence-font-1'></i>");
				}
                finalvisitorList.add(tempVisitor);
            }
			activenessCheck = null; 
			currDate = null;
			visitorList.clear(); visitorList = null;
		} catch (Exception e) {
			e.printStackTrace();
			activenessCheck = null; currDate = null;
			finalvisitorList.clear(); finalvisitorList = null;
			visitorList.clear(); visitorList = null;
		}
		return finalvisitorList;
	}

	@Override
	public List<M_User_Entity_Map> getUserEntityForMapping(HttpServletRequest request){
	    try {
	       M_User user = mUserDao.findByUserLoginId(SecurityContextHolder.getContext().getAuthentication().getName());
	       return mUserEntityMapDao.findByUserInfoForEntity(user);
	    }catch (Exception e){
	       e.printStackTrace();
	       return null;
	    }
	}

	@Override
	public void sendNotificationToHost(Long visitorId, HttpServletRequest request) {
		try {
			System.out.println("******** 1");
			VMS_Visitor visitor = vmsVisitorDao.findById(visitorId).get();
	        System.out.println("******** 2");
	        StringBuilder emailBody = new StringBuilder("<!DOCTYPE html>" + 
	        		"<html xmlns='http://www.w3.org/1999/xhtml' lang='en-US'>" + 
	        		"	<head>" + 
	        		"		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />" + 
	        		"		<title>Visitor Arrived</title>" + 
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
	        		"					YOUR VISITOR(S) ARRIVED" + 
	        		"					</p><br>" + 
	        		"					<p style='margin: 0; padding:10px 0 0 0;' class='namenow'>" + 
	        		"					25-JAN-2022" + 
	        		"					</p>" + 
	        		"				</td>" + 
	        		"			</tr>" + 
	        		"			<tr>" + 
	        		"				<td style='padding: 10px 10px 10px 10px;'>" + 
	        		"					<br>" + 
	        		"					<p style='margin: 0;padding-bottom:10px;' class='namenow'>" + 
	        		"						Dear "+visitor.getHostName().getUserFirstName().concat(" "+visitor.getHostName().getUserLastName())+",<br>" + 
	        		"						Your visitors has arrived.<br>Details as follows:" + 
	        		"					</p>" + 
	        		"				</td>" + 
	        		"			</tr>");
	        		Integer visitorCount = 1;
	        		System.out.println(vmsVisitorInfoDao.findByVisitorInformationDetailAndVisitorActive(visitor, 1).size()+" size of visitor information set -----------------");
	        		for(VMS_Visitor_Information visitorInfo: vmsVisitorInfoDao.findByVisitorInformationDetailAndVisitorActive(visitor, 1)) {
	        			if(visitorInfo.getVisitorActive().compareTo(1) == 0) {
	        				System.out.println("visitorCount: "+visitorCount);
	        				emailBody.append("			<tr>" + 
	        		        		"				<td style='padding: 10px 10px 10px 10px;'>" + 
	        		        		"					Visitor " + visitorCount + 
	        		        		"					<table class='stable' width='100%' style='background-color: #ededed ;'>" + 
	        		        		"						<tr>" + 
	        		        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		        		"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
	        		        		"								Name</p>" + 
	        		        		"							</td>" + 
	        		        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		        		"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitorInfo.getVisitorName()+"</p>" + 
	        		        		"							</td>" + 
	        		        		"						</tr>" + 
	        		        		"						<tr>" + 
	        		        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		        		"								<p style='margin: 0;padding: 10px 10px 10px 10px;'>" + 
	        		        		"								Email</p>" + 
	        		        		"							</td>" + 
	        		        		"							<td style='border-width: thin;border-spacing: 1px;border-style: ridge;border-color: #d9d9d9;'>" + 
	        		        		"								<p style='margin: 0;padding: 5px 0 5px 5px;'>"+visitorInfo.getVisitorEmail()+"</p>" + 
	        		        		"							</td>" + 
	        		        		"						</tr>" + 
	        		        		"					</table>" + 
	        		        		"				</td>" + 
	        		        		"			</tr>");
	        			}
	        			visitorCount++;
	        		}
	        		visitorCount = null;
	        		emailBody.append("			<tr>" + 
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
	        System.out.println("******** 3");
	        List<String> to = new ArrayList<String>();
	        if(request.getRequestURL().toString().contains("127.0.0.1") || request.getRequestURL().toString().contains("localhost")) {
	        	to.add(Common_Constants.toMailIdTesting);
	        } else {
	        	to.add(visitor.getHostName().getUserLoginId());
	        }
	        List<String> cc = new ArrayList<String>();
	        List<String> bcc = new ArrayList<String>();
	        mailService.sendEmailToCcAndBcc("Your visitor(s) from "+visitor.getVisitorCompanyName()+" has arrived", emailBody.toString(), to, cc, bcc);
	        to = null;cc = null;bcc = null;
	        System.out.println("******** 4");
	        visitor = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}