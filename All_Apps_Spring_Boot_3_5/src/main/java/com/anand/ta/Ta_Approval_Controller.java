package com.anand.ta;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.anand.masters.M_Role_Service;

@Controller
public class Ta_Approval_Controller {

    @Autowired
    private Ta_Approval_Service approvalService;

    @Autowired
    private M_Role_Service mRoleService;

    /* ================= SUBMIT FOR APPROVAL ================= */

    @PostMapping("ta-tool-request-submit")
    public String submitForApproval(
            @RequestParam("taToolRequestId") Long requestId,
            HttpServletRequest request,
            RedirectAttributes reAttr) {

        try {

            if (mRoleService.getUrlAccessForUser(request, "ta-tool-request-submit") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "Unauthorized access.");
                return "redirect:/dashboard";
            }

            approvalService.submitForApproval(requestId, request);

            reAttr.addFlashAttribute("css", "alert-success");
            reAttr.addFlashAttribute("regMsg",
                    "Request submitted for approval successfully.");

        } catch (Exception e) {
            reAttr.addFlashAttribute("css", "alert-danger");
            reAttr.addFlashAttribute("regMsg", e.getMessage());
        }

        return "redirect:/view-tool-approval-details?reqId=" + requestId;
    }

    /* ================= APPROVE TOOL REQUEST ================= */

    @PostMapping("ta-tool-request-approve")
    public String approveToolRequest(
            @RequestParam("toolRequestId") Long toolRequestId,
            @RequestParam(value = "remarks", required = false, defaultValue = "") String remarks,
            HttpServletRequest request,
            RedirectAttributes reAttr) {

        try {

            if (mRoleService.getUrlAccessForUser(request, "ta-tool-request-approve") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "Unauthorized access.");
                return "redirect:/dashboard";
            }

            String response =
                    approvalService.approveToolRequest(toolRequestId, remarks, request);

            if ("approved".equals(response)) {
                reAttr.addFlashAttribute("css", "sequence-bg-5");
                reAttr.addFlashAttribute("regMsg",
                        "Tool request approved successfully.");
            } else {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg",
                        "Failed to approve the request.");
            }

        } catch (Exception e) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", e.getMessage());
        }

        return "redirect:/view-tool-approval-details?reqId=" + toolRequestId;
    }

    /* ================= REJECT TOOL REQUEST ================= */

    @PostMapping("ta-tool-request-reject")
    public String rejectToolRequest(
            @RequestParam("toolRequestId") Long toolRequestId,
            @RequestParam(value = "remarks", required = false, defaultValue = "") String remarks,
            HttpServletRequest request,
            RedirectAttributes reAttr) {

        try {

            if (mRoleService.getUrlAccessForUser(request, "ta-tool-request-reject") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "Unauthorized access.");
                return "redirect:/dashboard";
            }

            String response =
                    approvalService.rejectToolRequest(toolRequestId, remarks, request);

            if ("rejected".equals(response)) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg",
                        "Tool request rejected successfully.");
            } else {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg",
                        "Failed to reject the request.");
            }

        } catch (Exception e) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", e.getMessage());
        }

        return "redirect:/view-tool-approval-details?reqId=" + toolRequestId;
    }

    /* ================= SEND BACK TOOL REQUEST ================= */

    @PostMapping("ta-tool-request-send-back")
    public String sendBackToolRequest(
            @RequestParam("toolRequestId") Long toolRequestId,
            @RequestParam(value = "remarks", required = false, defaultValue = "") String remarks,
            HttpServletRequest request,
            RedirectAttributes reAttr) {

        try {

            if (mRoleService.getUrlAccessForUser(request, "ta-tool-request-send-back") == 0) {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg", "Unauthorized access.");
                return "redirect:/dashboard";
            }

            String response =
                    approvalService.sendBackToolRequest(toolRequestId, remarks, request);

            if ("sentBack".equals(response)) {
                reAttr.addFlashAttribute("css", "alert-warning");
                reAttr.addFlashAttribute("regMsg",
                        "Tool request sent back to initiator.");
            } else {
                reAttr.addFlashAttribute("css", "sequence-bg-1");
                reAttr.addFlashAttribute("regMsg",
                        "Failed to send back the request.");
            }

        } catch (Exception e) {
            reAttr.addFlashAttribute("css", "sequence-bg-1");
            reAttr.addFlashAttribute("regMsg", e.getMessage());
        }

        return "redirect:/view-tool-approval-details?reqId=" + toolRequestId;
    }
}
