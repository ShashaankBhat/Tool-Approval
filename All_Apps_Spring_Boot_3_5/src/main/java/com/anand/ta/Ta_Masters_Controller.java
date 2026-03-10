package com.anand.ta;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anand.masters.M_Role;
import com.anand.masters.M_Role_Dao;
import com.anand.masters.M_User_Role_Map;
import com.anand.masters.M_User_Role_Map_Dao;
import com.anand.masters.M_User_Service;
import com.anand.masters.M_Role_Service;
import com.anand.masters.M_Entity_Service;
import com.google.gson.Gson;
import com.anand.ta.AttachmentSection;
import com.anand.ta1.Ta_Approval_Matrix_Service;
import com.anand.ta1.Ta_Business_Unit_Service;
import com.anand.ta1.Ta_Recovery_Type_Service;
import com.anand.ta1.Ta_Status_Service;
import com.anand.masters.M_User;



/**
 * TAA Masters Controller
 * SINGLE CONTROLLER for Tool Approval Application
 */
@Controller
public class Ta_Masters_Controller {

    /* ================= AUTOWIRED DEPENDENCIES ================= */

	@Autowired
	private M_User_Service mUserService;
	
    @Autowired
    private M_Role_Service mRoleService;

    @Autowired
    private M_Role_Dao mRoleDao;

    @Autowired
    private M_User_Role_Map_Dao mUserRoleMapDao;

    @Autowired
    private M_Entity_Service mEntityService;

    @Autowired
    private Ta_Tool_Request_Service taToolRequestService;


    @Autowired
    private Ta_Tool_Cost_Details_Service costDetailsService;

    @Autowired
    private Ta_Business_Unit_Service taBusinessUnitService;

    @Autowired
    private Ta_Status_Service taStatusService;

    @Autowired
    private Ta_Recovery_Type_Service taRecoveryTypeService;

    @Autowired
    private Ta_Approval_Matrix_Service taApprovalMatrixService;

    @Autowired
    private Ta_Dashboard_Service dashboardService;

    @Autowired
    private Ta_Attachments_Service attachmentsService;


    /* ================= TA MASTERS DASHBOARD ================= */

    

    /* ================= STEP 1 : TOOL DETAILS ================= */

    @PostMapping("add-tool-approval-request")
    public String saveToolDetails(
            @ModelAttribute Ta_Tool_Request toolRequest,
            @RequestParam("actionType") String actionType,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        if (toolRequest.getTaToolRequestId() == null) {
            taToolRequestService.createToolRequest(request, toolRequest, actionType);
        } else {
            taToolRequestService.updateToolRequest(request, toolRequest, actionType);
        }

        if ("draft".equalsIgnoreCase(actionType)) {

            redirectAttributes.addFlashAttribute("css", "alert-success");
            redirectAttributes.addFlashAttribute("regMsg", "Draft saved successfully.");

            return "redirect:/add-tool-approval-request?reqId="
                    + toolRequest.getTaToolRequestId();
        }

        return "redirect:/ta-tool-cost-details?toolRequestId="
                + toolRequest.getTaToolRequestId();
    }

    /* ================= STEP 2 : COST DETAILS ================= */

    @GetMapping("ta-tool-cost-details")
    public String getToolCostDetails(
            @RequestParam("toolRequestId") Long toolRequestId,
            Model model) {

        List<Ta_Tool_Cost_Details> costDetailsList =
                costDetailsService.getCostDetails(toolRequestId);

        Ta_Tool_Cost_Details_Wrapper wrapper =
                new Ta_Tool_Cost_Details_Wrapper();

        if (costDetailsList != null && !costDetailsList.isEmpty()) {
            wrapper.setCostDetailsList(costDetailsList);
        } else {
            List<Ta_Tool_Cost_Details> newList = new java.util.ArrayList<>();
            newList.add(new Ta_Tool_Cost_Details());
            wrapper.setCostDetailsList(newList);
        }

        model.addAttribute("costWrapper", wrapper);

        // IMPORTANT — needed for JSP rendering
        model.addAttribute("costDetailsList", wrapper.getCostDetailsList());

        model.addAttribute("taToolRequestId", toolRequestId);

        return "ToolApproval/Add_Tool_Approval_Cost_Details";
    }


