package com.anand.masters;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface M_User_Service {

	List<M_User> getUserList(HttpServletRequest request, Integer offset);

	M_User getUserInformationByUserName(String username);

	M_User getUserInformationForVimsRegistration(HttpServletRequest request);

	List<M_User> getUserByActiveStatus(Integer userActive);

	List<M_User> getActiveUserByRole(Integer userActive, String roleName);

	String getActiveUserByRoleInJson(Integer userActive, String roleName);
	
	List<M_User> getActiveUserByRoleInList(Integer userActive, String roleName,HttpServletRequest request);

	String getLineManager(HttpServletRequest request);

	List<M_User> getLineManagerList(HttpServletRequest request);

	String getPraac(HttpServletRequest request);

	List<M_User> getPraacList(HttpServletRequest request);

	List<M_User> getUserOfSameEntities();

	String saveUserDetails(HttpServletRequest request, M_User user) throws Exception;

	String updateUserOtp(HttpServletRequest request, M_User user,Integer otp) throws Exception;

	String saveUserDetailsV1(HttpServletRequest request, M_User user) throws Exception;

	String saveUserDetailsRegistration(HttpServletRequest request, M_User user) throws Exception;

	String saveUserDetailsRegistrationSso(HttpServletRequest request, M_User user) throws Exception;

	void sendRegistrationMail(HttpServletRequest request, M_User user);

	String getUserDetails(HttpServletRequest request);

	String checkUserExists(HttpServletRequest request);

	String verifyEmail(HttpServletRequest request) throws Exception;

	void sendVerificationMail(HttpServletRequest request);

	void resetLoginAttempts(String userLoginId);

	void incrementLoginCount(String userLoginId);

	List<String> getUserRolesByUserLoginId(String userLoginId);

	Boolean checkUserExists(String userEmailId);

	String getUserPassword(String userLoginId);

	boolean otpValidate(M_User currUser, Integer parameter);

	public String resetPassword(HttpServletRequest request);

	public List<M_Entity> getUserEntityMapForVimsRegistration(HttpServletRequest request);

	List<M_User> getUserByEntityId(Long mEntityId, HttpServletRequest request);
}
