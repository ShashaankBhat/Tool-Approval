package com.anand.ta1;

import java.util.Date;

import jakarta.persistence.*;

import com.anand.masters.M_User;

@Entity
@Table(name = "ta_recovery_type_history")
public class Ta_Recovery_Type_History implements Comparable<Ta_Recovery_Type_History> {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_recovery_type_history_id")
    private Long taRecoveryTypeHistoryId;

    @ManyToOne
    @JoinColumn(name = "ta_recovery_type_id", nullable = false)
    private Ta_Recovery_Type taRecoveryType;

    @Column(name = "ta_recovery_type_name", nullable = false)
    private String taRecoveryTypeName;

    @Column(name = "ta_recovery_type_description")
    private String taRecoveryTypeDescription;

    @Column(name = "ta_recovery_type_active", nullable = false)
    private Integer taRecoveryTypeActive;


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

    /* Getters & Setters */

    public Long getTaRecoveryTypeHistoryId() {
        return taRecoveryTypeHistoryId;
    }

    public void setTaRecoveryTypeHistoryId(Long taRecoveryTypeHistoryId) {
        this.taRecoveryTypeHistoryId = taRecoveryTypeHistoryId;
    }

    public Ta_Recovery_Type getTaRecoveryType() {
        return taRecoveryType;
    }

    public void setTaRecoveryType(Ta_Recovery_Type taRecoveryType) {
        this.taRecoveryType = taRecoveryType;
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

    @Override
    public int compareTo(Ta_Recovery_Type_History o) {
        return o.getTaRecoveryTypeHistoryId()
            .compareTo(this.taRecoveryTypeHistoryId);
}

}
