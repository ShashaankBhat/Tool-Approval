package com.anand.ta;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_tool_cost_details_history")
public class Ta_Tool_Cost_Details_History {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_tool_cost_details_history_id")
    private Long taToolCostDetailsHistoryId;

    @ManyToOne
    @JoinColumn(name = "ta_tool_cost_details_id")
    private Ta_Tool_Cost_Details costDetails;

    @ManyToOne
    @JoinColumn(name = "ta_tool_request_id")
    private Ta_Tool_Request toolRequest;

    @Column(name = "cost_head")
    private String costHead;

    @Column(name = "cost_amount")
    private Double costAmount;

    @Column(name = "remarks")
    private String remarks;

    @Column(name = "cost_active")
    private Integer costActive;

    @ManyToOne
    @JoinColumn(name = "created_by")
    private M_User createdBy;

    @Column(name = "created_on")
    private Date createdOn;

    /* ================= GETTERS & SETTERS ================= */

    public Long getTaToolCostDetailsHistoryId() {
        return taToolCostDetailsHistoryId;
    }

    public void setTaToolCostDetailsHistoryId(Long taToolCostDetailsHistoryId) {
        this.taToolCostDetailsHistoryId = taToolCostDetailsHistoryId;
    }

    public Ta_Tool_Cost_Details getCostDetails() {
        return costDetails;
    }

    public void setCostDetails(Ta_Tool_Cost_Details costDetails) {
        this.costDetails = costDetails;
    }

    public Ta_Tool_Request getToolRequest() {
        return toolRequest;
    }

    public void setToolRequest(Ta_Tool_Request toolRequest) {
        this.toolRequest = toolRequest;
    }

    public String getCostHead() {
        return costHead;
    }

    public void setCostHead(String costHead) {
        this.costHead = costHead;
    }

    public Double getCostAmount() {
        return costAmount;
    }

    public void setCostAmount(Double costAmount) {
        this.costAmount = costAmount;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Integer getCostActive() {
        return costActive;
    }

    public void setCostActive(Integer costActive) {
        this.costActive = costActive;
    }

    public M_User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(M_User createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }
}
