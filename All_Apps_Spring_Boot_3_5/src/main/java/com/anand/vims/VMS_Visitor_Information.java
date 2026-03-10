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
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import com.anand.masters.M_User;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@Entity
@Table(name = "vms_visitor_information")
@ToString(exclude = "visitorInformationDetail")
@EqualsAndHashCode(exclude = "visitorInformationDetail")
public class VMS_Visitor_Information implements Comparable<VMS_Visitor_Information> {

	@Override
	public int compareTo(VMS_Visitor_Information visitorGovtType) {
		return Integer.parseInt(""+this.getVisitorInformationId()) - Integer.parseInt(""+visitorGovtType.getVisitorInformationId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "visitor_information_id",unique = true, nullable = false)
    private Long visitorInformationId;

	@ManyToOne
    @JoinColumn(name = "visitor_id", nullable = true)
	private VMS_Visitor visitorInformationDetail;

	@Column(name = "visitor_name")
    private String visitorName;

	@Column(name = "visitor_email")
    private String visitorEmail;

	@OneToOne
    @JoinColumn(name = "visitor_govt_id", nullable = true)
	private VMS_M_Visitor_Govt_Type visitorGovtId;

	@Column(name = "visitor_govt_id_number")
    private String visitorGovtIdNumber;

	@Column(name = "visitor_image")
    private String visitorImage;

	@Column(name = "visitor_batch")
    private String visitorBatch;

	@OneToOne
    @JoinColumn(name = "created_by", nullable = true)
	private M_User createdBy;

	@Column(name = "created_on")
    private Date createdOn;

	@OneToOne
    @JoinColumn(name = "updated_by", nullable = true)
	private M_User updatedBy;

	@Column(name = "updated_on")
    private Date updatedOn;

	@Column(name = "visitor_active")
    private Integer visitorActive;//0-In-Active 1-Active

	@Column(name = "out_time")
    private Date outTime;

	@Transient private Long parentVisitorId;
	@Transient private Long visitorGovtIdTemp;
	@Transient private String actionForList;
}