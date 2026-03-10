package com.anand.ta;

import java.util.Date;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;
import com.anand.ta1.Ta_Approval_Matrix;
import com.anand.ta1.Ta_Approval_Matrix_Dao;
import com.anand.ta1.Ta_Status;
import com.anand.ta1.Ta_Status_Dao;
import com.google.gson.Gson;

@Service
@Transactional
public class Ta_Approval_Service_Impl implements Ta_Approval_Service {

    @Autowired private Ta_Tool_Request_Dao toolRequestDao;
    @Autowired private Ta_Approval_Matrix_Dao approvalMatrixDao;
    @Autowired private Ta_Approval_Action_Dao approvalActionDao;
    @Autowired private Ta_Status_Dao statusDao;
    @Autowired private M_User_Dao userDao;
    @Autowired private Ta_Attachments_Dao attachmentsDao;

    /* ================= SUBMIT ================= */

    @Override
    public void submitForApproval(Long toolRequestId, HttpServletRequest request) {

        Ta_Tool_Request tr = toolRequestDao.findById(toolRequestId)
                .orElseThrow(() -> new RuntimeException("Tool request not found"));

        /* ================= FINALIZE TEMP ATTACHMENTS ================= */

        attachmentsDao.finalizeTempAttachments(toolRequestId);

        /* ================= CHANGE STATUS ================= */

        Ta_Status submitted = statusDao
                .findByTaStatusNameAndTaStatusActive("Submitted", 1)
                .get(0);

        Ta_Approval_Matrix matrix =
                approvalMatrixDao.findByMEntity_MEntityIdAndMatrixActive(
                        tr.getEntity().getmEntityId(), 1);

        if (matrix == null)
            throw new RuntimeException("Approval matrix not configured");

        M_User firstApprover = matrix.getApproverLevel1();

        if (firstApprover == null)
            throw new RuntimeException("Approver Level 1 not configured");

        tr.setStatus(submitted);
        tr.setCurrentApproverUser(firstApprover);
        tr.setUpdatedOn(new Date());

        toolRequestDao.save(tr);
    }

    /* ================= APPROVE ================= */

    @Override
    public String approveToolRequest(Long toolRequestId, String remarks, HttpServletRequest request) {

        Ta_Tool_Request tr = toolRequestDao.findById(toolRequestId).orElse(null);
        if (tr == null) return "error";

        M_User loggedIn = getLoggedInUser();
        Date now = new Date();

        saveApprovalAction(tr, loggedIn, 1, remarks, now);

        Ta_Approval_Matrix matrix =
                approvalMatrixDao.findByMEntity_MEntityIdAndMatrixActive(
                        tr.getEntity().getmEntityId(), 1);

        M_User next = getNextApprover(matrix, tr);

        if (next != null) {
            tr.setCurrentApproverUser(next);
        } else {
            Ta_Status approved = statusDao
                    .findByTaStatusNameAndTaStatusActive("Approved", 1)
                    .get(0);

            tr.setStatus(approved);
            tr.setCurrentApproverUser(null);
        }

        tr.setUpdatedOn(now);
        toolRequestDao.save(tr);

        return "approved";
    }

    /* ================= REJECT ================= */

    @Override
    public String rejectToolRequest(Long toolRequestId, String remarks, HttpServletRequest request) {

        Ta_Tool_Request tr = toolRequestDao.findById(toolRequestId).orElse(null);
        if (tr == null) return "error";

        M_User loggedIn = getLoggedInUser();
        Date now = new Date();

        saveApprovalAction(tr, loggedIn, 2, remarks, now);

        Ta_Status rejected = statusDao
                .findByTaStatusNameAndTaStatusActive("Rejected", 1)
                .get(0);

        tr.setStatus(rejected);
        tr.setCurrentApproverUser(null);
        tr.setUpdatedOn(now);

        toolRequestDao.save(tr);
        return "rejected";
    }

    /* ================= SEND BACK ================= */

    @Override
    public String sendBackToolRequest(Long toolRequestId, String remarks, HttpServletRequest request) {

        Ta_Tool_Request tr = toolRequestDao.findById(toolRequestId).orElse(null);
        if (tr == null) return "error";

        M_User loggedIn = getLoggedInUser();
        Date now = new Date();

        saveApprovalAction(tr, loggedIn, 3, remarks, now);

        Ta_Status submitted = statusDao
                .findByTaStatusNameAndTaStatusActive("Submitted", 1)
                .get(0);

        tr.setStatus(submitted);
        tr.setCurrentApproverUser(null);
        tr.setUpdatedOn(now);

        toolRequestDao.save(tr);
        return "sentBack";
    }

    /* ================= APPROVAL HISTORY ================= */

    @Override
    public String getApprovalHistory(Long toolRequestId) {
        return new Gson().toJson(
                approvalActionDao.findByToolRequest_TaToolRequestId(toolRequestId));
    }

    /* ================= HELPER METHODS ================= */

    private void saveApprovalAction(Ta_Tool_Request tr,
                                    M_User user,
                                    int actionCode,
                                    String remarks,
                                    Date now) {

        Ta_Approval_Action action = new Ta_Approval_Action();
        action.setToolRequest(tr);
        action.setApproverUser(user);
        action.setActionCode(actionCode);
        action.setApprovalRemark(remarks);
        action.setActionOn(now);
        action.setActionActive(1);
        action.setCreatedBy(user);
        action.setCreatedOn(now);

        approvalActionDao.save(action);
    }

    private M_User getNextApprover(Ta_Approval_Matrix matrix,
                                   Ta_Tool_Request tr) {

        M_User currentUser = tr.getCurrentApproverUser();

        if (currentUser == null)
            return matrix.getApproverLevel1();

        if (matrix.getApproverLevel1() != null &&
            currentUser.equals(matrix.getApproverLevel1()))
            return matrix.getApproverLevel2();

        if (matrix.getApproverLevel2() != null &&
            currentUser.equals(matrix.getApproverLevel2()))
            return matrix.getApproverLevel3();

        if (matrix.getApproverLevel3() != null &&
            currentUser.equals(matrix.getApproverLevel3()))
            return matrix.getApproverLevel4();

        return null;
    }

    private M_User getLoggedInUser() {
        return userDao.findByUserLoginId(
                SecurityContextHolder.getContext()
                        .getAuthentication()
                        .getName());
    }
}
