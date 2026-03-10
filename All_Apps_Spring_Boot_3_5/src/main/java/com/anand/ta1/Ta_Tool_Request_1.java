package com.anand.ta1;

import java.util.Date;
import java.util.List;
import java.util.Set;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import com.anand.masters.M_Entity;
import com.anand.masters.M_User;

@Getter
@Setter
@Entity
@Table(name = "ta_tool_request")
public class Ta_Tool_Request_1 implements Comparable<Ta_Tool_Request_1> {

	@Override
    public int compareTo(Ta_Tool_Request_1 toolReqeust) {
        return toolReqeust.getTaToolRequestId().compareTo(this.taToolRequestId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_tool_request_id")
    private Long taToolRequestId;

    @Column(name = "request_number", nullable = false)
    private String requestNumber;

    @Column(name = "customer_name", nullable = false)
    private String customerName;

    @Column(name = "project_name", nullable = false)
    private String projectName;

    @Column(name = "sop_date", nullable = false)
    private Date sopDate;

    @OneToOne
    @JoinColumn(name = "entity_id", nullable = false)
    private M_Entity entityId;

    @Column(name = "peak_annual_volume", nullable = false)
    private Integer peakAnnualVolume;

    @Column(name = "unit", nullable = false)
    private Integer unit;

    @Column(name = "expense_type", nullable = false)
    private Integer expenseType;

    @OneToOne
    @JoinColumn(name = "ta_business_unit_id", nullable = false)
    private Ta_Business_Unit taBusinessUnitId;

    @OneToOne
    @JoinColumn(name = "commodity_manager_user_id")
    private M_User commodityManagerUserId;

    @Column(name = "background", nullable = false)
    private String background;

    @Column(name = "remark", nullable = false)
    private String remark;

    @OneToOne
    @JoinColumn(name = "ta_recovery_type_id")
    private Ta_Recovery_Type taRecoveryTypeId;

    @OneToOne
    @JoinColumn(name = "ta_status_id")
    private Ta_Status taStatusId;

    @Column(name = "request_active", nullable = false)
    private Integer requestActive;

    @OneToOne
    @JoinColumn(name = "created_by", nullable = false)
    private M_User createdBy;

    @Column(name = "created_on", nullable = false)
    private Date createdOn;

    @OneToOne
    @JoinColumn(name = "updated_by")
    private M_User updatedBy;

    @Column(name = "updated_on")
    private Date updatedOn;

    @OneToMany(mappedBy="toolReqeustCostDetail")
    private Set<Ta_Tool_Request_Cost_Detail> toolReqeustCostDetail;

    @Transient private String actionForList;
    @Transient private List<Ta_Tool_Request_Cost_Detail> tempToolRequestCostDetail;
    @Transient private String tempSopDate;
    @Transient private Long tempEntityId;
    @Transient private Long tempBusinessUnitId;
    @Transient private Long tempCommodityManagerId;
    @Transient private Long tempRecoveryId;
    @Transient private Long tempStatusId;
}