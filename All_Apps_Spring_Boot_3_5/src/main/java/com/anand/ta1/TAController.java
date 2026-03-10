package com.anand.ta1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.anand.masters.M_Entity_Service;
import com.anand.masters.M_Role_Service;
import com.anand.masters.M_User_Service;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class TAController {

    @Autowired private M_Role_Service mRoleService;
    @Autowired private M_User_Service mUserService;
    @Autowired private M_Entity_Service mEntityService;
    @Autowired private Ta_Business_Unit_Service taBusinessUnitService;
    @Autowired private Ta_Status_Service taStatusService;
    @Autowired private Ta_Recovery_Type_Service taRecoveryTypeService;
    @Autowired private Ta_Approval_Matrix_Service taApprovalMatrixService;
    @Autowired private Ta_Tool_Request_1_Service taToolRequestService;

	@GetMapping("dashboard-tool-approval")
    public String dashboardToolApproval(HttpServletRequest request, Model model, RedirectAttributes reAttr) {
        if (mRoleService.getUrlAccessForUser(request, "dashboard-tool-approval") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
            return "redirect:/dashboard";
        }
		/*
		 * List<Ta_Tool_Request> allRequests =
		 * taToolRequestService.getAllToolRequestsForView(request); long total =
		 * allRequests.size(); long approved = allRequests.stream().filter(r ->
		 * r.getStatus() != null &&
		 * "Approved".equalsIgnoreCase(r.getStatus().getTaStatusName())).count(); long
		 * rejected = allRequests.stream().filter(r -> r.getStatus() != null &&
		 * "Rejected".equalsIgnoreCase(r.getStatus().getTaStatusName())).count(); long
		 * pending = allRequests.stream().filter(r -> r.getStatus() != null &&
		 * !List.of("Approved",
		 * "Rejected").contains(r.getStatus().getTaStatusName())).count(); //
		 * ================= DASHBOARD METRICS ================= Map<String, Object>
		 * dashboardMetrics = new HashMap<>(); dashboardMetrics.put("total", total);
		 * dashboardMetrics.put("approved", approved); dashboardMetrics.put("rejected",
		 * rejected); dashboardMetrics.put("pending", pending);
		 * model.addAttribute("dashboardMetrics", dashboardMetrics); //
		 * ================= OPEN REQUESTS ================= // For now: anything not
		 * Approved / Rejected List<Ta_Tool_Request> openRequests = allRequests.stream()
		 * .filter(r -> r.getStatus() != null && !List.of("Approved",
		 * "Rejected").contains(r.getStatus().getTaStatusName())).toList();
		 * model.addAttribute("openRequests", openRequests);
		 */
        return "ta/dashboard-tool-approval";
    }

	@GetMapping("ta-masters-dashboard")
    public String taMastersDashboard(HttpServletRequest request, Model model, RedirectAttributes reAttr) {
        if (mRoleService.getUrlAccessForUser(request, "ta-masters-dashboard") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
            return "redirect:/dashboard-tool-approval";
        }
        model.addAttribute("buActive", taBusinessUnitService.getBusinessUnitByActiveStatus(1).size());
        model.addAttribute("buInactive", taBusinessUnitService.getBusinessUnitByActiveStatus(0).size());
        model.addAttribute("rtActive", taRecoveryTypeService.getRecoveryTypeByActiveStatus(1).size());
        model.addAttribute("rtInactive", taRecoveryTypeService.getRecoveryTypeByActiveStatus(0).size());
        model.addAttribute("statusActive", taStatusService.getStatusByActiveStatus(1).size());
        model.addAttribute("statusInactive", taStatusService.getStatusByActiveStatus(0).size());
        model.addAttribute("matrixActive", taApprovalMatrixService.getApprovalMatrixByActiveStatus(1).size());
        model.addAttribute("matrixInactive", taApprovalMatrixService.getApprovalMatrixByActiveStatus(1).size());
        return "ta/ta-masters-dashboard";
    }

	@GetMapping("ta-business-unit")
    public String businessUnit(@ModelAttribute("businessUnit") Ta_Business_Unit businessUnit,
    		HttpServletRequest request, Model model, RedirectAttributes reAttr) {
        if (mRoleService.getUrlAccessForUser(request, "ta-business-unit") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
            return "redirect:/ta-masters-dashboard";
        }
        model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitList(request, 0));
        return "ta/master/business-unit";
    }

    @GetMapping("ta-business-unit-history")
    public String businessUnitHistory(@RequestParam("taBusinessUnitId") Long taBusinessUnitId, HttpServletRequest request,
    		Model model, RedirectAttributes reAttr) {
        if (mRoleService.getUrlAccessForUser(request, "ta-business-unit") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
            return "redirect:/ta-masters-dashboard";
        }
        model.addAttribute("historyList", taBusinessUnitService.getBusinessUnitHistoryById(taBusinessUnitId));
        return "ta/master/business-unit-history";
    }

    @PostMapping("ta-business-unit")
    public String businessUnitPost( @ModelAttribute("businessUnit") Ta_Business_Unit businessUnit,
            HttpServletRequest request, Model model, RedirectAttributes reAttr) {
    	try {
    		System.out.println("*********************");
    		System.out.println("ta-business-unit post");
    		Integer buCheck = 0;
    		if (buCheck.compareTo(mRoleService.getUrlAccessForUser(request, "ta-business-unit")) == 0) {
    			reAttr.addFlashAttribute("css", "sequence-bg-1");
				reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
    			return "redirect:/ta-masters-dashboard";
    		}
    		buCheck = null;
            StringBuilder response = new StringBuilder();
            response.append(taBusinessUnitService.saveBusinessUnitDetails(request, businessUnit));
			System.out.println(response.toString()+"---");
			reAttr.addFlashAttribute("css", "sequence-bg-5");
			if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Business Unit information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Business Unit information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitList(request, 0));
				model.addAttribute("businessUnit", businessUnit);
				if(businessUnit.getTaBusinessUnitId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/business-unit";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitList(request, 0));
				model.addAttribute("businessUnit", businessUnit);
				if(businessUnit.getTaBusinessUnitId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Business Unit Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Business Unit Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/business-unit";
			}
			System.out.println("*********************");
        } catch (Exception e) {
            e.printStackTrace();
            reAttr.addFlashAttribute("css", "sequence-bg-1");
			reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
        }
        return "redirect:/ta-business-unit";
    }

    @GetMapping("ta-recovery-type")
    public String recoveryType(@ModelAttribute("recoveryType") Ta_Recovery_Type recoveryType, HttpServletRequest request,
            Model model, RedirectAttributes reAttr) {
    	try {
    		if (mRoleService.getUrlAccessForUser(request, "ta-recovery-type") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
                return "redirect:/dashboard-tool-approval";
            }
            model.addAttribute("recoveryTypeList", taRecoveryTypeService.getRecoveryTypeList(request, 0));
            return "ta/master/recovery-type";
    	} catch(Exception e) {
    		e.printStackTrace();
    		return "redirect:/dashboard-tool-approval";
    	}
    }

    @PostMapping("ta-recovery-type")
    public String recoveryTypePost(@ModelAttribute("recoveryType") Ta_Recovery_Type recoveryType, HttpServletRequest request,
            Model model, RedirectAttributes reAttr) {
        try {
            if (mRoleService.getUrlAccessForUser(request, "ta-recovery-type") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
                return "redirect:/ta-masters-dashboard";
            }
            StringBuilder response = new StringBuilder();
            response.append(taRecoveryTypeService.saveRecoveryTypeDetails(request, recoveryType));
            reAttr.addFlashAttribute("css", "sequence-bg-5");
            if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Recovery Type information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Recovery Type information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("recoveryTypeList", taRecoveryTypeService.getRecoveryTypeList(request, 0));
				model.addAttribute("recoveryType", recoveryType);
				if(recoveryType.getTaRecoveryTypeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/recovery-type";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("recoveryTypeList", taRecoveryTypeService.getRecoveryTypeList(request, 0));
				model.addAttribute("recoveryType", recoveryType);
				if(recoveryType.getTaRecoveryTypeId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Recovery Type Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Recovery Type Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/recovery-type";
			}
			System.out.println("*********************");
            
        } catch (Exception e) {
            e.printStackTrace();
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
        }
        return "redirect:/ta-recovery-type";
    }

    @GetMapping("ta-recovery-type-history")
    public String recoveryTypeHistory(@RequestParam("taRecoveryTypeId") Long id, HttpServletRequest request,
            Model model, RedirectAttributes reAttr) {
        if (mRoleService.getUrlAccessForUser(request, "ta-recovery-type") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
            return "redirect:/ta-masters-dashboard";
        }
        model.addAttribute("recoveryTypeHistoryList", taRecoveryTypeService.getRecoveryTypeHistoryById(id));
        return "ta/master/recovery-type-history";
    }

    @GetMapping("ta-status")
    public String status(@ModelAttribute("status") Ta_Status status, HttpServletRequest request,
            Model model, RedirectAttributes reAttr) {
    	try {
    		if (mRoleService.getUrlAccessForUser(request, "ta-status") == 0) {
        		reAttr.addFlashAttribute("css", "sequence-bg-1");
        		reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
        		return "redirect:/ta-masters-dashboard";
        	}
            model.addAttribute("statusList", taStatusService.getStatusList(request, 0));
    	} catch(Exception e ) {
    		e.printStackTrace();
    	}
    	return "ta/master/status";
    }

    @PostMapping("ta-status")
    public String statusPost(@ModelAttribute("status") Ta_Status status,HttpServletRequest request,
            Model model, RedirectAttributes reAttr) {
        try {
            if (mRoleService.getUrlAccessForUser(request, "ta-status") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
                return "redirect:/ta-masters-dashboard";
            }
            StringBuilder response = new StringBuilder();
            response.append(taStatusService.saveStatusDetails(request, status));
            System.out.println("-----------"+response.toString());
            reAttr.addFlashAttribute("css", "sequence-bg-5");
            if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Status information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Status information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("statusList", taStatusService.getStatusList(request, 0));
				model.addAttribute("status", status);
				if(status.getTaStatusId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/status";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("statusList", taStatusService.getStatusList(request, 0));
				model.addAttribute("status", status);
				if(status.getTaStatusId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Status Name alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Status Name alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/status";
			}
			System.out.println("*********************");
        } catch (Exception e) {
            e.printStackTrace();
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
        }
        return "redirect:/ta-status";
    }

    @GetMapping("ta-status-history")
    public String statusHistory(@RequestParam("taStatusId") Long taStatusId, HttpServletRequest request,
    		Model model,RedirectAttributes reAttr) {
    	if (mRoleService.getUrlAccessForUser(request, "ta-status") == 0) {
    		reAttr.addFlashAttribute("css", "sequence-bg-1");
    		reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
    		return "redirect:/ta-masters-dashboard";
    	}
    	model.addAttribute("statusHistoryList",taStatusService.getStatusHistoryByStatusId(taStatusId));
    	return "ta/master/status-history";
    }

    @GetMapping("ta-approval-matrix")
    public String approvalMatrix(@ModelAttribute("approvalMatrix") Ta_Approval_Matrix approvalMatrix, HttpServletRequest request,
            Model model, RedirectAttributes reAttr) {
        try {
    		if (mRoleService.getUrlAccessForUser(request, "ta-status") == 0) {
        		reAttr.addFlashAttribute("css", "sequence-bg-1");
        		reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
        		return "redirect:/ta-masters-dashboard";
        	}
    		model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitByActiveStatus(1));
            model.addAttribute("approvalMatrixList", taApprovalMatrixService.getApprovalMatrixList(request, 0));
            model.addAttribute("userList", mUserService.getUserByActiveStatus(1));
    	} catch(Exception e ) {
    		e.printStackTrace();
    	}
    	return "ta/master/approval-matrix";
    }

    @PostMapping("ta-approval-matrix")
    public String approvalMatrixPost(@ModelAttribute("approvalMatrix") Ta_Approval_Matrix approvalMatrix, HttpServletRequest request, 
    		Model model, RedirectAttributes reAttr) {
        try {
        	if (mRoleService.getUrlAccessForUser(request, "ta-approval-matrix") == 0) {
        		reAttr.addFlashAttribute("css", "sequence-bg-1");
        		reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
        		return "redirect:/ta-masters-dashboard";
            }
        	System.out.println("*********************");
        	System.out.println("ta-approval-matrix post");
        	StringBuilder response = new StringBuilder();
            response.append(taApprovalMatrixService.saveApprovalMatrixDetails(request, approvalMatrix));
            System.out.println("-----------"+response.toString());
            reAttr.addFlashAttribute("css", "sequence-bg-5");
            if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Approval Matrix information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Approval Matrix edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitByActiveStatus(1));
	            model.addAttribute("approvalMatrixList", taApprovalMatrixService.getApprovalMatrixList(request, 0));
	            model.addAttribute("userList", mUserService.getUserByActiveStatus(1));
				model.addAttribute("approvalMatrix", approvalMatrix);
				if(approvalMatrix.getTaApprovalMatrixId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/approval-matrix";
			} else if(response.toString().contains("nameExists")) {
				model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitByActiveStatus(1));
	            model.addAttribute("approvalMatrixList", taApprovalMatrixService.getApprovalMatrixList(request, 0));
	            model.addAttribute("userList", mUserService.getUserByActiveStatus(1));
				model.addAttribute("approvalMatrix", approvalMatrix);
				if(approvalMatrix.getTaApprovalMatrixId() != null) {
					model.addAttribute("cssEdit", "sequence-bg-1");
					model.addAttribute("regMsgEdit", "Business Unit Approval Matrix alread exists, provide different name and save again.");
					model.addAttribute("openEditModel", "openEditModel");
				} else {
					model.addAttribute("css", "sequence-bg-1");
					model.addAttribute("regMsg", "Business Unit Approval Matrix alread exists, provide different name and save again.");
					model.addAttribute("openAddModal", "openAddModal");
				}
				return "ta/master/approval-matrix";
			}
			System.out.println("*********************");
        } catch (Exception e) {
        	 e.printStackTrace();
             reAttr.addFlashAttribute("css", "sequence-bg-1");
             reAttr.addFlashAttribute("regMsg", "Something went wrong, try again after sometime.");
        }
        return "redirect:/ta-approval-matrix";
    }

    @GetMapping("ta-approval-matrix-history")
    public String approvalMatrixHistory(@RequestParam("taApprovalMatrixId") Long taApprovalMatrixId, HttpServletRequest request,
    		Model model,RedirectAttributes reAttr) {
    	if (mRoleService.getUrlAccessForUser(request, "ta-approval-matrix") == 0) {
    		reAttr.addFlashAttribute("css", "sequence-bg-1");
    		reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
    		return "redirect:/ta-masters-dashboard";
    	}
    	model.addAttribute("approvalMatrixList",taApprovalMatrixService.getApprovalMatrixHistoryByTaApprovalMatrixId(taApprovalMatrixId));
    	return "ta/master/approval-matrix-history";
    }

    @GetMapping("ta-approval-reqeust")
    public String taApprovalReqeust(HttpServletRequest request,Model model,RedirectAttributes reAttr,
    		@ModelAttribute("taToolRequest") Ta_Tool_Request_1 taToolRequest) {
    	try {
    		if (mRoleService.getUrlAccessForUser(request, "ta-approval-reqeust") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
                return "redirect:/dashboard";
            }
    		model.addAttribute("taToolRequest", taToolRequestService.getTaToolRequestDetail(request));
            model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitByActiveStatus(1));
            model.addAttribute("commodityManagerList", mUserService.getActiveUserByRole(1, "TA Commodity Manager"));
            model.addAttribute("plantCodeList", mEntityService.getActiveChildEntityByStatus(1));
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
		/* return "ToolApproval/Add_Tool_Approval_Request"; */
        return "ta/ta-approval-reqeust";
    }

    @PostMapping("ta-approval-reqeust")
    public String taApprovalReqeustPost(HttpServletRequest request,Model model,RedirectAttributes reAttr,
    		@ModelAttribute("taToolRequest") Ta_Tool_Request_1 taToolRequest) {
    	try {
    		if (mRoleService.getUrlAccessForUser(request, "ta-approval-reqeust") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "You are not authorized to access the page your tried to access, you have been re-directed to dashboard.");
                return "redirect:/dashboard";
            }
    		StringBuilder response = new StringBuilder();
    		response.append(taToolRequestService.saveTaToolRequestDetails(request, taToolRequest));
    		reAttr.addFlashAttribute("css", "sequence-bg-5");
            if(response.toString().contains("add")) {
				reAttr.addFlashAttribute("regMsg", "Tool Request information added successfully.");
			} else if(response.toString().contains("edit")) {
				reAttr.addFlashAttribute("regMsg", "Tool Request information edited successfully.");
			} else if(response.toString().contains("error")) {
				model.addAttribute("css", "sequence-bg-1");
				model.addAttribute("regMsg", "You were trying to save invalid values, try again with valid values.");
				model.addAttribute("businessUnitList", taBusinessUnitService.getBusinessUnitByActiveStatus(1));
	            model.addAttribute("commodityManagerList", mUserService.getActiveUserByRole(1, "TA Commodity Manager"));
	            model.addAttribute("plantCodeList", mEntityService.getActiveChildEntityByStatus(1));
	            model.addAttribute("taToolRequest", taToolRequest);
	            return "ta/ta-approval-reqeust";
			}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
		/* return "ToolApproval/Add_Tool_Approval_Request"; */
    	return "redirect:/ta-approval-reqeust";
    }
}