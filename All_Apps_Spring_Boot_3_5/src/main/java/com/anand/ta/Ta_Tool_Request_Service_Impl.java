package com.anand.ta;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;
import com.anand.ta1.Ta_Status;
import com.anand.ta1.Ta_Status_Dao;
import com.google.gson.Gson;

@Service
public class Ta_Tool_Request_Service_Impl implements Ta_Tool_Request_Service {

    @Autowired
    private Ta_Tool_Request_Dao requestDao;

    @Autowired
    private M_User_Dao mUserDao;

    @Autowired
    private Ta_Status_Dao taStatusDao;

    @Override
    public List<Ta_Tool_Request> getRequestList(HttpServletRequest request) {
        return requestDao.findAll();
    }

    @Override
    @Transactional
    public String createToolRequest(HttpServletRequest request,
                                    Ta_Tool_Request toolRequest,
                                    String actionType) {

        M_User user = mUserDao.findByUserLoginId(
                SecurityContextHolder.getContext()
                        .getAuthentication()
                        .getName());

        Date now = new Date();

        toolRequest.setRequestNumber("TA-" + System.currentTimeMillis());

        String statusName =
                "draft".equals(actionType)
                        ? "Draft"
                        : "Tool Details Entered";

        if (toolRequest.getCommodityManager() == null) {
            throw new RuntimeException("Commodity Manager is mandatory");
        }

        List<Ta_Status> statusList =
                taStatusDao.findByTaStatusNameAndTaStatusActive(statusName, 1);

        if (statusList.isEmpty()) {
            throw new RuntimeException(statusName + " status not found");
        }

        toolRequest.setStatus(statusList.get(0));

        toolRequest.setCreatedBy(user);
        toolRequest.setInitiatedBy(user);
        toolRequest.setInitiatedOn(now);
        toolRequest.setRequestActive(1);
        toolRequest.setCreatedOn(now);

        requestDao.save(toolRequest);

        return "add";
    }

    @Override
    @Transactional
    public String updateToolRequest(HttpServletRequest request,
                                    Ta_Tool_Request toolRequest,
                                    String actionType) {

        M_User user = mUserDao.findByUserLoginId(
                SecurityContextHolder.getContext()
                        .getAuthentication()
                        .getName());

        Ta_Tool_Request existing =
                requestDao.findById(toolRequest.getTaToolRequestId())
                        .orElseThrow(() ->
                                new RuntimeException("Tool Request not found"));

        // Preserve immutable fields
        toolRequest.setRequestNumber(existing.getRequestNumber());
        toolRequest.setCreatedBy(existing.getCreatedBy());
        toolRequest.setCreatedOn(existing.getCreatedOn());
        toolRequest.setInitiatedBy(existing.getInitiatedBy());
        toolRequest.setInitiatedOn(existing.getInitiatedOn());
        toolRequest.setRequestActive(existing.getRequestActive());

        if (toolRequest.getCommodityManager() == null) {
            throw new RuntimeException("Commodity Manager is mandatory");
        }

        toolRequest.setUpdatedBy(user);
        toolRequest.setUpdatedOn(new Date());

        String statusName =
                "draft".equals(actionType)
                        ? "Draft"
                        : "Tool Details Entered";

        List<Ta_Status> statusList =
                taStatusDao.findByTaStatusNameAndTaStatusActive(statusName, 1);

        if (statusList.isEmpty()) {
            throw new RuntimeException(statusName + " status not found");
        }

        toolRequest.setStatus(statusList.get(0));

        requestDao.save(toolRequest);

        return "edit";
    }

    @Override
    public String getToolRequestDetails(HttpServletRequest request) {

        String idStr = request.getParameter("taToolRequestId");

        if (idStr == null) return "{}";

        Ta_Tool_Request tr =
                requestDao.findById(Long.parseLong(idStr)).orElse(null);

        Map<String, String> map = new HashMap<>();

        if (tr != null) {

            map.put("customerName", tr.getCustomerName());
            map.put("projectName", tr.getProjectName());
            map.put("peakAnnualVolume",
                    tr.getPeakAnnualVolume() != null ?
                            String.valueOf(tr.getPeakAnnualVolume()) : "");
        }

        return new Gson().toJson(map);
    }

    @Override
    public Ta_Tool_Request getToolRequestById(Long reqId) {

        if (reqId == null) {
            throw new IllegalArgumentException("Tool Request ID must not be null");
        }

        return requestDao.findById(reqId)
                .orElseThrow(() ->
                        new RuntimeException("Tool Request not found with ID: " + reqId));
    }

    @Override
    public List<Ta_Tool_Request> getAllToolRequestsForView(HttpServletRequest request) {
        return requestDao.findByRequestActive(1);
    }
}
