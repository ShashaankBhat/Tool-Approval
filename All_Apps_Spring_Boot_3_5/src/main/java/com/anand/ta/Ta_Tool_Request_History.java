package com.anand.ta;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_Entity;
import com.anand.masters.M_User;
import com.anand.ta1.Ta_Business_Unit;
import com.anand.ta1.Ta_Recovery_Type;
import com.anand.ta1.Ta_Status;

@Entity
@Table(name = "ta_tool_request_history")
public class Ta_Tool_Request_History {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_tool_request_history_id")
    private Long taToolRequestHistoryId;

    @ManyToOne
    @JoinColumn(name = "ta_tool_request_id", nullable = false)
    private Ta_Tool_Request toolRequest;

    @Column(name = "request_number", nullable = false)
    private String requestNumber;

    @ManyToOne
    @JoinColumn(name = "entity_id", nullable = false)
    private M_Entity entity;

    @ManyToOne
    @JoinColumn(name = "ta_business_unit_id", nullable = false)
    private Ta_Business_Unit businessUnit;

    @Column(name = "customer_name")
    private String customerName;

    @Column(name = "project_name")
    private String projectName;

    @Column(name = "sop_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date sopDate;

    @Column(name = "peak_annual_volume")
    private Integer peakAnnualVolume;

    @ManyToOne
    @JoinColumn(name = "ta_recovery_type_id")
    private Ta_Recovery_Type recoveryType;

    @ManyToOne
    @JoinColumn(name = "ta_status_id", nullable = false)
    private Ta_Status status;

    @ManyToOne
    @JoinColumn(name = "initiated_by", nullable = false)
    private M_User initiatedBy;

    @Column(name = "initiated_on", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date initiatedOn;

    @ManyToOne
    @JoinColumn(name = "current_approver_user_id")
    private M_User currentApproverUser;

    @Column(name = "request_active", nullable = false)
    private Integer requestActive;

    @ManyToOne
    @JoinColumn(name = "created_by", nullable = false)
    private M_User createdBy;

    @Column(name = "created_on", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;

    @ManyToOne
    @JoinColumn(name = "updated_by")
    private M_User updatedBy;

    @Column(name = "updated_on")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedOn;

    /* ================= GETTERS & SETTERS ================= */

    public Long getTaToolRequestHistoryId() {
        return taToolRequestHistoryId;
    }

    public void setTaToolRequestHistoryId(Long taToolRequestHistoryId) {
        this.taToolRequestHistoryId = taToolRequestHistoryId;
    }

    public Ta_Tool_Request getToolRequest() {
        return toolRequest;
    }

    public void setToolRequest(Ta_Tool_Request toolRequest) {
        this.toolRequest = toolRequest;
    }

    public String getRequestNumber() {
        return requestNumber;
    }

    public void setRequestNumber(String requestNumber) {
        this.requestNumber = requestNumber;
    }

    public M_Entity getEntity() {
        return entity;
    }

    public void setEntity(M_Entity entity) {
        this.entity = entity;
    }

    public Ta_Business_Unit getBusinessUnit() {
        return businessUnit;
    }

    public void setBusinessUnit(Ta_Business_Unit businessUnit) {
        this.businessUnit = businessUnit;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public Date getSopDate() {
        return sopDate;
    }

    public void setSopDate(Date sopDate) {
        this.sopDate = sopDate;
    }

    public Integer getPeakAnnualVolume() {
        return peakAnnualVolume;
    }

    public void setPeakAnnualVolume(Integer peakAnnualVolume) {
        this.peakAnnualVolume = peakAnnualVolume;
    }

    public Ta_Recovery_Type getRecoveryType() {
        return recoveryType;
    }

    public void setRecoveryType(Ta_Recovery_Type recoveryType) {
        this.recoveryType = recoveryType;
    }

    public Ta_Status getStatus() {
        return status;
    }

    public void setStatus(Ta_Status status) {
        this.status = status;
    }

    public M_User getInitiatedBy() {
        return initiatedBy;
    }

    public void setInitiatedBy(M_User initiatedBy) {
        this.initiatedBy = initiatedBy;
    }

    public Date getInitiatedOn() {
        return initiatedOn;
    }

    public void setInitiatedOn(Date initiatedOn) {
        this.initiatedOn = initiatedOn;
    }

    public M_User getCurrentApproverUser() {
        return currentApproverUser;
    }

    public void setCurrentApproverUser(M_User currentApproverUser) {
        this.currentApproverUser = currentApproverUser;
    }

    public Integer getRequestActive() {
        return requestActive;
    }

    public void setRequestActive(Integer requestActive) {
        this.requestActive = requestActive;
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
