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

import com.anand.masters.M_User;

import lombok.Data;

@Data
@Entity
@Table(name = "vms_m_visitor_govt_type_history")
public class VMS_M_Visitor_Govt_Type_History implements Comparable<VMS_M_Visitor_Govt_Type_History> {

	@Override
	public int compareTo(VMS_M_Visitor_Govt_Type_History visitorTypeHistory) {
		return Integer.parseInt(""+visitorTypeHistory.getMVisitorTypeHistoryId()) - Integer.parseInt(""+this.mVisitorTypeHistoryId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_visitor_type_history_id",unique = true, nullable = false)
    private Long mVisitorTypeHistoryId;

	@OneToOne
    @JoinColumn(name = "m_visitor_type_id", nullable = true)
    private VMS_M_Visitor_Govt_Type parentVisitorType;

	@Column(name = "visitor_type_name")
    private String visitorTypeName;

	@Column(name = "visitor_type_active")
    private Integer visitorTypeActive;

	@OneToOne
    @JoinColumn(name = "visitor_type_history_created_by", nullable = true)
    private M_User visitorTypeHistoryCreatedBy;

	@Column(name = "visitor_type_history_created_on")
    private Date visitorTypeHistoryCreatedOn;
}