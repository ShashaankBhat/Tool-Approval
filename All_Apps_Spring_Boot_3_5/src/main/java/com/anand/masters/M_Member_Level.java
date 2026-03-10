/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - R S Iyer
 */
package com.anand.masters;

import java.util.Date;
import java.util.Set;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "m_member_level")
public class M_Member_Level implements Comparable<M_Member_Level> {

	@Override
	public int compareTo(M_Member_Level memberLevel) {
		return Integer.parseInt(""+memberLevel.getmMemberLevelId()) - Integer.parseInt(""+this.getmMemberLevelId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_member_level_id",unique = true, nullable = false)
    private Long mMemberLevelId;

	@Column(name = "member_level_name")
    private String memberLevelName;

	@Column(name = "member_level_description")
    private String memberLevelDescription;

	@Column(name = "member_level_active")
    private Integer memberLevelActive;//0-In-Active 1-Active

	@OneToOne
    @JoinColumn(name = "member_level_created_by", nullable = true)
	private M_User memberLevelCreatedBy;

	@Column(name = "member_level_created_on")
    private Date memberLevelCreatedOn;

	@OneToOne
    @JoinColumn(name = "member_level_updated_by", nullable = true)
	private M_User memberLevelUpdatedBy;

	@Column(name = "member_level_updated_on")
    private Date memberLevelUpdatedOn;

	public Long getmMemberLevelId() {
		return mMemberLevelId;
	}

	public void setmMemberLevelId(Long mMemberLevelId) {
		this.mMemberLevelId = mMemberLevelId;
	}

	public String getMemberLevelName() {
		return memberLevelName;
	}

	public void setMemberLevelName(String memberLevelName) {
		this.memberLevelName = memberLevelName;
	}

	public String getMemberLevelDescription() {
		return memberLevelDescription;
	}

	public void setMemberLevelDescription(String memberLevelDescription) {
		this.memberLevelDescription = memberLevelDescription;
	}

	public Integer getMemberLevelActive() {
		return memberLevelActive;
	}

	public void setMemberLevelActive(Integer memberLevelActive) {
		this.memberLevelActive = memberLevelActive;
	}

	public M_User getMemberLevelCreatedBy() {
		return memberLevelCreatedBy;
	}

	public void setMemberLevelCreatedBy(M_User memberLevelCreatedBy) {
		this.memberLevelCreatedBy = memberLevelCreatedBy;
	}

	public Date getMemberLevelCreatedOn() {
		return memberLevelCreatedOn;
	}

	public void setMemberLevelCreatedOn(Date memberLevelCreatedOn) {
		this.memberLevelCreatedOn = memberLevelCreatedOn;
	}

	public M_User getMemberLevelUpdatedBy() {
		return memberLevelUpdatedBy;
	}

	public void setMemberLevelUpdatedBy(M_User memberLevelUpdatedBy) {
		this.memberLevelUpdatedBy = memberLevelUpdatedBy;
	}

	public Date getMemberLevelUpdatedOn() {
		return memberLevelUpdatedOn;
	}

	public void setMemberLevelUpdatedOn(Date memberLevelUpdatedOn) {
		this.memberLevelUpdatedOn = memberLevelUpdatedOn;
	}

	@OneToMany(mappedBy="parentMemberLevel")
	private Set<M_Member_Level_History> parentMemberLevel;

	public Set<M_Member_Level_History> getParentMemberLevel() {
		return parentMemberLevel;
	}

	public void setParentMemberLevel(Set<M_Member_Level_History> parentMemberLevel) {
		this.parentMemberLevel = parentMemberLevel;
	}

	@Transient private String actionForList;

	public String getActionForList() {
		return actionForList;
	}

	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}