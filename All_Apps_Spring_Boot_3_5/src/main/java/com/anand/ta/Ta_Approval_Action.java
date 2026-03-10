package com.anand.ta;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_approval_action")
public class Ta_Approval_Action {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_approval_action_id")
    private Long taApprovalActionId;

    @ManyToOne
    @JoinColumn(name = "ta_tool_request_id", nullable = false)
    private Ta_Tool_Request toolRequest;

    @ManyToOne
    @JoinColumn(name = "approver_user_id", nullable = false)
    private M_User approverUser;

    @Column(name = "action_code", nullable = false)
    private Integer actionCode;

    @Column(name = "approval_remark")
    private String approvalRemark;

    @Column(name = "action_on", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date actionOn;

    @Column(name = "action_active", nullable = false)
    private Integer actionActive;

    @ManyToOne
    @JoinColumn(name = "created_by", nullable = false)
    private M_User createdBy;

    @Column(name = "created_on", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;

    /* ================= GETTERS & SETTERS ================= */

    public Long getTaApprovalActionId() {
        return taApprovalActionId;
    }

    public void setTaApprovalActionId(Long taApprovalActionId) {
        this.taApprovalActionId = taApprovalActionId;
    }

    public Ta_Tool_Request getToolRequest() {
        return toolRequest;
    }

    public void setToolRequest(Ta_Tool_Request toolRequest) {
        this.toolRequest = toolRequest;
    }

    public M_User getApproverUser() {
        return approverUser;
    }

    public void setApproverUser(M_User approverUser) {
        this.approverUser = approverUser;
    }

    public Integer getActionCode() {
        return actionCode;
    }

    public void setActionCode(Integer actionCode) {
        this.actionCode = actionCode;
    }

    public String getApprovalRemark() {
        return approvalRemark;
    }

    public void setApprovalRemark(String approvalRemark) {
        this.approvalRemark = approvalRemark;
    }

    public Date getActionOn() {
        return actionOn;
    }

    public void setActionOn(Date actionOn) {
        this.actionOn = actionOn;
    }

    public Integer getActionActive() {
        return actionActive;
    }

    public void setActionActive(Integer actionActive) {
        this.actionActive = actionActive;
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
