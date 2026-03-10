package com.anand.vims;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.anand.masters.M_Department_Service;
import com.anand.masters.M_Designation_Service;
import com.anand.masters.M_Entity_Service;
import com.anand.masters.M_Role_Service;
import com.anand.masters.M_User;
import com.anand.masters.M_User_Service;

@Controller
public class VisitorManagementController {

	@Autowired private M_Role_Service mRoleService;
	@Autowired private VMS_Visitor_Service visitorService;
	@Autowired private VMS_Visitor_Information_Service vmsVisitorInformationService;
	@Autowired private VMS_M_Visitor_Type_Service vmsMVisitorTypeService;
	@Autowired private VMS_M_Visitor_Govt_Type_Service vmsMVisitorGovtTypeService;
	@Autowired private VMS_M_Visitor_Purpose_Service vmsMVisitorPurposeService;
	@Autowired private M_Entity_Service mEntityService;
	@Autowired private M_Designation_Service mDesignationService;
	@Autowired private M_Department_Service mDepartmentService;
	@Autowired private M_User_Service mUserService;

	@GetMapping("vims-user")
	public String user(@ModelAttribute("user") M_User user, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "vims-user")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** user - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/book-appointment";
			}
			roleCheckFlag = null;
			System.out.println("**** vims-user");
			model.addAttribute("userList", mUserService.getUserList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "vims/user";
	}

	@GetMapping("vims-registration")
	public String signup(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user, RedirectAttributes reAttr) {
		Integer roleCheckFlag = 0;
		if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "vims-registration")) == 0) {
			roleCheckFlag = null;
			System.out.println("**** user - not allowed to access the page");
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
			System.out.println("****");
			return "redirect:/master";
		}
		roleCheckFlag = null;
		model.addAttribute("activeChildEntityList", mEntityService.getActiveChildEntityByStatus(1));
		model.addAttribute("activeDesignationList", mDesignationService.getDesignationByActiveStatus(1));
		model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
		model.addAttribute("roleList", mRoleService.getRoleByActiveStatus(1));
		/*model.addAttribute("entityList", mEntityService.getActiveChildEntityForAppointmentBooking(1, request));*/
		model.addAttribute("entityList", mEntityService.getActiveChildEntityByStatus(1));
		if(request.getParameter("id") != null) {
			System.out.println("request.getParameter(\"id\"): "+request.getParameter("id"));
			model.addAttribute("user", mUserService.getUserInformationForVimsRegistration(request));
		}
		return "vims/vims-registration";
	}

	@PostMapping("vims-registration")
	public String vimRegistrationPost(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user, RedirectAttributes reAttr) {
		StringBuilder response = new StringBuilder();
		try {
			System.out.println("------------------");
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "vims-registration")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** user - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/book-appointment";
			}
			roleCheckFlag = null;
			System.out.println("------------------");
			response.append(mUserService.saveUserDetailsRegistration(request, user));
			if(response.toString().equalsIgnoreCase("add")) {
				//mUserService.sendRegistrationMail(request, user);
				/*reAttr.addFlashAttribute("regMsg", "Your registration is completed successfully.<br>Complete the registration using the link sent you for email verification.");*/
				reAttr.addFlashAttribute("regMsg", "Registration is complete.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if(response.toString().equalsIgnoreCase("edit")) {
				reAttr.addFlashAttribute("regMsg", "User Information Edited.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if(response.toString().contains("invalid-string")) {
				reAttr.addFlashAttribute("regMsg", "You entered invalid string value. Try again and put valid text values.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			} else {
				reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			}
		} catch(Exception e) {
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try after sometime.");
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			e.printStackTrace();
		}
		return "redirect:/vims-user";
	}

	@GetMapping("book-appointment")
    public String visitorForm(@ModelAttribute("visitor") VMS_Visitor visitor, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
        try {
            Integer roleCheckFlag = 0;
            if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "book-appointment")) == 0) {
                roleCheckFlag = null;
                System.out.println("**** book-appointment - not allowed to access the page");
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
                System.out.println("****");

                return "redirect:/master";
            }
            roleCheckFlag = null;
            System.out.println("**** book-appointment");
            model.addAttribute("visitorTypeList", vmsMVisitorTypeService.getVisitorTypeByActiveStatus(1));
            model.addAttribute("visitorPurposeList", vmsMVisitorPurposeService.getVisitorPurposeByActiveStatus(1));
            model.addAttribute("childEntityList", mEntityService.getActiveChildEntityForAppointmentBooking(1,request));
            SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat formatTime = new SimpleDateFormat("hh:mm a");
            if(request.getParameter("id") != null) {
            	visitor = visitorService.getAppointmentInformationUsingId(request);
            	visitor.setVisitorTypeTemp(visitor.getMVisitorType().getMVisitorTypeId());
            	visitor.setVisitorPurposeTemp(visitor.getMVisitorPurpose().getMVisitorPurposeId());
            	visitor.setVisitingLocationTemp(visitor.getVisitingLocation().getmEntityId());
            	visitor.setVisitorPlantEntry(visitor.getVisitorPlantEntry());
            	visitor.setHostNameTemp(visitor.getHostName().getmUserId());
            	visitor.setMeetingStartDateTemp(formatDate.format(visitor.getMeetingDate()));
            	visitor.setMeetingEndDateTemp(formatDate.format(visitor.getVisitorAllowedUntil()));
            	visitor.setMeetingStartTimeTemp(formatTime.format(visitor.getMeetingDate()));
            	visitor.setMeetingEndTimeTemp(formatTime.format(visitor.getVisitorAllowedUntil()));
            	model.addAttribute("userListForEditAppointment",mUserService.getUserByEntityId(visitor.getVisitingLocation().getmEntityId(), request));
            	model.addAttribute("visitor", visitor);
            } else {
            	Date today = new Date();
                visitor.setMeetingStartDateTemp(formatDate.format(today));
            	visitor.setMeetingEndDateTemp(formatDate.format(today));
            	visitor.setMeetingStartTimeTemp(formatTime.format(today));
            	visitor.setMeetingEndTimeTemp(formatTime.format(today));
                today = null;
            }
            formatTime = null; formatDate = null;
            System.out.println("****");
        } catch(Exception e) {
            e.printStackTrace();
        }
        return "vims/book-appointment";
    }

	@PostMapping("book-appointment")
    public String visitorForm1(@ModelAttribute("visitor") VMS_Visitor visitor, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
        try {
            Integer roleCheckFlag = 0;
            if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "book-appointment")) == 0) {
                roleCheckFlag = null;
                System.out.println("**** book-appointment - not allowed to access the page");
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
                System.out.println("****");
                return "redirect:/master";
            }
            roleCheckFlag = null;
            System.out.println("**** book-appointment post");
            StringBuilder response = new StringBuilder(visitorService.saveVisitorDetails(request, visitor));
            reAttr.addFlashAttribute("css", "sequence-bg-5");
            if(response.toString().contains("add") || response.toString().contains("edit")) {
            	visitorService.sendVisitingInformationEmail(Long.parseLong(response.toString().split("-")[1]), request);
            }
            if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Appointment booked successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Appointment edited successfully.");
			} else if(response.toString().contains("noChange")) {
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
			}
            System.out.println("****");
        } catch(Exception e) {
            e.printStackTrace();
        }
        return "redirect:/list-appointment";
    }

	@GetMapping("visitor-type")
	public String app(@ModelAttribute("visitorType") VMS_M_Visitor_Type visitorType, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-type")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app - not allowed to access the page");
				reAttr.addFlashAttribute("css", "danger sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/visitor-type";
			}
			roleCheckFlag = null;
			System.out.println("**** app");
			model.addAttribute("visitorTypeList", vmsMVisitorTypeService.getVisitorTypeList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "vims/visitor-type";
	}

	@PostMapping("visitor-type")
	public String appPost(@ModelAttribute("visitorType") VMS_M_Visitor_Type visitorType, HttpServletRequest request, 
			Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-type")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/visitor-type";
			}
			roleCheckFlag = null;
			System.out.println("**** app post");
			StringBuilder response = new StringBuilder();
			response.append(vmsMVisitorTypeService.saveVisitorTypeDetails(request, visitorType));
			System.out.println(response.toString()+"---");
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Visitor Type information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Visitor Type information edited successfully.");
			} else if(response.toString().contains("noChange")) {
				reAttr.addFlashAttribute("css", "sequence-bg-2");
				reAttr.addFlashAttribute("regMsg", "There were no changes in the values, hence the changes were not saved.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("visitorTypeList", vmsMVisitorTypeService.getVisitorTypeList(request, 0));
				model.addAttribute("visitorType", visitorType);
				if(visitorType.getMVisitorTypeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "vims/visitor-type";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("visitorTypeList", vmsMVisitorTypeService.getVisitorTypeList(request, 0));
				model.addAttribute("visitorType", visitorType);
				if(visitorType.getMVisitorTypeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Visitor Type alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Visitor Type alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "vims/visitor-type";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/visitor-type";
	}

	@GetMapping("visitor-govt-type")
	public String app(@ModelAttribute("visitorType") VMS_M_Visitor_Govt_Type visitorType, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-type")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app - not allowed to access the page");
				reAttr.addFlashAttribute("css", "danger sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/visitor-type";
			}
			roleCheckFlag = null;
			System.out.println("**** app");
			model.addAttribute("visitorTypeList", vmsMVisitorGovtTypeService.getVisitorTypeList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "vims/visitor-govt-type";
	}

	@PostMapping("visitor-govt-type")
	public String visitorGovtPost(@ModelAttribute("visitorType") VMS_M_Visitor_Govt_Type visitorType, HttpServletRequest request, 
			Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-type")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** visitor-govt-type Post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/visitor-type";
			}
			roleCheckFlag = null;
			System.out.println("**** app post");
			StringBuilder response = new StringBuilder();
			response.append(vmsMVisitorGovtTypeService.saveVisitorTypeDetails(request, visitorType));
			System.out.println(response.toString()+"---");
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Visitor Government ID Type information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Visitor Government ID Type information edited successfully.");
			} else if(response.toString().contains("noChange")) {
				reAttr.addFlashAttribute("css", "sequence-bg-2");
				reAttr.addFlashAttribute("regMsg", "There were no changes in the values, hence the changes were not saved.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("visitorTypeList", vmsMVisitorGovtTypeService.getVisitorTypeList(request, 0));
				model.addAttribute("visitorType", visitorType);
				if(visitorType.getMVisitorTypeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "vims/visitor-govt-type";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("visitorTypeList", vmsMVisitorGovtTypeService.getVisitorTypeList(request, 0));
				model.addAttribute("visitorType", visitorType);
				if(visitorType.getMVisitorTypeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Visitor Government ID Type alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Visitor Government ID Type alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "vims/visitor-govt-type";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/visitor-govt-type";
	}

	@GetMapping("visitor-purpose")
	public String app(@ModelAttribute("visitorPurpose") VMS_M_Visitor_Purpose visitorPurpose, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-purpose")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app - not allowed to access the page");
				reAttr.addFlashAttribute("css", "danger sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/visitor-purpose";
			}
			roleCheckFlag = null;
			System.out.println("**** app");
			model.addAttribute("visitorPurposeList", vmsMVisitorPurposeService.getVisitorPurposeList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "vims/visitor-purpose";
	}

	@PostMapping("visitor-purpose")
	public String appPost(@ModelAttribute("visitorPurpose") VMS_M_Visitor_Purpose visitorPurpose, HttpServletRequest request, 
			Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "app")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/visitor-purpose";
			}
			roleCheckFlag = null;
			System.out.println("**** app post");
			StringBuilder response = new StringBuilder();
			response.append(vmsMVisitorPurposeService.saveVisitorPurposeDetails(request, visitorPurpose));
			System.out.println(response.toString()+"---");
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Visitor Purpose information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Visitor Purpose information edited successfully.");
			} else if(response.toString().contains("noChange")) {
				reAttr.addFlashAttribute("css", "sequence-bg-2");
				reAttr.addFlashAttribute("regMsg", "There were no changes in the values, hence the changes were not saved.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("visitorPurposeList", vmsMVisitorPurposeService.getVisitorPurposeList(request, 0));
				model.addAttribute("visitorPurpose", visitorPurpose);
				if(visitorPurpose.getMVisitorPurposeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "vims/visitor-purpose";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("visitorPurposeList", vmsMVisitorPurposeService.getVisitorPurposeList(request, 0));
				model.addAttribute("visitorPurpose", visitorPurpose);
				if(visitorPurpose.getMVisitorPurposeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Visitor Purpose alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Visitor Purpose alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "vims/visitor-purpose";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/visitor-purpose";
	}

	@GetMapping("list-appointment")
	public String listAppointments(@ModelAttribute("visitor") VMS_Visitor visitor, HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if (roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "list-appointment")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** list-appointment - not allowed to access the page");
				reAttr.addFlashAttribute("css", "danger sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				roleCheckFlag = null;
				return "redirect:/master";
			}
			roleCheckFlag = null;
			List<VMS_Visitor> visitorList = visitorService.getVisitorList(visitor, request);
			model.addAttribute("visitorList", visitorList);
			if(visitorList.size() != 0) {
				visitor.setVisitingLocationTemp(visitorList.get(0).getVisitingLocation().getmEntityId());
				model.addAttribute("userList", mUserService.getUserByEntityId(visitorList.get(0).getVisitingLocation().getmEntityId(), request));
			}
			model.addAttribute("visitor", visitor);
			model.addAttribute("userEntityMap", visitorService.getUserEntityForMapping(request));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "vims/list-appointment";
	}

	@PostMapping("list-appointment")
	public String listAppointmentsPost(@ModelAttribute("visitor") VMS_Visitor visitor, HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if (roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "list-appointment")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** list-appointment - not allowed to access the page");
				reAttr.addFlashAttribute("css", "danger sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				roleCheckFlag = null;
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println(visitor.getVisitingLocationTemp()+" - "+visitor.getMeetingStartDateTemp());
			model.addAttribute("userList", mUserService.getUserByEntityId(visitor.getVisitingLocationTemp(), request));
			model.addAttribute("visitorList", visitorService.getVisitorList(visitor, request));
			model.addAttribute("userEntityMap", visitorService.getUserEntityForMapping(request));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "vims/list-appointment";
	}

	@GetMapping("print")
	String Print(HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
		try {
			model.addAttribute("visitor", visitorService.getAppointmentInformationUsingId(request));
			return "vims/print-visitor-info";
		} catch (Exception e){
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "danger sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
			return "redirect:/list-booking";
		}
	}

	@GetMapping("visitor-information")
	public String visitorInfoGet(@ModelAttribute("visitor") VMS_Visitor visitor,
			HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if (roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-information")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** visitor-information - not allowed to access the page");
				reAttr.addFlashAttribute("css", "danger sequence-bg-1");
				reAttr.addFlashAttribute("regMsg",
						"You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** Visitor Information - GET ****");
			if (request.getParameter("id") != null) {
				System.out.println("Came here --------------");
				/*model.addAttribute("visitorInformation", vmsVisitorInformationService.getVisitorInformation(request));*/
				model.addAttribute("visitor", visitorService.getAppointmentInformationUsingId(request));
				model.addAttribute("govtIdTypes", vmsMVisitorGovtTypeService.getVisitorTypeByActiveStatus(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "vims/visitor-information";
	}

	@PostMapping("visitor-information")
	public String visitorInfoPost(@ModelAttribute("visitor") VMS_Visitor visitor,
			HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if (roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-information")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** visitor-information - not allowed to access the page");
				reAttr.addFlashAttribute("css", "danger sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** visitor-information - POST ****");
			Long checkForHostNotification = visitor.getVisitorInformationList().stream().filter(visitorInfo -> visitorInfo.getVisitorInformationId() != null).count();
			StringBuilder response = new StringBuilder(vmsVisitorInformationService.saveVisitorInfoDetails(request, visitor));
			System.out.println(checkForHostNotification+" : checkForHostNotification");
			if(checkForHostNotification.compareTo(0l) == 0) {
				System.out.println(checkForHostNotification+" : checkForHostNotification 2");
				visitorService.sendNotificationToHost(visitor.getVisitorId(), request);
			}
			System.out.println(checkForHostNotification+" : checkForHostNotification 3");
			if(response.toString().equalsIgnoreCase("error")) {
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "Error in your input, verify the input and try again.");
			} else if(response.toString().equalsIgnoreCase("edit")) {
				reAttr.addFlashAttribute("css", "sequence-bg-5");
				reAttr.addFlashAttribute("regMsg", "Visitor Information added successfully.");
			} else {
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/visitor-information?id="+visitor.getVisitorId();
	}

	@GetMapping("visitor-time-out")
	public String visitorTimeOutGet(@ModelAttribute("visitorInfo") VMS_Visitor_Information visitorInfo, HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
	    try {
	       Integer roleCheckFlag = 0;
	       if (roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-time-out")) == 0) {
	          roleCheckFlag = null;
	          System.out.println("**** visitor-time-out - not allowed to access the page");
	          reAttr.addFlashAttribute("css", "danger sequence-bg-1");
	          reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
	          System.out.println("****");
	          return "redirect:/master";
	       }
	       roleCheckFlag = null;
	       System.out.println("**** Visitor-Time-Out List - GET ****");
	       model.addAttribute("today", LocalDate.now().format(DateTimeFormatter.ISO_DATE));
	       model.addAttribute("today1", new Date());
	       System.out.println("111");
	       List<VMS_Visitor_Information> visitorList = vmsVisitorInformationService.getVisitorInfoList(visitorInfo, request, 1); // Pass with getFlag raised to indicate Get Mapping
	       System.out.println("111 a");
	       model.addAttribute("visitorInformationList", visitorList);
	       if(visitorList.size() != 0) {
	    	   visitorInfo.getVisitorInformationDetail().setVisitingLocationTemp(visitorList.get(0).getVisitorInformationDetail().getVisitingLocation().getmEntityId());
		       model.addAttribute("userList", mUserService.getUserByEntityId(visitorList.get(0).getVisitorInformationDetail().getVisitingLocation().getmEntityId(), request));
	       }
	       model.addAttribute("visitorInfo", visitorInfo);
	       model.addAttribute("userEntityMap", visitorService.getUserEntityForMapping(request));
	       System.out.println("**************************");

	    } catch (Exception e) {
	       e.printStackTrace();
	    }
	    return "vims/visitor-time-out";
	}

	@PostMapping("visitor-time-out")
	public String visitorTimeOutPost(@ModelAttribute("visitorInfo") VMS_Visitor_Information visitorInfo, HttpServletRequest request, Model model, RedirectAttributes reAttr) throws Exception {
	    try {
	       Integer roleCheckFlag = 0;
	       if (roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "visitor-time-out")) == 0) {
	          roleCheckFlag = null;
	          System.out.println("**** visitor-time-out - not allowed to access the page");
	          reAttr.addFlashAttribute("css", "danger sequence-bg-1");
	          reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
	          System.out.println("****");
	          return "redirect:/master";
	       }
	       roleCheckFlag = null;
	       System.out.println("**** Visitor-Time-Out List - POST ****");
	       model.addAttribute("today", LocalDate.now().format(DateTimeFormatter.ISO_DATE));
	       System.out.println(visitorInfo.getVisitorInformationDetail().getVisitingLocationTemp()+" - "+visitorInfo.getVisitorInformationDetail().getMeetingStartDateTemp()+" - "+ visitorInfo.getVisitorInformationDetail().getHostNameTemp());
	       model.addAttribute("userList", mUserService.getUserByEntityId(visitorInfo.getVisitorInformationDetail().getVisitingLocationTemp(), request));
	       model.addAttribute("visitorInformationList", vmsVisitorInformationService.getVisitorInfoList(visitorInfo, request,0)); // Pass with getFlag down to Indicate Post mapping
	       model.addAttribute("userEntityMap", visitorService.getUserEntityForMapping(request));
	    } catch (Exception e) {
	       e.printStackTrace();
	    }
	    return "vims/visitor-time-out";
	}
}