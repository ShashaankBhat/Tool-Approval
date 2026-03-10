/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - R S Iyer
 */
package com.anand.vims;

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

import com.anand.masters.M_User;

import lombok.Data;

@Data
@Entity
@Table(name = "vms_m_visitor_purpose")
public class VMS_M_Visitor_Purpose implements Comparable<VMS_M_Visitor_Purpose> {

	@Override
	public int compareTo(VMS_M_Visitor_Purpose VisitorPurpose) {
		return Integer.parseInt(""+this.getMVisitorPurposeId()) - Integer.parseInt(""+VisitorPurpose.getMVisitorPurposeId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_visitor_purpose_id",unique = true, nullable = false)
    private Long mVisitorPurposeId;

	@Column(name = "visitor_purpose_name")
    private String visitorPurposeName;

	@Column(name = "visitor_purpose_active")
    private Integer visitorPurposeActive;//0-In-Active 1-Active

	@OneToOne
    @JoinColumn(name = "visitor_purpose_created_by", nullable = true)
	private M_User visitorPurposeCreatedBy;

	@Column(name = "visitor_purpose_created_on")
    private Date visitorPurposeCreatedOn;

	@OneToOne
    @JoinColumn(name = "visitor_purpose_updated_by", nullable = true)
	private M_User visitorPurposeUpdatedBy;

	@Column(name = "visitor_purpose_updated_on")
    private Date visitorPurposeUpdatedOn;

	@Transient private String actionForList;
}