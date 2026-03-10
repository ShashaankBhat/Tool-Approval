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
import jakarta.persistence.Transient;

@Entity
@Table(name = "m_designation")
public class M_Designation implements Comparable<M_Designation> {

	@Override
	public int compareTo(M_Designation designation) {
		return Integer.parseInt(""+designation.getmDesignationId()) - Integer.parseInt(""+this.mDesignationId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_designation_id",unique = true, nullable = false)
    private Long mDesignationId;

	@Column(name = "designation_name")
    private String designationName;

	@Column(name = "designation_active")
    private Integer designationActive;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	@OneToOne
    @JoinColumn(name = "m_user_id_update", nullable = true)
    private M_User mUserIdUpdate;

	@Column(name = "updated_on")
    private Date updatedOn;

	public Long getmDesignationId() {
		return mDesignationId;
	}

	public void setmDesignationId(Long mDesignationId) {
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

	public M_User getmUserIdUpdate() {
		return mUserIdUpdate;
	}

	public void setmUserIdUpdate(M_User mUserIdUpdate) {
		this.mUserIdUpdate = mUserIdUpdate;
	}

	public Date getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

	@Transient private String actionForList;

	public String getActionForList() {
		return actionForList;
	}

	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}