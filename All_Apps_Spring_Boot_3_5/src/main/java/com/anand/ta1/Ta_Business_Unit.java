/**
 * *******************************************************************************************
 * Copyright © 2026 Anand Group India.
 * *******************************************************************************************
 * Author - Tool Approval Application (TAA)
 */
package com.anand.ta1;

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
import lombok.Data;

import com.anand.masters.M_User;

@Data
@Entity
@Table(name = "ta_business_unit")
public class Ta_Business_Unit implements Comparable<Ta_Business_Unit> {

    @Override
    public int compareTo(Ta_Business_Unit o) {
        return Long.compare(o.taBusinessUnitId, this.taBusinessUnitId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_business_unit_id", nullable = false)
    private Long taBusinessUnitId;

    @Column(name = "ta_business_unit_name", nullable = false)
    private String taBusinessUnitName;

    @Column(name = "ta_business_unit_description")
    private String taBusinessUnitDescription;

    @Column(name = "ta_business_unit_active", nullable = false)
    private Integer taBusinessUnitActive; // 1 = Active, 0 = Inactive

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

    @OneToMany(mappedBy="approvalMatrixForBusinessUnit")
    private Set<Ta_Approval_Matrix> approvalMatrixForBusinessUnit;
}