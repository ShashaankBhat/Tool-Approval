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
@Table(name = "m_member_level_history")
public class M_Member_Level_History implements Comparable<M_Member_Level_History> {

	@Override
	public int compareTo(M_Member_Level_History memberLevelHistory) {
		return Integer.parseInt(""+memberLevelHistory.getmMemberLevelHistoryId()) - Integer.parseInt(""+this.getmMemberLevelHistoryId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_member_level_history_id",unique = true, nullable = false)
    private Long mMemberLevelHistoryId;

	@ManyToOne
	@JoinColumn(name = "m_member_level_id", nullable = true)
    private M_Member_Level parentMemberLevel;

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

	public Long getmMemberLevelHistoryId() {
		return mMemberLevelHistoryId;
	}

	public void setmMemberLevelHistoryId(Long mMemberLevelHistoryId) {
		this.mMemberLevelHistoryId = mMemberLevelHistoryId;
	}

	public M_Member_Level getParentMemberLevel() {
		return parentMemberLevel;
	}

	public void setParentMemberLevel(M_Member_Level parentMemberLevel) {
		this.parentMemberLevel = parentMemberLevel;
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

	@Transient private String actionForList;

	public String getActionForList() {
		return actionForList;
	}

	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}