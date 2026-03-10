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
@Table(name = "m_app_history")
public class M_App_History implements Comparable<M_App_History> {

	@Override
	public int compareTo(M_App_History appHistory) {
		return Integer.parseInt(""+appHistory.getmAppHistoryId()) - Integer.parseInt(""+this.mAppHistoryId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_app_history_id",unique = true, nullable = false)
    private Long mAppHistoryId;

	@OneToOne
    @JoinColumn(name = "m_app_id", nullable = true)
    private M_App mAppId;

	@Column(name = "app_name")
    private String appName;

	@Column(name = "app_description")
    private String appDescription;

	@Column(name = "app_description_2")
    private String appDescription2;

	@Column(name = "app_link")
    private String appLink;

	@Column(name = "app_icon")
    private String appIcon;

	@Column(name = "app_active")
    private Integer appActive;

	@OneToOne
    @JoinColumn(name = "app_history_created_by", nullable = true)
    private M_User mUserId;

	@Column(name = "app_history_created_on")
    private Date createdOn;

	public Long getmAppHistoryId() {
		return mAppHistoryId;
	}

	public void setmAppHistoryId(Long mAppHistoryId) {
		this.mAppHistoryId = mAppHistoryId;
	}

	public M_App getmAppId() {
		return mAppId;
	}

	public void setmAppId(M_App mAppId) {
		this.mAppId = mAppId;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAppDescription() {
		return appDescription;
	}

	public void setAppDescription(String appDescription) {
		this.appDescription = appDescription;
	}

	public String getAppDescription2() {
		return appDescription2;
	}

	public void setAppDescription2(String appDescription2) {
		this.appDescription2 = appDescription2;
	}

	public String getAppLink() {
		return appLink;
	}

	public void setAppLink(String appLink) {
		this.appLink = appLink;
	}

	public Integer getAppActive() {
		return appActive;
	}

	public void setAppActive(Integer appActive) {
		this.appActive = appActive;
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

	public String getAppIcon() {
		return appIcon;
	}

	public void setAppIcon(String appIcon) {
		this.appIcon = appIcon;
	}
}