package com.anand.ta1;

import java.util.Date;
import jakarta.persistence.*;
import com.anand.masters.M_User;

@Entity
@Table(name = "ta_status_history")
public class Ta_Status_History implements Comparable<Ta_Status_History> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_status_history_id")
    private Long taStatusHistoryId;

    @ManyToOne
    @JoinColumn(name = "ta_status_id", nullable = false)
    private Ta_Status taStatus;

    @Column(name = "ta_status_name", nullable = false)
    private String taStatusName;

    @Column(name = "ta_status_description")
    private String taStatusDescription;

    @Column(name = "ta_status_active", nullable = false)
    private Integer taStatusActive;

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


    @Override
    public int compareTo(Ta_Status_History other) {
        return Long.compare(other.taStatusHistoryId, this.taStatusHistoryId);
    }

    // Getters & Setters (auto-generated)
    public Long getTaStatusHistoryId() { return taStatusHistoryId; }
    public void setTaStatusHistoryId(Long taStatusHistoryId) { this.taStatusHistoryId = taStatusHistoryId; }

    public Ta_Status getTaStatus() { return taStatus; }
    public void setTaStatus(Ta_Status taStatus) { this.taStatus = taStatus; }

    public String getTaStatusName() { return taStatusName; }
    public void setTaStatusName(String taStatusName) { this.taStatusName = taStatusName; }

    public String getTaStatusDescription() { return taStatusDescription; }
    public void setTaStatusDescription(String taStatusDescription) { this.taStatusDescription = taStatusDescription; }

    public Integer getTaStatusActive() { return taStatusActive; }
    public void setTaStatusActive(Integer taStatusActive) { this.taStatusActive = taStatusActive; }

    public M_User getCreatedBy() { return createdBy; }
    public void setCreatedBy(M_User createdBy) { this.createdBy = createdBy; }

    public Date getCreatedOn() { return createdOn; }
    public void setCreatedOn(Date createdOn) { this.createdOn = createdOn; }

    public M_User getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(M_User updatedBy) { this.updatedBy = updatedBy; }

    public Date getUpdatedOn() { return updatedOn; }
    public void setUpdatedOn(Date updatedOn) { this.updatedOn = updatedOn; }

}
