package com.anand.ta;

import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Dao;
import com.anand.ta1.Ta_Status;
import com.anand.ta1.Ta_Status_Dao;

@Service
public class Ta_Tool_Cost_Details_Service_Impl
        implements Ta_Tool_Cost_Details_Service {

    @Autowired
    private Ta_Tool_Cost_Details_Dao costDao;

    @Autowired
    private Ta_Tool_Request_Dao toolRequestDao;

    @Autowired
    private Ta_Status_Dao taStatusDao;

    @Autowired
    private M_User_Dao mUserDao;

    /* =====================================================
       SAVE COST DETAILS + STATUS TRANSITION
       ===================================================== */
    @Override
    @Transactional
    public String saveCostDetails(HttpServletRequest request,
                                  Long toolRequestId,
                                  List<Ta_Tool_Cost_Details> costDetailsList,
                                  String actionType) {

        System.out.println("DEBUG COST LIST SIZE: " +
                (costDetailsList == null ? "NULL" : costDetailsList.size()));

        /* ---------- USER & TIME ---------- */

        M_User user = mUserDao.findByUserLoginId(
                SecurityContextHolder.getContext()
                        .getAuthentication()
                        .getName());

        Date now = new Date();

        Ta_Tool_Request toolRequest = toolRequestDao.findById(toolRequestId)
                .orElseThrow(() -> new RuntimeException("Tool Request not found"));

        /* ---------- DELETE OLD COST ROWS (Draft Overwrite Logic) ---------- */

        List<Ta_Tool_Cost_Details> existingRows =
                costDao.findByToolRequest_TaToolRequestId(toolRequestId);

        if (existingRows != null && !existingRows.isEmpty()) {
            costDao.deleteAll(existingRows);
        }

        /* ---------- SAVE NEW COST ROWS ---------- */

        if (costDetailsList != null && !costDetailsList.isEmpty()) {

            for (Ta_Tool_Cost_Details row : costDetailsList) {

                if (row == null) {
                    continue;
                }

                if (row.getToolPartNumber() == null ||
                    row.getToolPartNumber().trim().isEmpty()) {
                    continue;
                }

                row.setToolRequest(toolRequest);
                row.setCostActive(1);
                row.setCreatedBy(user);
                row.setCreatedOn(now);
                row.setUpdatedBy(null);
                row.setUpdatedOn(null);

                costDao.save(row);
            }
        }


        String statusName = "draft".equals(actionType)
                ? "Cost Entered"
                : "Pending";

        List<Ta_Status> statusList =
                taStatusDao.findByTaStatusNameAndTaStatusActive(statusName, 1);

        if (statusList.isEmpty()) {
            throw new RuntimeException(statusName + " status not found");
        }

        toolRequest.setStatus(statusList.get(0));
        toolRequest.setUpdatedBy(user);
        toolRequest.setUpdatedOn(now);

        toolRequestDao.save(toolRequest);

        return "success";
    }

    /* =====================================================
       FETCH COST DETAILS BY REQUEST ID
       ===================================================== */
    @Override
    public List<Ta_Tool_Cost_Details> getCostDetails(Long taToolRequestId) {
        return costDao.findByToolRequest_TaToolRequestId(taToolRequestId);
    }
}
