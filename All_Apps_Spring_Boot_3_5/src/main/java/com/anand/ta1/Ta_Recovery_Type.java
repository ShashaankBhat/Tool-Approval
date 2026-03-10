package com.anand.ta1;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_recovery_type")
public class Ta_Recovery_Type implements Comparable<Ta_Recovery_Type> {

    @Override
    public int compareTo(Ta_Recovery_Type o) {
        return o.getTaRecoveryTypeId().compareTo(this.taRecoveryTypeId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_recovery_type_id", nullable = false)
    private Long taRecoveryTypeId;

    @Column(name = "ta_recovery_type_name")
    private String taRecoveryTypeName;

    @Column(name = "ta_recovery_type_description")
    private String taRecoveryTypeDescription;

    @Column(name = "ta_recovery_type_active")
    private Integer taRecoveryTypeActive;

    @OneToOne
    @JoinColumn(name = "created_by")
    private M_User createdBy;

    @Column(name = "created_on")
    private Date createdOn;

    @OneToOne
    @JoinColumn(name = "updated_by")
    private M_User updatedBy;

    @Column(name = "updated_on")
    private Date updatedOn;

    @Transient
    private String actionForList;

    /* Getters & Setters */

    public Long getTaRecoveryTypeId() {
        return taRecoveryTypeId;
    }

    public void setTaRecoveryTypeId(Long taRecoveryTypeId) {
        this.taRecoveryTypeId = taRecoveryTypeId;
    }

    public String getTaRecoveryTypeName() {
        return taRecoveryTypeName;
    }

    public void setTaRecoveryTypeName(String taRecoveryTypeName) {
        this.taRecoveryTypeName = taRecoveryTypeName;
    }

    public String getTaRecoveryTypeDescription() {
        return taRecoveryTypeDescription;
    }

    public void setTaRecoveryTypeDescription(String taRecoveryTypeDescription) {
        this.taRecoveryTypeDescription = taRecoveryTypeDescription;
    }

    public Integer getTaRecoveryTypeActive() {
        return taRecoveryTypeActive;
    }

    public void setTaRecoveryTypeActive(Integer taRecoveryTypeActive) {
        this.taRecoveryTypeActive = taRecoveryTypeActive;
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

    public String getActionForList() {
        return actionForList;
    }

    public void setActionForList(String actionForList) {
        this.actionForList = actionForList;
    }
}
