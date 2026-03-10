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
@Table(name = "vms_m_visitor_purpose_history")
public class VMS_M_Visitor_Purpose_History implements Comparable<VMS_M_Visitor_Purpose_History> {

	@Override
	public int compareTo(VMS_M_Visitor_Purpose_History visitorPurposeHistory) {
		return Integer.parseInt(""+visitorPurposeHistory.getMVisitorPurposeHistoryId()) - Integer.parseInt(""+this.mVisitorPurposeHistoryId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_visitor_purpose_history_id",unique = true, nullable = false)
    private Long mVisitorPurposeHistoryId;

	@OneToOne
    @JoinColumn(name = "m_visitor_purpose_id", nullable = true)
    private VMS_M_Visitor_Purpose parentVisitorPurpose;

	@Column(name = "visitor_purpose_name")
    private String visitorPurposeName;

	@Column(name = "visitor_purpose_active")
    private Integer visitorPurposeActive;

	@OneToOne
    @JoinColumn(name = "visitor_purpose_history_created_by", nullable = true)
    private M_User visitorPurposeHistoryCreatedBy;

	@Column(name = "visitor_purpose_history_created_on")
    private Date visitorPurposeHistoryCreatedOn;
}