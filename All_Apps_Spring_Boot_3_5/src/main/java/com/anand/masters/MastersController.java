package com.anand.masters;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MastersController {

	@Autowired private M_Department_Service mDepartmentService;
	@Autowired private M_Designation_Service mDesignationService;
	@Autowired private M_Location_Service mLocationService;
	@Autowired private M_Zone_Service mZoneService;
	@Autowired private M_Mail_Configuration_Service mMailConfigurationService;
	@Autowired private M_Role_Service mRoleService;
	@Autowired private M_Entity_Service mEntityService;
	@Autowired private M_User_Service mUserService;
	@Autowired private M_App_Service mAppService;
	@Autowired private M_App_Dump_Service mAppDumpService;
	@Autowired private M_Member_Level_Service mMemberLevelService;

	/*@ModelAttribute("activeZoneList")
	public List<M_Zone> activeZoneList() { return mZoneService.getZoneByActiveStatus(1); }

	@ModelAttribute("activeLocationList")
	public List<M_Location> activeLocationList() { return mLocationService.getLocationByActiveStatus(1); }

	@ModelAttribute("activeParentEntityList")
	public List<M_Entity> activeParentEntityList() { return mEntityService.getActiveParentEntityByStatus(1); }

	@ModelAttribute("activeDesignationList")
	public List<M_Designation> activeDesignationList() { return mDesignationService.getDesignationByActiveStatus(1); }

	@ModelAttribute("activeUsers")
	public List<M_User> activeUsers() { return mUserService.getUserByActiveStatus(1); }

	@ModelAttribute("roleList")
	public List<M_Role> roleList() { return mRoleService.getRoleByActiveStatus(1); }*/

	@GetMapping("master")
	public String master(HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "master")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** master - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/dashboard";
			}
			roleCheckFlag = null;
			System.out.println("**** master");
			model.addAttribute("activeEntity", mEntityService.getEntityByActiveStatus(1).size());
			model.addAttribute("inActiveEntity", mEntityService.getEntityByActiveStatus(0).size());
			model.addAttribute("activeLocation", mLocationService.getLocationByActiveStatus(1).size());
			model.addAttribute("inActiveLocation", mLocationService.getLocationByActiveStatus(0).size());
			model.addAttribute("activeZone", mZoneService.getZoneByActiveStatus(1).size());
			model.addAttribute("inActiveZone", mZoneService.getZoneByActiveStatus(0).size());
			model.addAttribute("activeUsers", mUserService.getUserByActiveStatus(1).size());
			model.addAttribute("inActiveUsers", mUserService.getUserByActiveStatus(0).size());
			model.addAttribute("activeDepartments", mDepartmentService.getDepartmentByActiveStatus(1).size());
			model.addAttribute("inActiveDepartments", mDepartmentService.getDepartmentByActiveStatus(0).size());
			model.addAttribute("activeRoles", mRoleService.getRoleByActiveStatus(1).size());
			model.addAttribute("inActiveRoles", mRoleService.getRoleByActiveStatus(0).size());
			model.addAttribute("activeDesignation", mDesignationService.getDesignationByActiveStatus(1).size());
			model.addAttribute("inActiveDesignation", mDesignationService.getDesignationByActiveStatus(0).size());
			model.addAttribute("activeMailConfiguration", mMailConfigurationService.getMailConfigurationByActiveStatus(1).size());
			model.addAttribute("inActiveMailConfiguration", mMailConfigurationService.getMailConfigurationByActiveStatus(0).size());
			model.addAttribute("activeApps", mAppService.getAppByActiveStatus(1).size());
			model.addAttribute("inActiveApps", mAppService.getAppByActiveStatus(0).size());
			model.addAttribute("activeMemberLevels", mMemberLevelService.getMemberLevelByActiveStatus(1).size());
			model.addAttribute("inActiveMemberLevels", mMemberLevelService.getMemberLevelByActiveStatus(0).size());
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/master_dashboard";
	}

	@GetMapping("app")
	public String app(@ModelAttribute("app") M_App app, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "app")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** app");
			model.addAttribute("appList", mAppService.getAppList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/app";
	}

	@PostMapping("app")
	public String appPost(@ModelAttribute("app") M_App app, 
			@ModelAttribute("appDump") M_App appDump, HttpServletRequest request, 
			Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "app")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** app post");
			StringBuilder response = new StringBuilder();
			response.append(mAppService.saveAppDetails(request, app));
			System.out.println(response.toString()+"---");
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "App information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "App information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("appList", mAppService.getAppList(request, 0));
				model.addAttribute("app", app);
				if(app.getmAppId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/app";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("appList", mAppService.getAppList(request, 0));
				model.addAttribute("app", app);
				if(app.getmAppId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "App Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "App Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/app";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/app";
	}

	@GetMapping("app-dump")
	public String appDump(@ModelAttribute("app") M_App app, 
			@ModelAttribute("appDump") M_App_Dump appDump,
			HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "app-dump")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app dump - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** app");
			model.addAttribute("appDumpList", mAppDumpService.getAppDumpList(request, 0));
			model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/app-dump";
	}

	@PostMapping("app-dump")
	public String appDumpPost( @ModelAttribute("appDump") M_App_Dump appDump, HttpServletRequest request, 
			Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "app-dump")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** app post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** app -dump post");
			StringBuilder response = new StringBuilder();
			response.append(mAppDumpService.saveAppDumpDetails(request, appDump));
			System.out.println(response.toString()+"---");
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "App Dump information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "App Dump information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("appDumpList", mAppDumpService.getAppDumpList(request, 0));
				model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
				model.addAttribute("appDump", appDump);
				if(appDump.getmAppDumpId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/app-dump";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("appDumpList", mAppDumpService.getAppDumpList(request, 0));
				model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
				model.addAttribute("appDump", appDump);
				if(appDump.getmAppDumpId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "App Dump Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "App Dump Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/app-dump";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/app-dump";
	}

	@GetMapping("department")
	public String dashboard(HttpServletRequest request, Model model, @ModelAttribute("department") M_Department department,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "department")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** department - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** department");
			model.addAttribute("departmentList", mDepartmentService.getDepartmentList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/department";
	}

	@PostMapping("department")
	public String departmentPost(HttpServletRequest request, Model model, @ModelAttribute("department") M_Department department,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "department")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** department post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** department post");
			StringBuilder response = new StringBuilder();
			response.append(mDepartmentService.saveDepartmentDetails(request, department));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Department information added successfully.");
			} else if(response.toString().contains("edit") || response.toString().contains("noChange")) {
				reAttr.addFlashAttribute("regMsg", "Department information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("departmentList", mDepartmentService.getDepartmentList(request, 0));
				model.addAttribute("department", department);
				if(department.getmDepartmentId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/department";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("departmentList", mDepartmentService.getDepartmentList(request, 0));
				model.addAttribute("department", department);
				if(department.getmDepartmentId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Department Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Department Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/department";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/department";
	}

	@GetMapping("designation")
	public String designation(HttpServletRequest request, Model model, @ModelAttribute("designation") M_Designation designation,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "designation")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** designation - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** designation");
			model.addAttribute("designationList", mDesignationService.getDesignationList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/designation";
	}

	@PostMapping("designation")
	public String designationPost(HttpServletRequest request, Model model, @ModelAttribute("designation") M_Designation designation,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "designation")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** designation post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** designation post");
			StringBuilder response = new StringBuilder();
			response.append(mDesignationService.saveDesignationDetails(request, designation));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Designation information added successfully.");
			} else if(response.toString().contains("edit") || response.toString().contains("noChange")) {
				reAttr.addFlashAttribute("regMsg", "Designation information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("designationList", mDesignationService.getDesignationList(request, 0));
				model.addAttribute("designation", designation);
				if(designation.getmDesignationId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/designation";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("designationList", mDesignationService.getDesignationList(request, 0));
				model.addAttribute("designation", designation);
				if(designation.getmDesignationId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Designation Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Designation Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/designation";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/designation";
	}

	@GetMapping("level")
	public String level(@ModelAttribute("level") M_Member_Level level, HttpServletRequest request, Model model,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "level")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** level - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** level");
			model.addAttribute("memberLevelList", mMemberLevelService.getMemberLevelList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/level";
	}

	@PostMapping("level")
	public String levelPost(@ModelAttribute("level") M_Member_Level level, HttpServletRequest request, 
			Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "level")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** level post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** level post");
			StringBuilder response = new StringBuilder();
			response.append(mMemberLevelService.saveMemberLevelDetails(request, level));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Member Level information added successfully.");
			} else if(response.toString().contains("edit") || response.toString().contains("noChange")) {
				reAttr.addFlashAttribute("regMsg", "Member Level information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("memberLevelList", mMemberLevelService.getMemberLevelList(request, 0));
				model.addAttribute("memberLevel", level);
				if(level.getmMemberLevelId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/level";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("memberLevelList", mMemberLevelService.getMemberLevelList(request, 0));
				model.addAttribute("memberLevel", level);
				if(level.getmMemberLevelId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Member Level Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Member Level Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/level";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/level";
	}

	@GetMapping("entity")
	public String entity(HttpServletRequest request, Model model, @ModelAttribute("entity") M_Entity entity,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "entity")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** entity - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** entity");
			model.addAttribute("entityList", mEntityService.getEntityList(request, 0));
			model.addAttribute("activeParentEntityList", mEntityService.getActiveParentEntityByStatus(1));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/entity";
	}

	@PostMapping("entity-filter")
	public String entityFilter(HttpServletRequest request, Model model, @ModelAttribute("entity") M_Entity entity,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "entity")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** entity-filter post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			if(request.getParameter("locationFilter").equalsIgnoreCase("1") && request.getParameter("parentEntityFilter").equalsIgnoreCase("-1")) {
				return "redirect:/entity";
			}
			System.out.println("**** entity");
			model.addAttribute("entityList", mEntityService.getEntityList(request, 0));
			model.addAttribute("activeParentEntityList", mEntityService.getActiveParentEntityByStatus(1));
			model.addAttribute("locationFilterValue", request.getParameter("locationFilter"));
			model.addAttribute("parentEntityFilterValue", request.getParameter("parentEntityFilter"));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/entity";
	}

	@PostMapping("entity")
	public String entityPost(HttpServletRequest request, Model model, @ModelAttribute("entity") M_Entity entity,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "entity")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** entity post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** entity post");
			StringBuilder response = new StringBuilder();
			response.append(mEntityService.saveEntityDetails(request, entity));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Entity information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Entity information edited successfully.");
			} else {
				model.addAttribute("entityList", mEntityService.getEntityList(request, 0));
				if(response.toString().contains("entityExists")) {
					model.addAttribute("entity", entity);
					if(entity.getmEntityId() != null) {
						model.addAttribute("cssEdit", "sequence-bg-1");
						model.addAttribute("regMsgEdit", "Entity alread exists, provide different name and save again.");
						model.addAttribute("openEditModel", "openEditModel");
					} else {
						model.addAttribute("css", "sequence-bg-1");
						model.addAttribute("regMsg", "Entity alread exists, provide different name and save again.");
						model.addAttribute("openAddModal", "openAddModal");
					}
				} else if(response.toString().contains("entityLocationExists")) {
					if(entity.getmEntityId() != null) {
						model.addAttribute("cssEdit", "sequence-bg-1");
						model.addAttribute("regMsgEdit", "Entity-Location alread exists, provide different name and save again.");
						model.addAttribute("openEditModel", "openEditModel");
					} else {
						model.addAttribute("css", "sequence-bg-1");
						model.addAttribute("regMsg", "Entity-Location alread exists, provide different name and save again.");
						model.addAttribute("openAddModal", "openAddModal");
					}
				} else if(response.toString().contains("error")) {
					if(entity.getmEntityId() != null) {
						model.addAttribute("cssEdit", "sequence-bg-1");
						model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
						model.addAttribute("openEditModel", "openEditModel");
					} else {
						model.addAttribute("css", "sequence-bg-1");
						model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
						model.addAttribute("openAddModal", "openAddModal");
					}
				}
				return "masters/entity";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/entity";
	}

	@GetMapping("location")
	public String location(HttpServletRequest request, Model model, @ModelAttribute("location") M_Location location,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "location")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** location - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** location");
			model.addAttribute("locationList", mLocationService.getLocationList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/location";
	}

	@PostMapping("location")
	public String locationPost(HttpServletRequest request, Model model, @ModelAttribute("location") M_Location location,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "location")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** location post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** location post");
			StringBuilder response = new StringBuilder();
			response.append(mLocationService.saveLocationDetails(request, location));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Location information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Location information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("locationList", mLocationService.getLocationList(request, 0));
				model.addAttribute("location", location);
				if(location.getmLocationId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/location";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("locationList", mLocationService.getLocationList(request, 0));
				model.addAttribute("location", location);
				if(location.getmLocationId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Location Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Location Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/location";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/location";
	}

	@GetMapping("zone")
	public String zone(HttpServletRequest request, Model model, @ModelAttribute("zone") M_Zone zone, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "zone")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** zone - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** zone");
			model.addAttribute("zoneList", mZoneService.getZoneList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/zone";
	}

	@PostMapping("zone")
	public String zonePost(HttpServletRequest request, Model model, @ModelAttribute("zone") M_Zone zone,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "zone")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** zone post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** zone post");
			StringBuilder response = new StringBuilder();
			response.append(mZoneService.saveZoneDetails(request, zone));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Zone information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Zone information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("zoneList", mZoneService.getZoneList(request, 0));
				model.addAttribute("zone", zone);
				if(zone.getmZoneId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/zone";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("zoneList", mZoneService.getZoneList(request, 0));
				model.addAttribute("zone", zone);
				if(zone.getmZoneId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Zone Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Zone Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/zone";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/zone";
	}

	@GetMapping("mail-configuration")
	public String mailconfiguration(HttpServletRequest request, Model model, @ModelAttribute("mailConfiguration") M_Mail_Configuration mailConfiguration,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "mail-configuration")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** mail-configuration - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** mail-configuration");
			model.addAttribute("mailConfigurationList", mMailConfigurationService.getMailConfigurationList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/mailConfiguration";
	}

	@PostMapping("mail-configuration")
	public String mailConfigurationPost(HttpServletRequest request, Model model, @ModelAttribute("mailConfiguration") M_Mail_Configuration mailConfiguration,
			RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "mail-configuration")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** mail-configuration post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** mail-configuration post");
			StringBuilder response = new StringBuilder();
			response.append(mMailConfigurationService.saveMailConfigurationDetails(request, mailConfiguration));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "MailConfiguration information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "MailConfiguration information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("mailConfigurationList", mMailConfigurationService.getMailConfigurationList(request, 0));
				model.addAttribute("mailConfiguration", mailConfiguration);
				if(mailConfiguration.getmMailConfigurationId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/mailConfiguration";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("mailConfigurationList", mMailConfigurationService.getMailConfigurationList(request, 0));
				model.addAttribute("mailConfiguration", mailConfiguration);
				if(mailConfiguration.getmMailConfigurationId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "MailConfiguration Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "MailConfiguration Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/mailConfiguration";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/mail-configuration";
	}

	@GetMapping("role")
	public String role(@ModelAttribute("role") M_Role role, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "role")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** role - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** role");
			model.addAttribute("roleList", mRoleService.getRoleList(request, 0));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/role";
	}

	@PostMapping("role")
	public String rolePost(@ModelAttribute("role") M_Role role, HttpServletRequest request, 
			Model model, RedirectAttributes reAttr) throws Exception {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "role")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** role post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** role post");
			StringBuilder response = new StringBuilder();
			response.append(mRoleService.saveRoleDetails(request, role));
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Role information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Role information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("roleList", mRoleService.getRoleList(request, 0));
				model.addAttribute("role", role);
				if(role.getmRoleId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/role";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("roleList", mRoleService.getRoleList(request, 0));
				model.addAttribute("role", role);
				if(role.getmRoleId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Role Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Role Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/role";
			}
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
		}
		return "redirect:/role";
	}

	@GetMapping("user")
	public String user(@ModelAttribute("user") M_User user, HttpServletRequest request, Model model, RedirectAttributes reAttr) {
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "user")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** user - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			System.out.println("**** user");
			model.addAttribute("userList", mUserService.getUserList(request, 0));
			model.addAttribute("activeDesignationList", mDesignationService.getDesignationByActiveStatus(1));
			model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
			model.addAttribute("activeChildEntityList", mEntityService.getActiveChildEntityByStatus(1));
			System.out.println("App List Size : "+mAppService.getAppByActiveStatus(1).size());
			model.addAttribute("activeApps", mAppService.getAppByActiveStatus(1));
			model.addAttribute("roleList", mRoleService.getRoleByActiveStatus(1));
			System.out.println("****");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "masters/user";
	}

	@PostMapping("user")
	public String userPost(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user,
			RedirectAttributes reAttr) throws Exception {
		StringBuilder response = new StringBuilder();
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "user")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** user post - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			response.append(mUserService.saveUserDetails(request, user));
			if(response.toString().equalsIgnoreCase("add")) {
				mUserService.sendRegistrationMail(request, user);
				reAttr.addFlashAttribute("regMsg", "Your registration is completed successfully.<br>Complete the registration using the link sent you for email verification. "
						+ "Kindly wait till your account is approved.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if(response.toString().equalsIgnoreCase("edit")) {
				reAttr.addFlashAttribute("regMsg", "User Details Edited successfully.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if(response.toString().contains("invalid-string")) {
				model.addAttribute("activeDesignationList", mDesignationService.getDesignationByActiveStatus(1));
				model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
				model.addAttribute("activeChildEntityList", mEntityService.getActiveChildEntityByStatus(1));
				model.addAttribute("roleList", mRoleService.getRoleList(request, 0));
				if(user.getmUserId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You entered invalid string value. Try again and put valid text values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You entered invalid string value. Try again and put valid text values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/user";
			} else if(response.toString().equalsIgnoreCase("nameExists")) {
				model.addAttribute("activeDesignationList", mDesignationService.getDesignationByActiveStatus(1));
				model.addAttribute("activeDepartmentList", mDepartmentService.getDepartmentByActiveStatus(1));
				model.addAttribute("activeChildEntityList", mEntityService.getActiveChildEntityByStatus(1));
				model.addAttribute("roleList", mRoleService.getRoleList(request, 0));
				if(user.getmUserId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "User E-Mail ID alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "User E-Mail ID alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "masters/user";
			} else {
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/user";
	}

	/*@GetMapping("signup")
	public String signup(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user, RedirectAttributes reAttr) {
		Integer roleCheckFlag = 0;
		if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "user")) == 0) {
			roleCheckFlag = null;
			System.out.println("**** user - not allowed to access the page");
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
			System.out.println("****");
			return "redirect:/master";
		}
		roleCheckFlag = null;
		model.addAttribute("activeChildEntityList",mEntityService.getActiveChildEntityByStatus(1));
		model.addAttribute("activeDesignationList",mDesignationService.getDesignationByActiveStatus(1));
		model.addAttribute("activeDepartmentList",mDepartmentService.getDepartmentByActiveStatus(1));
		model.addAttribute("activeUsers", mUserService.getUserByActiveStatus(1));
		return "masters/sign-up";
	}*/

	/*@PostMapping("signup")
	public String signupPost(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user, RedirectAttributes reAttr) {
		StringBuilder response = new StringBuilder();
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "signup")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** user - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			response.append(mUserService.saveUserDetails(request, user));
			if(response.toString().equalsIgnoreCase("add")) {
				//mUserService.sendRegistrationMail(request, user);
				reAttr.addFlashAttribute("regMsg", "Your registration is completed successfully.<br>Complete the registration using the link sent you for email verification.");
				reAttr.addFlashAttribute("regMsg", "Registration is complete. Kindly add role, app to user for user to access the same.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if(response.toString().equalsIgnoreCase("edit")) {
				
			} else if(response.toString().contains("invalid-string")) {
				reAttr.addFlashAttribute("regMsg", "You entered invalid string value. Try again and put valid text values.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			} else {
				reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/signup";
	}*/

	@GetMapping("signup")
	public String signup(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user, RedirectAttributes reAttr) {
		Integer roleCheckFlag = 0;
		if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "user")) == 0) {
			roleCheckFlag = null;
			System.out.println("**** user - not allowed to access the page");
			reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
			System.out.println("****");
			return "redirect:/master";
		}
		roleCheckFlag = null;
		model.addAttribute("activeChildEntityList",mEntityService.getActiveChildEntityByStatus(1));
		model.addAttribute("activeDesignationList",mDesignationService.getDesignationByActiveStatus(1));
		model.addAttribute("activeDepartmentList",mDepartmentService.getDepartmentByActiveStatus(1));
		return "masters/sign-up";
	}

	@PostMapping("signup")
	public String signupPost(HttpServletRequest request, Model model, @ModelAttribute("user") M_User user, RedirectAttributes reAttr) {
		StringBuilder response = new StringBuilder();
		try {
			Integer roleCheckFlag = 0;
			if(roleCheckFlag.compareTo(mRoleService.getUrlAccessForUser(request, "signup")) == 0) {
				roleCheckFlag = null;
				System.out.println("**** user - not allowed to access the page");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
				System.out.println("****");
				return "redirect:/master";
			}
			roleCheckFlag = null;
			response.append(mUserService.saveUserDetailsV1(request, user));
			if(response.toString().equalsIgnoreCase("add")) {
				//mUserService.sendRegistrationMail(request, user);
				/*reAttr.addFlashAttribute("regMsg", "Your registration is completed successfully.<br>Complete the registration using the link sent you for email verification.");*/
				reAttr.addFlashAttribute("regMsg", "Registration is complete.");
				reAttr.addFlashAttribute("css", "sequence-bg-5");
			} else if(response.toString().equalsIgnoreCase("edit")) {
				
			} else if(response.toString().contains("invalid-string")) {
				reAttr.addFlashAttribute("regMsg", "You entered invalid string value. Try again and put valid text values.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			} else {
				reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
				reAttr.addFlashAttribute("css", "sequence-bg-1");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/signup";
	}
}