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
@Table(name = "vms_m_visitor_type")
public class VMS_M_Visitor_Type implements Comparable<VMS_M_Visitor_Type> {

	@Override
	public int compareTo(VMS_M_Visitor_Type visitorType) {
		return Integer.parseInt(""+this.getMVisitorTypeId()) - Integer.parseInt(""+visitorType.getMVisitorTypeId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_visitor_type_id",unique = true, nullable = false)
    private Long mVisitorTypeId;

	@Column(name = "visitor_type_name")
    private String visitorTypeName;

	@Column(name = "visitor_type_active")
    private Integer visitorTypeActive;//0-In-Active 1-Active

	@OneToOne
    @JoinColumn(name = "visitor_type_created_by", nullable = true)
	private M_User visitorTypeCreatedBy;

	@Column(name = "visitor_type_created_on")
    private Date visitorTypeCreatedOn;

	@OneToOne
    @JoinColumn(name = "visitor_type_updated_by", nullable = true)
	private M_User visitorTypeUpdatedBy;

	@Column(name = "visitor_type_updated_on")
    private Date visitorTypeUpdatedOn;

	@Transient private String actionForList;
}