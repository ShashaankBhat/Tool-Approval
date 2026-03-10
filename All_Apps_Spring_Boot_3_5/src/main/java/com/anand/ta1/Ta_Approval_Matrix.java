package com.anand.ta1;

import java.util.Date;
import jakarta.persistence.*;
import lombok.Data;

import com.anand.masters.M_User;

@Data
@Entity
@Table(name = "ta_approval_matrix")
public class Ta_Approval_Matrix implements Comparable<Ta_Approval_Matrix> {

	@Override
    public int compareTo(Ta_Approval_Matrix matrix) {
        return matrix.getTaApprovalMatrixId().compareTo(this.taApprovalMatrixId);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ta_approval_matrix_id")
    private Long taApprovalMatrixId;

    @ManyToOne
    @JoinColumn(name = "ta_business_unit_id", nullable = false)
    private Ta_Business_Unit approvalMatrixForBusinessUnit;

    @OneToOne
    @JoinColumn(name = "level_one")
    private M_User levelOne;

    @Column(name = "level_one_position", nullable = false)
    private String levelOnePosition;

    @OneToOne
    @JoinColumn(name = "level_two")
    private M_User levelTwo;

    @Column(name = "level_two_position", nullable = false)
    private String levelTwoPosition;

    @OneToOne
    @JoinColumn(name = "level_three")
    private M_User levelThree;

    @Column(name = "level_three_position", nullable = false)
    private String levelThreePosition;

    @OneToOne
    @JoinColumn(name = "level_four")
    private M_User levelFour;

    @Column(name = "level_four_position", nullable = false)
    private String levelFourPosition;


    @Column(name = "matrix_active")
    private Integer matrixActive;

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
    @Transient private Long tempBusinessUnit;
    @Transient private Long tempLevelOneId;
    @Transient private Long tempLevelTwoId;
    @Transient private Long tempLevelThreeId;
    @Transient private Long tempLevelFourId;
}