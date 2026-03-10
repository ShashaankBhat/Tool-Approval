package com.anand.ta;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
public class Ta_Dashboard_Service_Impl implements Ta_Dashboard_Service {

    @Autowired
    private Ta_Tool_Request_Dao toolRequestDao;

    @Autowired
    private Ta_Tool_Cost_Details_Dao toolCostDetailsDao;

    /* ================= STATUS COUNT ================= */

    @Override
    public Map<String, Long> getRequestCountByStatus(HttpServletRequest request) {

        Map<String, Long> statusCounts = new HashMap<>();
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();

        for (Ta_Tool_Request req : allRequests) {

            if (req.getStatus() != null) {

                String statusName = req.getStatus().getTaStatusName();

                statusCounts.put(
                        statusName,
                        statusCounts.getOrDefault(statusName, 0L) + 1
                );
            }
        }

        return statusCounts;
    }

    /* ================= PENDING BY ROLE ================= */

    @Override
    public Map<String, Long> getPendingApprovalsByRole(HttpServletRequest request) {

        Map<String, Long> pendingByRole = new HashMap<>();
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();

        for (Ta_Tool_Request req : allRequests) {

            if (req.getStatus() != null
                    && "Submitted".equalsIgnoreCase(req.getStatus().getTaStatusName())
                    && req.getCurrentApproverUser() != null) {

                String roleName = req.getCurrentApproverUser().getUserFirstName();

                pendingByRole.put(
                        roleName,
                        pendingByRole.getOrDefault(roleName, 0L) + 1
                );
            }
        }

        return pendingByRole;
    }

    /* ================= PENDING FOR ROLE ================= */

    @Override
    public List<Ta_Tool_Request> getPendingRequestsForUser(Long roleId) {

        List<Ta_Tool_Request> pending = new ArrayList<>();
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();

        for (Ta_Tool_Request req : allRequests) {

            if (req.getStatus() != null
                    && "Submitted".equalsIgnoreCase(req.getStatus().getTaStatusName())
                    && req.getCurrentApproverUser() != null
                    && req.getCurrentApproverUser().getmUserId().equals(roleId)) {

                pending.add(req);
            }
        }

        return pending;
    }

    /* ================= TURNAROUND ================= */

    @Override
    public Map<String, Double> getApprovalTurnaroundMetrics(HttpServletRequest request) {

        Map<String, Double> metrics = new HashMap<>();
        List<Long> turnaroundTimes = new ArrayList<>();
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();

        for (Ta_Tool_Request req : allRequests) {

            if (req.getStatus() != null
                    && "Approved".equalsIgnoreCase(req.getStatus().getTaStatusName())
                    && req.getCreatedOn() != null
                    && req.getUpdatedOn() != null) {

                long days = ChronoUnit.DAYS.between(
                        req.getCreatedOn().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate(),
                        req.getUpdatedOn().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate()
                );

                turnaroundTimes.add(days);
            }
        }

        metrics.put("avgTurnaroundDays",
                turnaroundTimes.isEmpty() ? 0.0 :
                        turnaroundTimes.stream().mapToLong(Long::longValue).average().orElse(0.0));

        return metrics;
    }

    /* ================= APPROVAL RATE ================= */

    @Override
    public Map<String, Object> getApprovalRateMetrics(HttpServletRequest request) {

        Map<String, Object> metrics = new HashMap<>();
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();

        long total = allRequests.size();
        long approved = allRequests.stream()
                .filter(r -> r.getStatus() != null
                        && "Approved".equalsIgnoreCase(r.getStatus().getTaStatusName()))
                .count();

        long rejected = allRequests.stream()
                .filter(r -> r.getStatus() != null
                        && "Rejected".equalsIgnoreCase(r.getStatus().getTaStatusName()))
                .count();

        metrics.put("totalRequests", total);
        metrics.put("approvedRequests", approved);
        metrics.put("rejectedRequests", rejected);
        metrics.put("approvalRate", total > 0 ? (approved * 100.0) / total : 0.0);

        return metrics;
    }

    @Override
    public List<Ta_Tool_Request> getAllActiveRequests() {
        return toolRequestDao.findByRequestActive(1);
    }

    @Override
    public Ta_Tool_Request getToolRequestById(Long id) {
        return toolRequestDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Tool Request not found"));
    }

    @Override
    public List<Ta_Tool_Cost_Details> getCostDetailsForRequest(Long id) {
        return toolCostDetailsDao.findByToolRequest_TaToolRequestId(id);
    }

    @Override
    public List<Ta_Tool_Request> getRequestsByDateRange(Date fromDate, Date toDate) {
        List<Ta_Tool_Request> result = new ArrayList<>();
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();

        for (Ta_Tool_Request req : allRequests) {
            if (req.getCreatedOn() != null
                    && !req.getCreatedOn().before(fromDate)
                    && !req.getCreatedOn().after(toDate)) {
                result.add(req);
            }
        }

        return result;
    }

    @Override
    public List<Ta_Tool_Request> getRequestsByEntity(Long entityId) {
        List<Ta_Tool_Request> result = new ArrayList<>();
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();

        for (Ta_Tool_Request req : allRequests) {
            if (req.getEntity() != null
                    && req.getEntity().getmEntityId().equals(entityId)) {
                result.add(req);
            }
        }

        return result;
    }

    @Override
    public Double getAverageApprovalTime() {
        List<Ta_Tool_Request> allRequests = toolRequestDao.findAll();
        List<Long> turnaroundTimes = new ArrayList<>();

        for (Ta_Tool_Request req : allRequests) {
            if (req.getStatus() != null
                    && "Approved".equalsIgnoreCase(req.getStatus().getTaStatusName())
                    && req.getCreatedOn() != null
                    && req.getUpdatedOn() != null) {

                long days = ChronoUnit.DAYS.between(
                        req.getCreatedOn().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate(),
                        req.getUpdatedOn().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate()
                );

                turnaroundTimes.add(days);
            }
        }

        return turnaroundTimes.isEmpty() ? 0.0 :
                turnaroundTimes.stream().mapToLong(Long::longValue).average().orElse(0.0);
    }
}