    @PostMapping("ta-tool-cost-details")
    public String saveToolCostDetails(
            HttpServletRequest request,
            @RequestParam("actionType") String actionType,
            @RequestParam("toolRequest.taToolRequestId") Long toolRequestId,
            @ModelAttribute("costWrapper") Ta_Tool_Cost_Details_Wrapper wrapper) {

        List<Ta_Tool_Cost_Details> costDetailsList =
                wrapper != null ? wrapper.getCostDetailsList() : null;

        System.out.println("==== DEBUG COST WRAPPER ====");
        System.out.println("Wrapper is NULL? " + (wrapper == null));
        System.out.println("Cost list is NULL? " + (costDetailsList == null));
        System.out.println("Cost list size: " +
                (costDetailsList == null ? "NULL" : costDetailsList.size()));

        costDetailsService.saveCostDetails(
                request,
                toolRequestId,
                costDetailsList,
                actionType);

        if ("draft".equals(actionType)) {
            return "redirect:/ta-tool-cost-details?toolRequestId=" + toolRequestId;
        } else {
            return "redirect:/dashboard-tool-approval";
        }
    }

    /* ================= VIEW REQUEST ================= */

    @GetMapping("view-tool-approval-details")
    public String viewToolApprovalDetails(
            @RequestParam("reqId") Long reqId,
            HttpServletRequest request,
            Model model,
            RedirectAttributes reAttr) {

        /* -------- ROLE ACCESS CHECK -------- */
        if (mRoleService.getUrlAccessForUser(request, "view-tool-approval-details") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Unauthorized access.");
            return "redirect:/dashboard";
        }

        /* -------- NULL SAFETY -------- */
        if (reqId == null) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Invalid request ID.");
            return "redirect:/view-tool-approval-request-list";
        }

        /* -------- FETCH VIA SERVICE (NOT DAO) -------- */
        Ta_Tool_Request toolRequest =
                taToolRequestService.getToolRequestById(reqId);

        /* -------- MODEL BINDING -------- */
        model.addAttribute("toolRequest", toolRequest);
        model.addAttribute(
                "costDetails",
                costDetailsService.getCostDetails(reqId)
        );
        model.addAttribute("page", "viewRequest");

