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
@Table(name = "m_user_role_map_history")
public class M_User_Role_Map_History {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_user_role_map_history_id",unique = true, nullable = false)
    private Integer mUserRoleMapHistoryId;

	@OneToOne
    @JoinColumn(name="m_user_role_map_id", nullable=true)
    private M_User_Role_Map mUserRoleMapId;

	@OneToOne
    @JoinColumn(name="m_user_history_id", nullable=true)
    private M_User_History mUserHistoryId;

	@OneToOne
    @JoinColumn(name = "m_role_id", nullable = true)
	private M_Role mRoleId;

	@Column(name="user_role_active")
	private Integer userRoleActive;

	@Column(name="user_role_created_on")
	private Date userRoleCreatedOn;

	@OneToOne
    @JoinColumn(name = "user_role_created_by", nullable = true)
	private M_User userRoleCreatedBy;

	public Integer getmUserRoleMapHistoryId() {
		return mUserRoleMapHistoryId;
	}

	public void setmUserRoleMapHistoryId(Integer mUserRoleMapHistoryId) {
		this.mUserRoleMapHistoryId = mUserRoleMapHistoryId;
	}

	public M_User_Role_Map getmUserRoleMapId() {
		return mUserRoleMapId;
	}

	public void setmUserRoleMapId(M_User_Role_Map mUserRoleMapId) {
		this.mUserRoleMapId = mUserRoleMapId;
	}

	public M_User_History getmUserHistoryId() {
		return mUserHistoryId;
	}

	public void setmUserHistoryId(M_User_History mUserHistoryId) {
		this.mUserHistoryId = mUserHistoryId;
	}

	public M_Role getmRoleId() {
		return mRoleId;
	}

	public void setmRoleId(M_Role mRoleId) {
		this.mRoleId = mRoleId;
	}

	public Integer getUserRoleActive() {
		return userRoleActive;
	}

	public void setUserRoleActive(Integer userRoleActive) {
		this.userRoleActive = userRoleActive;
	}

	public Date getUserRoleCreatedOn() {
		return userRoleCreatedOn;
	}

	public void setUserRoleCreatedOn(Date userRoleCreatedOn) {
		this.userRoleCreatedOn = userRoleCreatedOn;
	}

	public M_User getUserRoleCreatedBy() {
		return userRoleCreatedBy;
	}

	public void setUserRoleCreatedBy(M_User userRoleCreatedBy) {
		this.userRoleCreatedBy = userRoleCreatedBy;
	}
}