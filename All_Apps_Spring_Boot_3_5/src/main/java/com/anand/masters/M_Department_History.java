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
@Table(name = "m_department_history")
public class M_Department_History implements Comparable<M_Department_History> {

	@Override
	public int compareTo(M_Department_History departmentHistory) {
		return departmentHistory.getmDepartmentHistoryId() - this.mDepartmentHistoryId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_department_history_id",unique = true, nullable = false)
    private Integer mDepartmentHistoryId;

	@OneToOne
    @JoinColumn(name = "m_department_id", nullable = true)
    private M_Department mDepartmentId;

	@Column(name = "department_name")
    private String departmentName;

	@Column(name = "department_description")
    private String departmentDescription;

	@Column(name = "department_active")
    private Integer departmentActive;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	public Integer getmDepartmentHistoryId() {
		return mDepartmentHistoryId;
	}

	public void setmDepartmentHistoryId(Integer mDepartmentHistoryId) {
		this.mDepartmentHistoryId = mDepartmentHistoryId;
	}

	public M_Department getmDepartmentId() {
		return mDepartmentId;
	}

	public void setmDepartmentId(M_Department mDepartmentId) {
		this.mDepartmentId = mDepartmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getDepartmentDescription() {
		return departmentDescription;
	}

	public void setDepartmentDescription(String departmentDescription) {
		this.departmentDescription = departmentDescription;
	}

	public Integer getDepartmentActive() {
		return departmentActive;
	}

	public void setDepartmentActive(Integer departmentActive) {
		this.departmentActive = departmentActive;
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