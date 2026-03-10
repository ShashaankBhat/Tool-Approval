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
@Table(name = "m_user_app_map")
public class M_User_App_Map implements Comparable<M_User_App_Map> {

	@Override
	public int compareTo(M_User_App_Map userAppMap) {
		// TODO Auto-generated method stub
		return Integer.parseInt(""+userAppMap.appInfoForUsers.getmAppId()) - Integer.parseInt(""+this.appInfoForUsers.getmAppId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_user_app_map_id",unique = true, nullable = false)
    private Long mUserAppMapId;

	@ManyToOne
    @JoinColumn(name="m_user_id", nullable=true)
    private M_User userInfoForApp;

	@OneToOne
    @JoinColumn(name = "m_app_id", nullable = true)
	private M_App appInfoForUsers;

	@Column(name="user_app_active")
	private Integer userAppActive;

	@Column(name="user_app_created_on")
	private Date userAppCreatedOn;

	@OneToOne
    @JoinColumn(name = "user_app_created_by", nullable = true)
	private M_User userAppCreatedBy;

	public Long getmUserAppMapId() {
		return mUserAppMapId;
	}

	public void setmUserAppMapId(Long mUserAppMapId) {
		this.mUserAppMapId = mUserAppMapId;
	}

	public M_User getUserInfoForApp() {
		return userInfoForApp;
	}

	public void setUserInfoForApp(M_User userInfoForApp) {
		this.userInfoForApp = userInfoForApp;
	}

	public M_App getAppInfoForUsers() {
		return appInfoForUsers;
	}

	public void setAppInfoForUsers(M_App appInfoForUsers) {
		this.appInfoForUsers = appInfoForUsers;
	}

	public Integer getUserAppActive() {
		return userAppActive;
	}

	public void setUserAppActive(Integer userAppActive) {
		this.userAppActive = userAppActive;
	}

	public Date getUserAppCreatedOn() {
		return userAppCreatedOn;
	}

	public void setUserAppCreatedOn(Date userAppCreatedOn) {
		this.userAppCreatedOn = userAppCreatedOn;
	}

	public M_User getUserAppCreatedBy() {
		return userAppCreatedBy;
	}

	public void setUserAppCreatedBy(M_User userAppCreatedBy) {
		this.userAppCreatedBy = userAppCreatedBy;
	}
}