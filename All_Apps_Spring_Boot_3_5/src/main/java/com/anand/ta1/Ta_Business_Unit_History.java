package com.anand.ta1;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_business_unit_history")
public class Ta_Business_Unit_History
        implements Comparable<Ta_Business_Unit_History> {

    /* =========================
       SORTING (LATEST FIRST)
       ========================= */
    @Override
    public int compareTo(Ta_Business_Unit_History h) {
        return Long.compare(h.getTaBusinessUnitHistoryId(), this.taBusinessUnitHistoryId);
    }

    /* =========================
       PRIMARY KEY
       ========================= */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_business_unit_history_id", nullable = false)
    private Long taBusinessUnitHistoryId;

    /* =========================
       RELATION TO MAIN TABLE
       ========================= */
    @OneToOne
    @JoinColumn(name = "ta_business_unit_id", nullable = false)
    private Ta_Business_Unit taBusinessUnit;
    
    /* =========================
       SNAPSHOT FIELDS
       ========================= */
    @Column(name = "ta_business_unit_name", nullable = false)
    private String businessUnitName;

    @Column(name = "ta_business_unit_description")
    private String businessUnitDescription;

    @Column(name = "ta_business_unit_active", nullable = false)
    private Integer businessUnitActive;

    /* =========================
       AUDIT FIELDS
       ========================= */
    @OneToOne
    @JoinColumn(name = "created_by", nullable = false)
    private M_User createdBy;

    @Column(name = "created_on", nullable = false)
    private Date createdOn;

    @OneToOne
    @JoinColumn(name = "updated_by")
    private M_User updatedBy;

    @Column(name = "updated_on")
    private Date updatedOn;

    /* =========================
       GETTERS & SETTERS
       ========================= */

    public Long getTaBusinessUnitHistoryId() {
        return taBusinessUnitHistoryId;
    }

    public void setTaBusinessUnitHistoryId(Long taBusinessUnitHistoryId) {
        this.taBusinessUnitHistoryId = taBusinessUnitHistoryId;
    }
    
    public Ta_Business_Unit getTaBusinessUnit() {
        return taBusinessUnit;
    }

    public void setTaBusinessUnit(Ta_Business_Unit taBusinessUnit) {
        this.taBusinessUnit = taBusinessUnit;
    }

    public String getBusinessUnitName() {
        return businessUnitName;
    }

    public void setBusinessUnitName(String businessUnitName) {
        this.businessUnitName = businessUnitName;
    }

    public String getBusinessUnitDescription() {
        return businessUnitDescription;
    }

    public void setBusinessUnitDescription(String businessUnitDescription) {
        this.businessUnitDescription = businessUnitDescription;
    }

    public Integer getBusinessUnitActive() {
        return businessUnitActive;
    }

    public void setBusinessUnitActive(Integer businessUnitActive) {
        this.businessUnitActive = businessUnitActive;
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
