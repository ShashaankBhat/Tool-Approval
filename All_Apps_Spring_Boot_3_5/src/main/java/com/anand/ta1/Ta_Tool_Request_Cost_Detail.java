package com.anand.ta1;

import java.util.Date;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import com.anand.masters.M_User;

@Getter
@Setter
@Entity
@Table(name = "ta_tool_request_cost_detail")
public class Ta_Tool_Request_Cost_Detail implements Comparable<Ta_Tool_Request_Cost_Detail> {

	@Override
    public int compareTo(Ta_Tool_Request_Cost_Detail toolReqeust) {
        return toolReqeust.getTaToolRequestCostDetailId().compareTo(this.taToolRequestCostDetailId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_tool_request_cost_detail_id")
    private Long taToolRequestCostDetailId;

    @ManyToOne
    @JoinColumn(name = "ta_tool_request_id", nullable = false)
    private Ta_Tool_Request_1 toolReqeustCostDetail;

    @Column(name = "tool_part_number", nullable = false)
    private String toolPartNumber;

    @Column(name = "part_description", nullable = false)
    private String partDescription;

    @Column(name = "currency", nullable = false)
    private Integer currency;

    @Column(name = "quoted_cost", nullable = false)
    private Float quotedCost;

    @Column(name = "negotiated_cost", nullable = false)
    private Float negotiatedCost;

    @Column(name = "upfront_cost", nullable = false)
    private Float upfrontCost;

    @Column(name = "amortization_cost", nullable = false)
    private Float amortizationCost;

    @Column(name = "supplier_name", nullable = false)
    private String supplierName;

    @Column(name = "development_lead_time", nullable = false)
    private String developmentLeadTime;

    @Column(name = "cost_active", nullable = false)
    private Integer costActive;

    @Column(name = "remarks", nullable = false)
    private String remarks;

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

    @Transient private String actionForList;
    @Transient private Long tempToolReqeustId;
}