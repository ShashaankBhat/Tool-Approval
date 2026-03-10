package com.anand.ta;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_tool_cost_details")
public class Ta_Tool_Cost_Details implements Comparable<Ta_Tool_Cost_Details> {

    @Override
    public int compareTo(Ta_Tool_Cost_Details o) {
        return Long.compare(o.taToolCostDetailsId, this.taToolCostDetailsId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_tool_cost_details_id")
    private Long taToolCostDetailsId;

    @ManyToOne
    @JoinColumn(name = "ta_tool_request_id")
    private Ta_Tool_Request toolRequest;

    /* Legacy fields (preserved) */
    @Column(name = "cost_head")
    private String costHead;

    @Column(name = "cost_amount")
    private Double costAmount;

    @Column(name = "remarks")
    private String remarks;

    /* New/expected fields used by JSPs and forms */
    @Column(name = "tool_part_number")
    private String toolPartNumber;

    @Column(name = "part_description")
    private String partDescription;

    @Column(name = "currency")
    private String currency;

    @Column(name = "quoted_cost")
    private Double quotedCost;

    @Column(name = "negotiated_cost")
    private Double negotiatedCost;

    @Column(name = "upfront_cost")
    private Double upfrontCost;

    @Column(name = "amortization_cost")
    private String amortizationCost;

    @Column(name = "supplier_name")
    private String supplierName;

    @Column(name = "development_lead_time")
    private String developmentLeadTime;

    @Column(name = "cost_active")
    private Integer costActive;

    @ManyToOne
    @JoinColumn(name = "created_by")
    private M_User createdBy;

    @Column(name = "created_on")
    private Date createdOn;

    @ManyToOne
    @JoinColumn(name = "updated_by")
    private M_User updatedBy;

    @Column(name = "updated_on")
    private Date updatedOn;

    /* ================= GETTERS & SETTERS ================= */

    public Long getTaToolCostDetailsId() {
        return taToolCostDetailsId;
    }

    public void setTaToolCostDetailsId(Long taToolCostDetailsId) {
        this.taToolCostDetailsId = taToolCostDetailsId;
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

    public String getToolPartNumber() {
        return toolPartNumber;
    }

    public void setToolPartNumber(String toolPartNumber) {
        this.toolPartNumber = toolPartNumber;
    }

    public String getPartDescription() {
        return partDescription;
    }

    public void setPartDescription(String partDescription) {
        this.partDescription = partDescription;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public Double getQuotedCost() {
        return quotedCost;
    }

    public void setQuotedCost(Double quotedCost) {
        this.quotedCost = quotedCost;
    }

    public Double getNegotiatedCost() {
        return negotiatedCost;
    }

    public void setNegotiatedCost(Double negotiatedCost) {
        this.negotiatedCost = negotiatedCost;
    }

    public Double getUpfrontCost() {
        return upfrontCost;
    }

    public void setUpfrontCost(Double upfrontCost) {
        this.upfrontCost = upfrontCost;
    }

    public String getAmortizationCost() {
        return amortizationCost;
    }

    public void setAmortizationCost(String amortizationCost) {
        this.amortizationCost = amortizationCost;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getDevelopmentLeadTime() {
        return developmentLeadTime;
    }

    public void setDevelopmentLeadTime(String developmentLeadTime) {
        this.developmentLeadTime = developmentLeadTime;
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

    public M_User getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(M_User updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(Date updatedOn) {
        this.updatedOn = updatedOn;
    }
}
