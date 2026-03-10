package com.anand.vims;

import com.anand.masters.M_Entity;
import com.anand.masters.M_User;

import lombok.Data;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Data
@Entity
@Table(name="vms_visitor")
public class VMS_Visitor implements Comparable<VMS_Visitor>{

    @Override
    public int compareTo(VMS_Visitor visitor) {
        return Integer.parseInt(""+visitor.getVisitorId()) - Integer.parseInt(""+this.visitorId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="visitor_id",unique=true, nullable=false)
    private Long visitorId;

    @Column(name = "visitor_name", nullable=false)
    private String visitorName;

    @Column(name = "visitor_email",nullable=false)
    private String visitorEmail;

    @OneToOne
    @JoinColumn(name = "m_visitor_type_id", nullable = true)
	private VMS_M_Visitor_Type mVisitorType;

    @OneToOne
    @JoinColumn(name = "m_visitor_purpose_id", nullable = true)
	private VMS_M_Visitor_Purpose mVisitorPurpose;

    @OneToOne
    @JoinColumn(name = "m_entity_id", nullable = true)
	private M_Entity visitingLocation;

    @Column(name = "visitor_plant_entry")
    private Integer visitorPlantEntry;

    @Column(name = "total_visitor")
    private Integer totalVisitor;

    @Column(name = "visitor_company_name",nullable = false)
    private String visitorCompanyName;

    @Column(name = "visitor_company_address",nullable = false)
    private String visitorCompanyAddress;

    @Column(name = "visitor_canteen_access")
    private Integer visitorCanteenAccess;

    @Column(name = "visitor_laptop_allowed")
    private Integer visitorLaptopAllowed;

    @Column(name = "visitor_cell_phone_allowed")
    private Integer visitorCellPhoneAllowed;

    @Column(name = "visitor_escort_required")
    private Integer visitorEscortRequired;

    @Column(name = "visitor_remarks", length = 255)
    private String visitorRemarks;

    @Column(name = "visitor_allowed_until")
    private Date visitorAllowedUntil;

    @OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
	private M_User hostName;

    @Column(name = "meeting_date")
    private Date meetingDate;

    @Column(name = "meeting_start_time")
    private String meetingStartTime;

    @Column(name = "meeting_end_time")
    private String meetingEndTime;

    @Column(name = "host_extension_number")
    private Integer hostExtensionNumber;

    @Column(name = "host_mobile_number")
    private Integer hostMobileNumber;

    @Column(name = "meeting_place")
    private String meetingPlace;

    @Column(name = "duration")
    private Double duration;

    @OneToOne
    @JoinColumn(name = "visitor_created_by")
    private M_User visitorCreatedBy;

    @Column(name = "visitor_created_on")
    private Date visitorCreatedOn;

    @OneToOne
    @JoinColumn(name = "visitor_updated_by")
    private M_User visitorUpdatedBy;

    @Column(name = "visitor_updated_on")
    private Date visitorUpdatedOn;

    @Column(name = "visitor_active")
    private Integer visitorActive;

    @OneToMany(mappedBy="visitorInformationDetail")
    private Set<VMS_Visitor_Information> visitorInformationDetail;

    @Transient private String actionForList;
	@Transient private Long visitorTypeTemp;
	@Transient private Long visitorPurposeTemp;
	@Transient private Long visitingLocationTemp;
	@Transient private Long hostNameTemp;
	@Transient private String meetingStartDateTemp;
	@Transient private String meetingStartTimeTemp;
	@Transient private String meetingEndTimeTemp;
	@Transient private String meetingEndDateTemp;
	@Transient private List<VMS_Visitor_Information> visitorInformationList;
}