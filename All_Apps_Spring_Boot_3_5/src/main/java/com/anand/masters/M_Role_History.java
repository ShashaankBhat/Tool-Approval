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
@Table(name = "m_role_history")
public class M_Role_History implements Comparable<M_Role_History> {

	@Override
	public int compareTo(M_Role_History roleHistory) {
		return roleHistory.getmRoleHistoryId() - this.mRoleHistoryId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_role_history_id",unique = true, nullable = false)
    private Integer mRoleHistoryId;

	@OneToOne
    @JoinColumn(name = "m_role_id", nullable = true)
    private M_Role mRoleId;

	@Column(name = "role_name")
    private String roleName;

	@Column(name = "role_description")
    private String roleDescription;

	@Column(name = "role_active")
    private Integer roleActive;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	public Integer getmRoleHistoryId() {
		return mRoleHistoryId;
	}

	public void setmRoleHistoryId(Integer mRoleHistoryId) {
		this.mRoleHistoryId = mRoleHistoryId;
	}

	public M_Role getmRoleId() {
		return mRoleId;
	}

	public void setmRoleId(M_Role mRoleId) {
		this.mRoleId = mRoleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

	public Integer getRoleActive() {
		return roleActive;
	}

	public void setRoleActive(Integer roleActive) {
		this.roleActive = roleActive;
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