        /* -------- VIEW -------- */
        return "ToolApproval/View_Tool_Approval_Details";
    }

    
    @GetMapping("view-tool-approval-request-list")
    public String viewToolApprovalRequestList(
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "sort", required = false) String sort,
            HttpServletRequest request,
            Model model,
            RedirectAttributes reAttr) {

        /* -------- ROLE ACCESS CHECK -------- */
        if (mRoleService.getUrlAccessForUser(request, "view-tool-approval-request-list") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Unauthorized access.");
            return "redirect:/dashboard";
        }

        /* -------- FETCH BASE DATA -------- */
        List<Ta_Tool_Request> toolRequestList =
                taToolRequestService.getAllToolRequestsForView(request);

        /* -------- STATUS FILTER -------- */
        if (status != null && !status.isEmpty()) {
            toolRequestList = toolRequestList.stream()
                    .filter(tr -> tr.getStatus() != null &&
                            status.equals(tr.getStatus().getTaStatusName()))
                    .toList();
        }

        /* -------- SORT LOGIC -------- */
        if (sort == null || sort.equals("latest")) {
            toolRequestList = toolRequestList.stream()
                    .sorted((a, b) -> b.getCreatedOn().compareTo(a.getCreatedOn()))
                    .toList();
        } else if (sort.equals("oldest")) {
            toolRequestList = toolRequestList.stream()
                    .sorted((a, b) -> a.getCreatedOn().compareTo(b.getCreatedOn()))
                    .toList();
        } else if (sort.equals("status")) {
            toolRequestList = toolRequestList.stream()
                    .sorted((a, b) ->
                            a.getStatus().getTaStatusName()
                                    .compareTo(b.getStatus().getTaStatusName()))
                    .toList();
        }

        /* -------- METRICS CALCULATION -------- */
        long draftCount = toolRequestList.stream()
                .filter(tr -> tr.getStatus() != null &&
                        "Draft".equals(tr.getStatus().getTaStatusName()))
                .count();

        long submittedCount = toolRequestList.stream()
                .filter(tr -> tr.getStatus() != null &&
                        "Submitted".equals(tr.getStatus().getTaStatusName()))
                .count();

        long rejectedCount = toolRequestList.stream()
                .filter(tr -> tr.getStatus() != null &&
                        "Rejected".equals(tr.getStatus().getTaStatusName()))
                .count();

        long approvedCount = toolRequestList.stream()
                .filter(tr -> tr.getStatus() != null &&
                        "Approved".equals(tr.getStatus().getTaStatusName()))
                .count();

        /* -------- MODEL BINDING -------- */
        model.addAttribute("toolRequestList", toolRequestList);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSort", sort);
        model.addAttribute("draftCount", draftCount);
        model.addAttribute("submittedCount", submittedCount);
        model.addAttribute("rejectedCount", rejectedCount);
        model.addAttribute("approvedCount", approvedCount);
        model.addAttribute("page", "viewRequestList");

        return "ToolApproval/View_Tool_Approval_Request_List";
    }

    @GetMapping("edit-tool-approval-request")
    public String editToolApprovalRequest(
            @RequestParam("reqId") Long reqId,
            HttpServletRequest request,
            Model model,
            RedirectAttributes reAttr) {

        /* -------- ROLE ACCESS CHECK -------- */
        if (mRoleService.getUrlAccessForUser(request, "edit-tool-approval-request") == 0) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Unauthorized access.");
            return "redirect:/dashboard";
        }

        if (reqId == null) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Invalid request ID.");
            return "redirect:/view-tool-approval-request-list";
        }

        Ta_Tool_Request toolRequest =
                taToolRequestService.getToolRequestById(reqId);

        if (toolRequest == null || toolRequest.getStatus() == null) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", "Invalid request state.");
            return "redirect:/view-tool-approval-request-list";
        }

        String status = toolRequest.getStatus().getTaStatusName();

        /* -------- LOCK STATES -------- */
        if ("Submitted".equals(status) ||
            "Approved".equals(status) ||
            "Rejected".equals(status)) {

            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg",
                    "Request cannot be edited in current status.");
            return "redirect:/view-tool-approval-request-list";
        }

        /* -------- ROUTING BASED ON STATUS -------- */

        if ("Draft".equals(status) ||
            "Tool Details Entered".equals(status)) {

            return "redirect:/add-tool-approval-request?reqId=" + reqId;
        }

        if ("Cost Entered".equals(status)) {

            return "redirect:/add-tool-approval-cost-details?reqId=" + reqId;
        }

        return "redirect:/view-tool-approval-request-list";
    }

    /* ================= APPROVAL MATRIX MASTER ================= */

    /**/



    /* ================= FETCH DETAILS FOR EDIT ================= */


    /* ================= DASHBOARD METRICS API (from Ta_Dashboard_Controller) ================= */

    @GetMapping("ta-dashboard-metrics")
    public ResponseEntity<?> getDashboardMetrics(HttpServletRequest request) {
        try {
            Map<String, Object> allMetrics = new java.util.HashMap<>();
            
            allMetrics.put("statusCounts", dashboardService.getRequestCountByStatus(request));
            allMetrics.put("pendingByRole", dashboardService.getPendingApprovalsByRole(request));
            allMetrics.put("turnaroundMetrics", dashboardService.getApprovalTurnaroundMetrics(request));
            allMetrics.put("approvalRateMetrics", dashboardService.getApprovalRateMetrics(request));
            allMetrics.put("averageApprovalTime", dashboardService.getAverageApprovalTime());

            return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(new Gson().toJson(allMetrics));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    /* ================= PENDING REQUESTS API (from Ta_Dashboard_Controller) ================= */

    @GetMapping("ta-pending-requests")
    public ResponseEntity<?> getPendingRequests(
            @RequestParam(required = false) Long userId,
            HttpServletRequest request) {
        try {
            List<Ta_Tool_Request> pendingRequests = dashboardService.getPendingRequestsForUser(
                userId != null ? userId : 1L);

            return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(new Gson().toJson(pendingRequests));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    /* ================= STATUS REPORT - DATE RANGE (from Ta_Dashboard_Controller) ================= */

    @GetMapping("ta-status-report")
    public void statusReport(
            @RequestParam(required = false) String fromDate,
            @RequestParam(required = false) String toDate,
            @RequestParam(required = false, defaultValue = "html") String format,
            HttpServletRequest request,
            HttpServletResponse response) {

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date from = fromDate != null ? sdf.parse(fromDate) : new Date(System.currentTimeMillis() - 30L * 24 * 60 * 60 * 1000);
            Date to = toDate != null ? sdf.parse(toDate) : new Date();

            List<Ta_Tool_Request> requests = dashboardService.getRequestsByDateRange(from, to);

            if ("csv".equalsIgnoreCase(format)) {
                exportToCSV(response, requests);
            } else {
                exportToHTML(response, requests);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* ================= ENTITY REPORT (from Ta_Dashboard_Controller) ================= */

    @GetMapping("ta-entity-report")
    public void entityReport(
            @RequestParam Long entityId,
            @RequestParam(required = false, defaultValue = "html") String format,
            HttpServletRequest request,
            HttpServletResponse response) {

        try {
            List<Ta_Tool_Request> requests = dashboardService.getRequestsByEntity(entityId);

            if ("csv".equalsIgnoreCase(format)) {
                exportToCSV(response, requests);
            } else {
                exportToHTML(response, requests);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* ================= ATTACHMENT ENDPOINTS (from Ta_Attachments_Controller) ================= */

    @PostMapping("ta-attachment-upload")
    public String uploadAttachment(
            @RequestParam("toolRequestId") Long toolRequestId,
            @RequestParam("file") MultipartFile file,
            @RequestParam("section") String section,
            HttpServletRequest request,
            RedirectAttributes reAttr) {

        String result = attachmentsService.uploadAttachment(toolRequestId, file, section, request);

        if (result.startsWith("success")) {
            reAttr.addFlashAttribute("css", "alert-success");
            reAttr.addFlashAttribute("regMsg", "File uploaded successfully.");
        } else {
            reAttr.addFlashAttribute("css", "alert-danger");
            reAttr.addFlashAttribute("regMsg", "Upload failed: " + result);
        }

        return "redirect:/add-tool-approval-request?reqId=" + toolRequestId;
    }

    @GetMapping("ta-attachment-download")
    public ResponseEntity<?> downloadAttachment(
            @RequestParam("attachmentId") Long attachmentId,
            HttpServletResponse response) {

        try {
            byte[] fileData = attachmentsService.downloadAttachment(attachmentId);
            String fileName = attachmentsService.getAttachmentFileName(attachmentId);

            if (fileData == null || fileName == null) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                    .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
                    .body(fileData);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @PostMapping("ta-attachment-delete")
    public String deleteAttachment(
            @RequestParam("toolRequestId") Long toolRequestId,
            @RequestParam("attachmentId") Long attachmentId,
            HttpServletRequest request,
            RedirectAttributes reAttr) {

        String result = attachmentsService.deleteAttachment(attachmentId, request);

        if ("success".equals(result)) {
            reAttr.addFlashAttribute("css", "alert-success");
            reAttr.addFlashAttribute("regMsg", "File deleted successfully.");
        } else {
            reAttr.addFlashAttribute("css", "alert-danger");
            reAttr.addFlashAttribute("regMsg", "Delete failed: " + result);
        }

        return "redirect:/add-tool-approval-request?reqId=" + toolRequestId;
    }

    @GetMapping("ta-attachment-validate-size")
    public ResponseEntity<?> validateFileSize(
            @RequestParam("toolRequestId") Long toolRequestId) {

        Long totalSizeKb = attachmentsService.getTotalAttachmentSize(toolRequestId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("totalSizeKb", totalSizeKb);
        response.put("maxSizeMb", 5);
        response.put("canUpload", totalSizeKb < (5 * 1024));

        return ResponseEntity.ok().body(response);
    }

    /* ================= HELPER METHODS ================= */

    private void exportToCSV(HttpServletResponse response, List<Ta_Tool_Request> requests) throws Exception {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"tool_approval_report.csv\"");

        try (PrintWriter out = response.getWriter()) {
            // CSV Header
            out.println("Request ID,Customer Name,Project Name,Plant Code,Status,Current Approver,Created On,Updated On");

            // CSV Data
            for (Ta_Tool_Request req : requests) {
                out.printf("%d,%s,%s,%s,%s,%s,%s,%s%n",
                    req.getTaToolRequestId(),
                    req.getCustomerName(),
                    req.getProjectName(),
                    req.getEntity() != null ? req.getEntity().getmEntityId() : "N/A",
                    req.getStatus().getTaStatusName(),
                    req.getCurrentApproverUser() != null ? req.getCurrentApproverUser().getUserFirstName() : "N/A",
                    req.getCreatedOn(),
                    req.getUpdatedOn()
                );
            }
        }
    }

    private void exportToHTML(HttpServletResponse response, List<Ta_Tool_Request> requests) throws Exception {
        response.setContentType("text/html");
        response.setHeader("Content-Disposition", "attachment; filename=\"tool_approval_report.html\"");

        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>Tool Approval Report</title>");
            out.println("<style>table {border-collapse: collapse; width: 100%;} th, td {border: 1px solid #ddd; padding: 8px; text-align: left;} th {background-color: #4CAF50; color: white;}</style>");
            out.println("</head><body>");
            out.println("<h2>Tool Approval Report</h2>");
            out.println("<table>");
            out.println("<tr><th>Request ID</th><th>Customer</th><th>Project</th><th>Plant</th><th>Status</th><th>Current Approver</th><th>Created</th><th>Updated</th></tr>");

            for (Ta_Tool_Request req : requests) {
                out.printf("<tr><td>%d</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>%n",
                    req.getTaToolRequestId(),
                    req.getCustomerName(),
                    req.getProjectName(),
                    req.getEntity() != null ? req.getEntity().getmEntityId() : "N/A",
                    req.getStatus().getTaStatusName(),
                    req.getCurrentApproverUser() != null ? req.getCurrentApproverUser().getUserFirstName() : "N/A",
                    req.getCreatedOn(),
                    req.getUpdatedOn()
                );
            }

            out.println("</table>");
            out.println("</body></html>");
        }
    }
}
