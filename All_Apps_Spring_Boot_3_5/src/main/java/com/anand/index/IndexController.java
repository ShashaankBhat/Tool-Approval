/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Sheshadhri Iyer
 */
package com.anand.index;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.anand.masters.M_App_Dump_Service;
import com.anand.masters.M_Department_Service;
import com.anand.masters.M_Designation_Service;
import com.anand.masters.M_Entity_Service;
import com.anand.masters.M_User;
import com.anand.masters.M_User_App_Map;
import com.anand.masters.M_User_Dao;
import com.anand.masters.M_User_Role_Map;
import com.anand.masters.M_User_Service;

@Controller
public class IndexController {

	@Autowired private M_User_Dao userMasterDao;
	@Autowired private M_Department_Service mDepartmentService;
	@Autowired private M_Designation_Service mDesignationService;
	@Autowired private M_Entity_Service mEntityService;
	@Autowired private M_User_Service mUserService;
	@Autowired private M_App_Dump_Service mAppDumpService;

	public void invalidateSession(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		session.setAttribute("itAdmin", 0);

		session.setAttribute("ctProcessOwner", 0);
		session.setAttribute("ctSupervisor", 0);
		session.setAttribute("ctAdmin", 0);
		session.setAttribute("ctCoachee", 0);
		session.setAttribute("ctCoach", 0);

		session.setAttribute("emcProcessOwner", 0);
		session.setAttribute("emcSupervisor", 0);
		session.setAttribute("emcAdmin", 0);
		session.setAttribute("emcMentee", 0);
		session.setAttribute("emcMentor", 0);
		
		session.setAttribute("vimsReception", 0);
		session.setAttribute("vimsAdmin", 0);
		
		session.setAttribute("taAdmin", 0);
		session.setAttribute("taApprover", 0);
		session.setAttribute("taCommodityManager", 0);
	}

