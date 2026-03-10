package com.anand.masters;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "m_user_role_map")
public class M_User_Role_Map {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_user_role_map_id",unique = true, nullable = false)
    private Long mUserRoleMapId;

	@ManyToOne
    @JoinColumn(name="m_user_id", nullable=true)
    private M_User userInfoForRole;

	@OneToOne
    @JoinColumn(name = "m_role_id", nullable = true)
	private M_Role roleInfoForUsers;

	@Column(name="user_role_active")
	private Integer userRoleActive;

	@Column(name="user_role_created_on")
	private Date userRoleCreatedOn;

	@OneToOne
    @JoinColumn(name = "user_role_created_by", nullable = true)
	private M_User userRoleCreatedBy;

	public Long getmUserRoleMapId() {
		return mUserRoleMapId;
	}

	public void setmUserRoleMapId(Long mUserRoleMapId) {
		this.mUserRoleMapId = mUserRoleMapId;
	}

	public M_User getUserInfoForRole() {
		return userInfoForRole;
	}

	public void setUserInfoForRole(M_User userInfoForRole) {
		this.userInfoForRole = userInfoForRole;
	}

	public M_Role getRoleInfoForUsers() {
		return roleInfoForUsers;
	}

	public void setRoleInfoForUsers(M_Role roleInfoForUsers) {
		this.roleInfoForUsers = roleInfoForUsers;
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