package com.anand.ta1;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import com.anand.masters.M_Role_Service;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class TARestController {

	@Autowired private M_Role_Service mRoleService;
	@Autowired private Ta_Business_Unit_Service taBusinessUnitService;
	@Autowired private Ta_Recovery_Type_Service taRecoveryTypeService;
	@Autowired private Ta_Status_Service taStatusService;
	@Autowired private Ta_Approval_Matrix_Service taApprovalMatrixService;
	@Autowired private Ta_Attachments_Service taAttachmentsService;

	@GetMapping("getBusinessUnitDetails")
    public String getBusinessUnitDetails(HttpServletRequest request, RedirectAttributes reAttr) {
		try {
			if (mRoleService.getUrlAccessForUser(request, "ta-business-unit") == 0) {
				return "error";
			}
			return taBusinessUnitService.getBusinessUnitDetails(request);
		} catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

	@GetMapping("loadMoreBusinessUnit")
	public String loadMoreBusinessUnit(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalBusinessUnitList = new ArrayList<Map<String, String>>();
		if (mRoleService.getUrlAccessForUser(request, "ta-business-unit") == 0) {
			Gson gson = new Gson();
			response.append(gson.toJson(finalBusinessUnitList));
			gson = null;
			return response.toString();
		}
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<Ta_Business_Unit> businessUnitList = taBusinessUnitService.getBusinessUnitList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			System.out.println("businessUnitList : "+businessUnitList.size());
			for(Ta_Business_Unit businessUnit : businessUnitList) {
				System.out.println(businessUnit.getTaBusinessUnitName());
				Map<String, String> businessUnitMap = new HashMap<String, String>();
				businessUnitMap.put("businessUnitName", businessUnit.getTaBusinessUnitName());
				businessUnitMap.put("businessUnitDescription", businessUnit.getTaBusinessUnitDescription());
				if(businessUnit.getTaBusinessUnitActive().compareTo(1) == 0) {
					businessUnitMap.put("businessUnitActive","<span class='badge badge-success'>Active</span>");
				} else {
					businessUnitMap.put("businessUnitActive","<span class='badge badge-danger'>In-Active</span>");
				}
				businessUnitMap.put("businessUnitCreatedBy", businessUnit.getCreatedBy().getUserFirstName()+" "+businessUnit.getCreatedBy().getUserLastName());
				businessUnitMap.put("businessUnitCreatedOn", dateFormat.format(businessUnit.getCreatedOn()));
				if(businessUnit.getUpdatedBy() != null) {
					businessUnitMap.put("businessUnitUpdatedBy", businessUnit.getUpdatedBy().getUserFirstName()+" "+businessUnit.getUpdatedBy().getUserLastName());
					businessUnitMap.put("businessUnitUpdatedOn", dateFormat.format(businessUnit.getUpdatedOn()));
				} else {
					businessUnitMap.put("businessUnitUpdatedBy", "");
					businessUnitMap.put("businessUnitUpdatedOn", "");
				}
				businessUnitMap.put("businessUnitAction", businessUnit.getActionForList());
				finalBusinessUnitList.add(businessUnitMap);
				businessUnitMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalBusinessUnitList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		 finalBusinessUnitList.clear(); finalBusinessUnitList = null; 
		System.out.println(response.toString());
		return response.toString();
	}

	@GetMapping("getRecoveryTypeDetails")
    public String getRecoveryTypeDetails(HttpServletRequest request) {
		try {
			if (mRoleService.getUrlAccessForUser(request, "ta-recovery-type") == 0) {
				return "error";
			}
			return taRecoveryTypeService.getRecoveryTypeDetails(request);
		} catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

	@GetMapping("loadMoreRecoveryType")
	public String loadMoreRecoveryType(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalRecoveryTypeList = new ArrayList<Map<String, String>>();
		if (mRoleService.getUrlAccessForUser(request, "ta-recovery-type") == 0) {
			Gson gson = new Gson();
			response.append(gson.toJson(finalRecoveryTypeList));
			gson = null;
			return response.toString();
		}
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<Ta_Recovery_Type> recoveryTypeList = taRecoveryTypeService.getRecoveryTypeList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			for(Ta_Recovery_Type recoveryType : recoveryTypeList) {
				Map<String, String> businessUnitMap = new HashMap<String, String>();
				businessUnitMap.put("recoveryTypeName", recoveryType.getTaRecoveryTypeName());
				businessUnitMap.put("recoveryTypeDescription", recoveryType.getTaRecoveryTypeDescription());
				if(recoveryType.getTaRecoveryTypeActive().compareTo(1) == 0) {
					businessUnitMap.put("recoveryTypeActive","<span class='badge badge-success'>Active</span>");
				} else {
					businessUnitMap.put("recoveryTypeActive","<span class='badge badge-danger'>In-Active</span>");
				}
				businessUnitMap.put("recoveryTypeCreatedBy", recoveryType.getCreatedBy().getUserFirstName()+" "+recoveryType.getCreatedBy().getUserLastName());
				businessUnitMap.put("recoveryTypeCreatedOn", dateFormat.format(recoveryType.getCreatedOn()));
				if(recoveryType.getUpdatedBy() != null) {
					businessUnitMap.put("recoveryTypeUpdatedBy", recoveryType.getUpdatedBy().getUserFirstName()+" "+recoveryType.getUpdatedBy().getUserLastName());
					businessUnitMap.put("recoveryTypeUpdatedOn", dateFormat.format(recoveryType.getUpdatedOn()));
				} else {
					businessUnitMap.put("recoveryTypeUpdatedBy", "");
					businessUnitMap.put("recoveryTypeUpdatedOn", "");
				}
				businessUnitMap.put("recoveryTypeAction", recoveryType.getActionForList());
				finalRecoveryTypeList.add(businessUnitMap);
				businessUnitMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalRecoveryTypeList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalRecoveryTypeList.clear(); finalRecoveryTypeList = null; 
		System.out.println(response.toString());
		return response.toString();
	}

	@GetMapping("getStatusDetails")
    public String getStatusDetails(HttpServletRequest request) {
		try {
			if (mRoleService.getUrlAccessForUser(request, "ta-status") == 0) {
				return "error";
            }
			return taStatusService.getStatusDetails(request);
		} catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

	@GetMapping("loadMoreStatus")
	public String loadMoreStatus(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalStatusList = new ArrayList<Map<String, String>>();
		if (mRoleService.getUrlAccessForUser(request, "ta-status") == 0) {
			Gson gson = new Gson();
			response.append(gson.toJson(finalStatusList));
			gson = null;
			return response.toString();
		}
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<Ta_Status> statusList = taStatusService.getStatusList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			System.out.println("statusList : "+statusList.size());
			for(Ta_Status status : statusList) {
				Map<String, String> statusMap = new HashMap<String, String>();
				statusMap.put("statusName", status.getTaStatusName());
				statusMap.put("statusDescription", status.getTaStatusDescription());
				if(status.getTaStatusActive().compareTo(1) == 0) {
					statusMap.put("statusActive","<span class='badge badge-success'>Active</span>");
				} else {
					statusMap.put("statusActive","<span class='badge badge-danger'>In-Active</span>");
				}
				statusMap.put("statusCreatedBy", status.getCreatedBy().getUserFirstName()+" "+status.getCreatedBy().getUserLastName());
				statusMap.put("statusCreatedOn", dateFormat.format(status.getCreatedOn()));
				if(status.getUpdatedBy() != null) {
					statusMap.put("statusUpdatedBy", status.getUpdatedBy().getUserFirstName()+" "+status.getUpdatedBy().getUserLastName());
					statusMap.put("statusUpdatedOn", dateFormat.format(status.getUpdatedOn()));
				} else {
					statusMap.put("statusUpdatedBy", "");
					statusMap.put("statusUpdatedOn", "");
				}
				statusMap.put("statusAction", status.getActionForList());
				finalStatusList.add(statusMap);
				statusMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalStatusList));
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalStatusList.clear(); finalStatusList = null;
		return response.toString();
	}

	@GetMapping("getApprovalMatrixDetails")
    public String getApprovalMatrixDetails(HttpServletRequest request) {
		try {
			if (mRoleService.getUrlAccessForUser(request, "ta-approval-matrix") == 0) {
				return "error";
            }
			return taApprovalMatrixService.getApprovalMatrixDetails(request);
		} catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

	@GetMapping("loadMoreApprovalMatrix")
	public String loadMoreApprovalMatrix(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		List<Map<String, String>> finalApprovalMatrixList = new ArrayList<Map<String, String>>();
		if (mRoleService.getUrlAccessForUser(request, "ta-approval-matrix") == 0) {
			Gson gson = new Gson();
			response.append(gson.toJson(finalApprovalMatrixList));
			gson = null;
			return response.toString();
		}
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			List<Ta_Approval_Matrix> approvalMatrixList = taApprovalMatrixService.getApprovalMatrixList(request, Integer.parseInt(""+request.getParameter("offsetValue")));
			System.out.println("approvalMatrixList : "+approvalMatrixList.size());
			for(Ta_Approval_Matrix approvalMatrix : approvalMatrixList) {
				Map<String, String> approvalMatrixMap = new HashMap<String, String>();
				approvalMatrixMap.put("approvalMatrixBusinessUnit", ""+approvalMatrix.getApprovalMatrixForBusinessUnit().getTaBusinessUnitName());
				approvalMatrixMap.put("approvalMatrixLevelOne", approvalMatrix.getLevelOne().getUserFirstName()+" "+approvalMatrix.getLevelOne().getUserLastName());
				approvalMatrixMap.put("approvalMatrixLevelTwo", approvalMatrix.getLevelTwo().getUserFirstName()+" "+approvalMatrix.getLevelTwo().getUserLastName());
				approvalMatrixMap.put("approvalMatrixLevelThree", approvalMatrix.getLevelThree().getUserFirstName()+" "+approvalMatrix.getLevelThree().getUserLastName());
				approvalMatrixMap.put("approvalMatrixLevelFour", approvalMatrix.getLevelFour().getUserFirstName()+" "+approvalMatrix.getLevelFour().getUserLastName());
				approvalMatrixMap.put("approvalMatrixLevelOnePosition", approvalMatrix.getLevelOnePosition());
				approvalMatrixMap.put("approvalMatrixLevelTwoPosition", approvalMatrix.getLevelTwoPosition());
				approvalMatrixMap.put("approvalMatrixLevelThreePosition", approvalMatrix.getLevelThreePosition());
				approvalMatrixMap.put("approvalMatrixLevelFourPosition", approvalMatrix.getLevelFourPosition());
				if(approvalMatrix.getMatrixActive().compareTo(1) == 0) {
					approvalMatrixMap.put("approvalMatrixActive","<span class='badge badge-success'>Active</span>");
				} else {
					approvalMatrixMap.put("approvalMatrixActive","<span class='badge badge-danger'>In-Active</span>");
				}
				approvalMatrixMap.put("approvalMatrixCreatedBy", approvalMatrix.getCreatedBy().getUserFirstName()+" "+approvalMatrix.getCreatedBy().getUserLastName());
				approvalMatrixMap.put("approvalMatrixCreatedOn", dateFormat.format(approvalMatrix.getCreatedOn()));
				if(approvalMatrix.getUpdatedBy() != null) {
					approvalMatrixMap.put("approvalMatrixUpdatedBy", approvalMatrix.getUpdatedBy().getUserFirstName()+" "+approvalMatrix.getUpdatedBy().getUserLastName());
					approvalMatrixMap.put("approvalMatrixUpdatedOn", dateFormat.format(approvalMatrix.getUpdatedOn()));
				} else {
					approvalMatrixMap.put("approvalMatrixUpdatedBy", "");
					approvalMatrixMap.put("approvalMatrixUpdatedOn", "");
				}
				approvalMatrixMap.put("approvalMatrixAction", approvalMatrix.getActionForList());
				finalApprovalMatrixList.add(approvalMatrixMap);
				approvalMatrixMap = null;
			}
			dateFormat = null;
			Gson gson = new Gson();
			response.append(gson.toJson(finalApprovalMatrixList));
			approvalMatrixList.clear(); approvalMatrixList = null;
			gson = null;
		} catch(Exception e) {
			e.printStackTrace();
			response.setLength(0);
			response.append("error");
		}
		finalApprovalMatrixList.clear(); finalApprovalMatrixList = null;
		return response.toString();
	}

	@PostMapping("ta-attachment-upload")
    public String uploadAttachment(HttpServletRequest request,
            @RequestParam("toolRequestId") Long toolRequestId,
            @RequestParam("file") MultipartFile file,
            @RequestParam("section") Integer section) {

        try {

			if (mRoleService.getUrlAccessForUser(request, "ta-approval-reqeust") == 0) {
				return "error";
			}

            if(toolRequestId == null) {
                return "error";
            }

            return taAttachmentsService.uploadAttachment(
                    request,
                    toolRequestId,
                    file,
                    section);

        } catch(Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @GetMapping("ta-attachment-download")
    public ResponseEntity<byte[]> downloadAttachment(
            @RequestParam("attachmentId") Long attachmentId) {

        try {

			if (mRoleService.getUrlAccessForUser(request, "ta-approval-reqeust") == 0) {
				return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
			}

            byte[] fileData =
                    taAttachmentsService.downloadAttachment(attachmentId);

            String fileName =
                    taAttachmentsService.getAttachmentFileName(attachmentId);

            if(fileData == null) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + fileName + "\"")
                    .body(fileData);

        } catch(Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PostMapping("ta-attachment-delete")
    public String deleteAttachment(HttpServletRequest request,
            @RequestParam("attachmentId") Long attachmentId) {

        try {

			if (mRoleService.getUrlAccessForUser(request, "ta-approval-reqeust") == 0) {
				return "error";
			}

            return taAttachmentsService.deleteAttachment(request, attachmentId);

        } catch(Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @GetMapping("getAttachmentList")
    public String getAttachmentList(HttpServletRequest request) {

        StringBuilder response = new StringBuilder();

        try {

			if (mRoleService.getUrlAccessForUser(request, "ta-approval-reqeust") == 0) {
				return "error";
			}

            Long toolRequestId =
                    Long.parseLong(request.getParameter("toolRequestId"));

            Integer section =
                    Integer.parseInt(request.getParameter("section"));

            List<Ta_Attachments> list =
                    taAttachmentsService
                            .getAttachmentListBySection(toolRequestId, section);

            Gson gson = new Gson();
            response.append(gson.toJson(list));
            gson = null;

        } catch(Exception e) {

            e.printStackTrace();
            response.setLength(0);
            response.append("error");
        }

        return response.toString();
    }
}
