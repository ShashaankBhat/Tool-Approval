/**
 * *******************************************************************************************
 * Copyright © 2025 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - S Iyer
 */
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
@Table(name = "m_app")
public class M_App implements Comparable<M_App> {

	@Override
	public int compareTo(M_App app) {
		return Integer.parseInt(""+app.getmAppId()) - Integer.parseInt(""+this.getmAppId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_app_id",unique = true, nullable = false)
    private Long mAppId;

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
    private Integer appActive;//0-In-Active 1-Active

	@OneToOne
    @JoinColumn(name = "app_created_by", nullable = true)
	private M_User appCreatedBy;

	@Column(name = "app_created_on")
    private Date appCreatedOn;

	@OneToOne
    @JoinColumn(name = "app_updated_by", nullable = true)
	private M_User appUpdatedBy;

	@Column(name = "app_updated_on")
    private Date appUpdatedOn;

	public Long getmAppId() {
		return mAppId;
	}

	public void setmAppId(Long mAppId) {
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

	public M_User getAppCreatedBy() {
		return appCreatedBy;
	}

	public void setAppCreatedBy(M_User appCreatedBy) {
		this.appCreatedBy = appCreatedBy;
	}

	public Date getAppCreatedOn() {
		return appCreatedOn;
	}

	public void setAppCreatedOn(Date appCreatedOn) {
		this.appCreatedOn = appCreatedOn;
	}

	public M_User getAppUpdatedBy() {
		return appUpdatedBy;
	}

	public void setAppUpdatedBy(M_User appUpdatedBy) {
		this.appUpdatedBy = appUpdatedBy;
	}

	public Date getAppUpdatedOn() {
		return appUpdatedOn;
	}

	public void setAppUpdatedOn(Date appUpdatedOn) {
		this.appUpdatedOn = appUpdatedOn;
	}

	public String getAppIcon() {
		return appIcon;
	}

	public void setAppIcon(String appIcon) {
		this.appIcon = appIcon;
	}

	@Transient private String actionForList;

	public String getActionForList() {
		return actionForList;
	}

	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}