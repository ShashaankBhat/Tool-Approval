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
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "m_app_dump")
public class M_App_Dump implements Comparable<M_App_Dump> {

	@Override
	public int compareTo(M_App_Dump appDump) {
		return Integer.parseInt(""+this.mAppDumpId) - Integer.parseInt(""+appDump.getmAppDumpId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_app_dump_id",unique = true, nullable = false)
    private Long mAppDumpId;

	@Column(name = "app_dump_name")
    private String appDumpName;

	@Column(name = "app_dump_description")
    private String appDumpDescription;

	@Column(name = "app_dump_description_2")
    private String appDumpDescription2;

	@OneToOne
    @JoinColumn(name = "app_dump_entity", nullable = true)
    private M_Entity appDumpEntity;

	@ManyToOne
    @JoinColumn(name = "app_dump_department", nullable = true)
    private M_Department appDumpDepartment;

	@Column(name = "app_dump_link")
    private String appDumpLink;

	@Column(name = "app_dump_icon")
    private String appDumpIcon;

	@Column(name = "app_dump_active")
    private Integer appDumpActive;//0-In-Active 1-Active

	@OneToOne
    @JoinColumn(name = "app_dump_created_by", nullable = true)
	private M_User appDumpCreatedBy;

	@Column(name = "app_dump_created_on")
    private Date appDumpCreatedOn;

	@OneToOne
    @JoinColumn(name = "app_dump_updated_by", nullable = true)
	private M_User appDumpUpdatedBy;

	@Column(name = "app_dump_updated_on")
    private Date appDumpUpdatedOn;

	@Transient private Long tempEntityId;
	@Transient private Long tempDepartmentId;
	@Transient private String actionForList;
	public Long getmAppDumpId() {
		return mAppDumpId;
	}
	public void setmAppDumpId(Long mAppDumpId) {
		this.mAppDumpId = mAppDumpId;
	}
	public String getAppDumpName() {
		return appDumpName;
	}
	public void setAppDumpName(String appDumpName) {
		this.appDumpName = appDumpName;
	}
	public String getAppDumpDescription() {
		return appDumpDescription;
	}
	public void setAppDumpDescription(String appDumpDescription) {
		this.appDumpDescription = appDumpDescription;
	}
	public String getAppDumpDescription2() {
		return appDumpDescription2;
	}
	public void setAppDumpDescription2(String appDumpDescription2) {
		this.appDumpDescription2 = appDumpDescription2;
	}
	public M_Entity getAppDumpEntity() {
		return appDumpEntity;
	}
	public void setAppDumpEntity(M_Entity appDumpEntity) {
		this.appDumpEntity = appDumpEntity;
	}
	public M_Department getAppDumpDepartment() {
		return appDumpDepartment;
	}
	public void setAppDumpDepartment(M_Department appDumpDepartment) {
		this.appDumpDepartment = appDumpDepartment;
	}
	public String getAppDumpLink() {
		return appDumpLink;
	}
	public void setAppDumpLink(String appDumpLink) {
		this.appDumpLink = appDumpLink;
	}
	public String getAppDumpIcon() {
		return appDumpIcon;
	}
	public void setAppDumpIcon(String appDumpIcon) {
		this.appDumpIcon = appDumpIcon;
	}
	public Integer getAppDumpActive() {
		return appDumpActive;
	}
	public void setAppDumpActive(Integer appDumpActive) {
		this.appDumpActive = appDumpActive;
	}
	public M_User getAppDumpCreatedBy() {
		return appDumpCreatedBy;
	}
	public void setAppDumpCreatedBy(M_User appDumpCreatedBy) {
		this.appDumpCreatedBy = appDumpCreatedBy;
	}
	public Date getAppDumpCreatedOn() {
		return appDumpCreatedOn;
	}
	public void setAppDumpCreatedOn(Date appDumpCreatedOn) {
		this.appDumpCreatedOn = appDumpCreatedOn;
	}
	public M_User getAppDumpUpdatedBy() {
		return appDumpUpdatedBy;
	}
	public void setAppDumpUpdatedBy(M_User appDumpUpdatedBy) {
		this.appDumpUpdatedBy = appDumpUpdatedBy;
	}
	public Date getAppDumpUpdatedOn() {
		return appDumpUpdatedOn;
	}
	public void setAppDumpUpdatedOn(Date appDumpUpdatedOn) {
		this.appDumpUpdatedOn = appDumpUpdatedOn;
	}
	public Long getTempEntityId() {
		return tempEntityId;
	}
	public void setTempEntityId(Long tempEntityId) {
		this.tempEntityId = tempEntityId;
	}
	public Long getTempDepartmentId() {
		return tempDepartmentId;
	}
	public void setTempDepartmentId(Long tempDepartmentId) {
		this.tempDepartmentId = tempDepartmentId;
	}
	public String getActionForList() {
		return actionForList;
	}
	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}