	public void setUserValuesInSession(String userEmail, HttpServletRequest request) {
		try {
			System.out.println("------\nCame here to set user values in session");
			HttpSession session = request.getSession(true);
			System.out.println(userEmail+" :userEmail");
			M_User currentUser = userMasterDao.findByUserLoginId(userEmail);
			session.setAttribute("employee", 0);
			session.setAttribute("itAdmin", 0);

			session.setAttribute("ctProcessOwner", 0);
			session.setAttribute("ctSupervisor", 0);
			session.setAttribute("ctAdmin", 0);
			session.setAttribute("ctCoachee", 0);
			session.setAttribute("ctCoach", 0);

			session.setAttribute("emcProcessOwner", 0);
			session.setAttribute("emcSupervisor", 0);
			session.setAttribute("emcAdmin", 0);
			session.setAttribute("emcMentee", 0);
			session.setAttribute("emcMentor", 0);
			
			session.setAttribute("vimsReception", 0);
			session.setAttribute("vimsAdmin", 0);
			
			session.setAttribute("taAdmin", 0);
			session.setAttribute("taApprover", 0);
			session.setAttribute("taCommodityManager", 0);

			for (M_User_Role_Map object : currentUser.getUserInfoForRole()) {
				if (object.getUserRoleActive().compareTo(1) == 0) {
					System.out.println(object.getRoleInfoForUsers().getRoleName());
					session.setAttribute("employee", 1);
					if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("IT Admin")) {
						session.setAttribute("itAdmin", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("ACT Process Owner")) {
						session.setAttribute("ctProcessOwner", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("ACT Supervisor")) {
						session.setAttribute("ctSupervisor", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("ACT Admin")) {
						session.setAttribute("ctAdmin", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("ACT Coachee")) {
						session.setAttribute("ctCoachee", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("ACT Coach")) {
						session.setAttribute("ctCoach", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("EMC Process Owner")) {
						session.setAttribute("emcProcessOwner", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("EMC Supervisor")) {
						session.setAttribute("emcSupervisor", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("EMC Admin")) {
						session.setAttribute("emcAdmin", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("EMC Mentee")) {
						session.setAttribute("emcMentee", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("EMC Mentor")) {
						session.setAttribute("emcMentor", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("VIMS Reception")) {
						session.setAttribute("vimsReception", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("VIMS Admin")) {
						session.setAttribute("vimsAdmin", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("TA Admin")) {
						session.setAttribute("taAdmin", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("TA Approver")) {
						session.setAttribute("taApprover", 1);
					} else if (object.getRoleInfoForUsers().getRoleName().equalsIgnoreCase("TA Commodity Manager")) {
						session.setAttribute("taCommodityManager", 1);
					}
				}
			}
			List<M_User_App_Map> userAppList = new ArrayList<M_User_App_Map>();
			userAppList.addAll(currentUser.getUserInfoForApp());
			session.setAttribute("sessionUserInfo", currentUser);
			Collections.sort(userAppList);
			session.setAttribute("sessionUserApps", userAppList);
			System.out.println("------");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/")
	public String slashOrIndex(HttpServletRequest request, Model model) throws Exception {
		System.out.println("**** /");
		System.out.println("****");
		return "login_page";
	}

	@GetMapping("login")
	public String anandGroupIndialogin(HttpServletRequest request, Model model, RedirectAttributes reAttr)
			throws Exception {
		System.out.println("**** login");
		if (request.getParameter("error") != null) {
			model.addAttribute("regMsg_login", "Invalid Credentials.");
			model.addAttribute("css_login", "sequence-bg-1");
		}
		System.out.println(request.getParameter("logout"));
		if (request.getParameter("logout") != null && request.getParameter("logout").equalsIgnoreCase("sessionout")) {
			invalidateSession(request);
			return "sessionTimeout";
		} else if (request.getParameter("logout") != null && !request.getParameter("logout").isEmpty()) {
			model.addAttribute("regMsg", "Logged out successfully.");
			model.addAttribute("css", "sequence-bg-5");
			invalidateSession(request);
		}
		if (request.getParameter("verifyEmail") != null) {
			System.out.println("Came here");
			StringBuilder response = new StringBuilder();
			response.append("" + mUserService.verifyEmail(request));
			System.out.println(response.toString());
			if (response.toString().equalsIgnoreCase("verified")) {
				mUserService.sendVerificationMail(request);
				reAttr.addFlashAttribute("regMsg", "Email Verification Successfully Completed.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if (response.toString().equalsIgnoreCase("alreadyVerified")) {
				reAttr.addFlashAttribute("regMsg", "Email verificaiton already done.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else {
				reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			}
			return "redirect:/login";
		}
		System.out.println("****");
		return "login_page";
	}

	@PostMapping("login")
	public String loginPost(HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
		System.out.println("**** login post");
		if (request.getParameter("error") != null) {
			String errorMessage = request.getAttribute("regMsg_login").toString();
			model.addAttribute("regMsg_login", errorMessage);
			model.addAttribute("css_login", "sequence-bg-1");
		}
		if (request.getParameter("logout") != null && request.getParameter("logout").equalsIgnoreCase("sessionout")) {
			return "sessionTimeout";
		} else if (request.getParameter("logout") != null && !request.getParameter("logout").isEmpty()) {
			model.addAttribute("regMsg", "Logged out successfully.");
			model.addAttribute("css", "sequence-bg-5");
		}
		System.out.println("****");
		return "login_page";
	}

	@GetMapping("app-company-mid")
	public String appcompanymid(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user,
			RedirectAttributes reAttr) {
		user.setUserLoginId(request.getParameter("email"));
		user.setUserFirstName(request.getParameter("firstName"));
		user.setUserLastName(request.getParameter("lastName"));
		System.out.println("app-company-mid");
		System.out.println(request.getParameter("email"));
		System.out.println(request.getParameter("firstName"));
		System.out.println(request.getParameter("lastName"));
		System.out.println("--" + request.getParameter("companyName"));
		reAttr.addFlashAttribute("email", request.getParameter("email"));
		reAttr.addFlashAttribute("firstName", request.getParameter("firstName"));
		reAttr.addFlashAttribute("lastName", request.getParameter("lastName"));
		reAttr.addFlashAttribute("companyName", request.getParameter("companyName"));
		return "redirect:/app-company";
	}

	@GetMapping("app-company")
	public String companySelection(HttpServletRequest request, Model model) throws Exception {
		System.out.println("**** /");
		System.out.println((String) model.asMap().get("companyName"));
		if ((String) model.asMap().get("companyName") != null && (String) model.asMap().get("companyName") != "") {
			model.addAttribute("entityAcronymnForDisplay", (String) model.asMap().get("companyName"));
			model.addAttribute("userEmailId", (String) model.asMap().get("email"));
			model.addAttribute("commonApp", mAppDumpService.getAppDumpListByEntity(-1l));
			model.addAttribute("companyApps",
					mAppDumpService.getAppDumpListByEntityName("" + (String) model.asMap().get("companyName")));
			System.out.println("****");
			return "company-apps";
		} else {
			System.out.println("****: " + request.getSession(true).getAttribute("sessionUserInfo"));
			if (request.getSession(true).getAttribute("sessionUserInfo") != null) {
				return "redirect:/logout";
			} else {
				return "redirect:/login";
			}
		}
	}

	@GetMapping("main")
	public String main(HttpServletRequest request, Model model) throws Exception {
		try {
			System.out.println("**** main");
			setUserValuesInSession(SecurityContextHolder.getContext().getAuthentication().getName(), request);
			M_User currUser = (M_User) request.getSession(true).getAttribute("sessionUserInfo");
			/*if(!request.getRequestURL().toString().contains("localhost") || !request.getRequestURL().toString().contains("uat")) {
				String to = currUser.getUserLoginId();
				List<String> toList = Collections.singletonList(to);
				// Generate 4-digit OTP
				Random random = new Random();
				int otp = 100000 + random.nextInt(900000); // Range: 100000 to 999999 (6-digit)
				mUserService.updateUserOtp(request, currUser, otp);
				String body = "OTP " + otp;
				mailService.sendToCcBccMail("OTP", body, toList, null, null);
				body = null;
			}*/
			if (currUser.getUserForgotPasswordToken() != null && !currUser.getUserForgotPasswordToken().isEmpty()) {
				currUser = null;
				return "redirect:/resetPassword";
			}
			currUser = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*if(request.getRequestURL().toString().contains("localhost") || request.getRequestURL().toString().contains("uat")) {
			return "redirect:dashboard";
		} else {
			return "redirect:otp-verify";
		}*/
		return "redirect:dashboard";
	}

	@GetMapping("main-sso")
	public String mainSso(HttpServletRequest request, Model model) throws Exception {
		try {
			System.out.println("**** main-sso");
			System.out.println(SecurityContextHolder.getContext().getAuthentication().getName());
			setUserValuesInSession(SecurityContextHolder.getContext().getAuthentication().getName(), request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:dashboard";
	}

	/**
	 * Basic Landing Tomcat Page
	 * 
	 * @author Sheshadhri Iyer
	 */
	@GetMapping("dashboard")
	public String dashboard(HttpServletRequest request, Model model) throws Exception {
		try {
			System.out.println("**** dashboard");
			setUserValuesInSession(SecurityContextHolder.getContext().getAuthentication().getName(), request);
			System.out.println("****");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "dashboard";
	
	}

	@GetMapping("otp-verify")
	public String otpVerify(HttpServletRequest request, Model model) throws Exception {
		try {
			System.out.println("**** dashboard");
			setUserValuesInSession(SecurityContextHolder.getContext().getAuthentication().getName(), request);
			System.out.println("****");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "otp-verify";
		/* return "dashboard_v2"; */
	}

	@PostMapping("otp-validate")
	public String otpValidate(HttpServletRequest request, Model model) throws Exception {
		try {

			M_User currUser = (M_User) request.getSession(true).getAttribute("sessionUserInfo");
			//String user = currUser.getUserLoginId();
			Integer requestOtp = Integer.parseInt(request.getParameter("otp"));
			System.out.println("requestOtp===="+requestOtp);
			boolean flag=mUserService.otpValidate(currUser, requestOtp);
			if(flag){
				return "redirect:dashboard";
			}else{
				model.addAttribute("regMsg_login", "Invalid OTP");
			}
			System.out.println("rr====" + flag);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "otp-verify";
		/* return "dashboard_v2"; */
	}

	@GetMapping("logout")
	public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("**** logout");
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if (auth != null) {
				new SecurityContextLogoutHandler().logout(request, response, auth);
			}
			System.out.println("****");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/login?logout=out";
	}

	@GetMapping("deny")
	public String deny(HttpServletRequest request, Model model) throws Exception {
		return "denyPage";
	}

	@GetMapping("session-timeout")
	public String session_timeout(HttpServletRequest request, Model model) throws Exception {
		return "sessionTimeout";
	}

	@GetMapping("signup-verification")
	public String signupVerification(HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			String response = mUserService.verifyEmail(request);
			if (response.contains("alreadyverified")) {
				reAttr.addFlashAttribute("regMsg", "Your account was alredy verified.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if (response.contains("verified")) {
				reAttr.addFlashAttribute("regMsg", "Email Verification is successfully completed.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else {
				reAttr.addFlashAttribute("regMsg",
						"Something went wrong while verifying the user, try again aftersometime.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/login";
	}

	@GetMapping("forgot-password")
	public String forgot_password(HttpServletRequest request, Model model) {
		System.out.println("Came here");
		return "forgot-password";
	}

	@PostMapping("forgot-password")
	public String forgot_password_post(HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		StringBuilder response = new StringBuilder();
		try {
			response.append(mUserService.resetPassword(request));
			if(response.toString().contains("done")) {
				reAttr.addFlashAttribute("regMsg","Reset password is successful and sent to your email-id.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
				response.setLength(0);
				response.append("redirect:/login");
			} else {
				model.addAttribute("regMsg", "Something went wrong, try again.");
				model.addAttribute("css", "sequence-bg-1");
				response.setLength(0);
				response.append("forgot-password");
			}
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("regMsg", "Something went wrong, try again.");
			model.addAttribute("css", "sequence-bg-1");
			model.addAttribute("errorMail", request.getParameter("email"));
			response.setLength(0);
			response.append("forgot-password");
		}
		return response.toString();
	}
	 

	@GetMapping("resetPassword") // NOSONAR
	public String resetPassword(HttpServletRequest request, Model model) throws Exception {
		try {
			model.addAttribute("userInfo", (M_User) request.getSession(true).getAttribute("sessionUserInfo"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "reset-password";
	}

	@GetMapping("sign-up-mid")
	public String signupmid(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user,
			RedirectAttributes reAttr) {
		user.setUserLoginId(request.getParameter("email"));
		user.setUserFirstName(request.getParameter("firstName"));
		user.setUserLastName(request.getParameter("lastName"));
		System.out.println("Sign-up-mid");
		System.out.println(request.getParameter("email"));
		System.out.println(request.getParameter("firstName"));
		System.out.println(request.getParameter("lastName"));
		reAttr.addFlashAttribute("email", request.getParameter("email"));
		reAttr.addFlashAttribute("firstName", request.getParameter("firstName"));
		reAttr.addFlashAttribute("lastName", request.getParameter("lastName"));
		return "redirect:/sign-up";
	}

	@GetMapping("sign-up")
	public String signup(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user,
			RedirectAttributes reAttr) {
		model.addAttribute("activeChildEntityList", mEntityService.getActiveChildEntityByStatus(1));
		model.addAttribute("activeDesignationList", mDesignationService.getDesignationByActiveStatus(1));
		model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
		model.addAttribute("activeUsers", mUserService.getUserByActiveStatus(1));
		return "sign-up";
	}

	@PostMapping("sign-up")
	public String signupPost(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user,
			RedirectAttributes reAttr) {
		StringBuilder response = new StringBuilder();
		try {
			response.append(mUserService.saveUserDetailsRegistrationSso(request, user));
			if (response.toString().equalsIgnoreCase("add")) {
				reAttr.addFlashAttribute("regMsg_login", "Registration is completed.");
				reAttr.addFlashAttribute("css_login", " sequence-bg-5");
				return "redirect:/logout";
			} else if (response.toString().equalsIgnoreCase("error")) {
				reAttr.addFlashAttribute("regMsg_login", "Something went wrong, try again later");
				reAttr.addFlashAttribute("css_login", " sequence-bg-1");
				return "redirect:/login";
			} else {
				reAttr.addFlashAttribute("regMsg_login", "Something went wrong, try again after sometime.");
				reAttr.addFlashAttribute("css_login", " sequence-bg-1");
				return "redirect:/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("activeChildEntityList", mEntityService.getActiveChildEntityByStatus(1));
		model.addAttribute("activeDesignationList", mDesignationService.getDesignationByActiveStatus(1));
		model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
		model.addAttribute("activeUsers", mUserService.getUserByActiveStatus(1));
		return "masters/sign-up";
	}
}