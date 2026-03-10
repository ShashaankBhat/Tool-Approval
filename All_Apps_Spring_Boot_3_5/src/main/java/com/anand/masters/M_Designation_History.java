package com.anand.masters;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "m_designation_history")
public class M_Designation_History implements Comparable<M_Designation_History> {

	@Override
	public int compareTo(M_Designation_History designationHistory) {
		return designationHistory.getmDesignationHistoryId() - this.mDesignationHistoryId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_designation_history_id",unique = true, nullable = false)
    private Integer mDesignationHistoryId;

	@OneToOne
    @JoinColumn(name = "m_designation_id", nullable = true)
    private M_Designation mDesignationId;

	@Column(name = "designation_name")
    private String designationName;

	@Column(name = "designation_active")
    private Integer designationActive;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	public Integer getmDesignationHistoryId() {
		return mDesignationHistoryId;
	}

	public void setmDesignationHistoryId(Integer mDesignationHistoryId) {
		this.mDesignationHistoryId = mDesignationHistoryId;
	}

	public M_Designation getmDesignationId() {
		return mDesignationId;
	}

	public void setmDesignationId(M_Designation mDesignationId) {
		this.mDesignationId = mDesignationId;
	}

	public String getDesignationName() {
		return designationName;
	}

	public void setDesignationName(String designationName) {
		this.designationName = designationName;
	}

	public Integer getDesignationActive() {
		return designationActive;
	}

	public void setDesignationActive(Integer designationActive) {
		this.designationActive = designationActive;
	}

	public M_User getmUserId() {
		return mUserId;
	}

	public void setmUserId(M_User mUserId) {
		this.mUserId = mUserId;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}
}