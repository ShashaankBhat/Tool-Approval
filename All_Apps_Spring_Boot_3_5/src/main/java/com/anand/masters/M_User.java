package com.anand.masters;

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

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "m_user")
public class M_User implements Comparable<M_User> {

	@Override
	public int compareTo(M_User user) {
		return Integer.parseInt(""+user.getmUserId()) - Integer.parseInt(""+this.mUserId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_user_id",unique = true, nullable = false)
    private Long mUserId;

	@Column(name = "user_login_id")
    private String userLoginId; //username - email id

	@Column(name = "user_password")
    private String userPassword; //BCryptPasswordEncoder password to be stored in this column

	@Column(name = "user_password_two")
    private String userPasswordTwo;

	@Column(name = "user_active")
    private Integer userActive; //0-In-Active 1-Active

	@Column(name = "user_first_name")
    private String userFirstName;

	@Column(name = "user_middle_name")
    private String userMiddleName;

	@Column(name = "user_last_name")
    private String userLastName;

	@Column(name = "user_code")
    private String userCode;

	@Column(name = "user_phone_number")
    private String userPhoneNumber;

	@OneToOne
    @JoinColumn(name = "user_manager", nullable = true)
    private M_User userManager;

	@Column(name = "user_email_verify_token")
    private String userEmailVerifyToken;

	@Column(name = "user_forgot_password_token")
    private String userForgotPasswordToken;

	@OneToOne
	@JsonIgnore
    @JoinColumn(name = "m_entity_id", nullable = true)
    private M_Entity mEntityId;

	@OneToOne
    @JoinColumn(name = "m_designation_id", nullable = true)
    private M_Designation mDesignationId;

	@OneToOne
    @JoinColumn(name = "m_department_id", nullable = true)
    private M_Department mDepartmentId;

	@Column(name = "user_created_on")
    private Date userCreatedOn;

	@OneToOne
    @JoinColumn(name = "user_created_by", nullable = true)
    private M_User userCreatedBy;

	@Column(name = "user_approved")
    private Integer userApproved;

	@Column(name = "user_approved_on")
    private Date userApprovedOn;

	@OneToOne
    @JoinColumn(name = "user_approved_by", nullable = true)
    private M_User userApprovedBy;

	@OneToOne
    @JoinColumn(name = "user_updated_by", nullable = true)
    private M_User userUpdatedBy;

	@Column(name = "user_updated_on")
    private Date userUpdatedOn;

	@OneToMany(mappedBy="userInfoForRole")
    private Set<M_User_Role_Map> userInfoForRole;
   
    @OneToMany(mappedBy="userInfoForApp")
    private Set<M_User_App_Map> userInfoForApp;

    @OneToMany(mappedBy="userInfoForEntity")
    private Set<M_User_Entity_Map> userInfoForEntity;

    public Set<M_User_Entity_Map> getUserInfoForEntity() {
		return userInfoForEntity;
	}

	public void setUserInfoForEntity(Set<M_User_Entity_Map> userInfoForEntity) {
		this.userInfoForEntity = userInfoForEntity;
	}

	@Column(name = "user_last_login")
    private Date userLastLogin;

	@Column(name = "user_login_count")
    private Integer userLoginCount;

	@Column(name = "otp")
    private Integer userOTP;

	public Date getUserLastLogin() {
		return userLastLogin;
	}

	public void setUserLastLogin(Date userLastLogin) {
		this.userLastLogin = userLastLogin;
	}

	public Integer getUserLoginCount() {
		return userLoginCount;
	}

	public void setUserLoginCount(Integer userLoginCount) {
		this.userLoginCount = userLoginCount;
	}

	public M_User getUserManager() {
		return userManager;
	}

	public void setUserManager(M_User userManager) {
		this.userManager = userManager;
	}

	public Long getmUserId() {
		return mUserId;
	}

	public void setmUserId(Long mUserId) {
		this.mUserId = mUserId;
	}

	public String getUserLoginId() {
		return userLoginId;
	}

	public void setUserLoginId(String userLoginId) {
		this.userLoginId = userLoginId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserPasswordTwo() {
		return userPasswordTwo;
	}

	public void setUserPasswordTwo(String userPasswordTwo) {
		this.userPasswordTwo = userPasswordTwo;
	}

	public Integer getUserActive() {
		return userActive;
	}

	public void setUserActive(Integer userActive) {
		this.userActive = userActive;
	}

	public String getUserFirstName() {
		return userFirstName;
	}

	public void setUserFirstName(String userFirstName) {
		this.userFirstName = userFirstName;
	}

	public String getUserMiddleName() {
		return userMiddleName;
	}

	public void setUserMiddleName(String userMiddleName) {
		this.userMiddleName = userMiddleName;
	}

	public String getUserLastName() {
		return userLastName;
	}

	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}

	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}

	public String getUserEmailVerifyToken() {
		return userEmailVerifyToken;
	}

	public void setUserEmailVerifyToken(String userEmailVerifyToken) {
		this.userEmailVerifyToken = userEmailVerifyToken;
	}

	public String getUserForgotPasswordToken() {
		return userForgotPasswordToken;
	}

	public void setUserForgotPasswordToken(String userForgotPasswordToken) {
		this.userForgotPasswordToken = userForgotPasswordToken;
	}

	public M_Entity getmEntityId() {
		return mEntityId;
	}

	public void setmEntityId(M_Entity mEntityId) {
		this.mEntityId = mEntityId;
	}

	public M_Designation getmDesignationId() {
		return mDesignationId;
	}

	public void setmDesignationId(M_Designation mDesignationId) {
		this.mDesignationId = mDesignationId;
	}

	public M_Department getmDepartmentId() {
		return mDepartmentId;
	}

	public void setmDepartmentId(M_Department mDepartmentId) {
		this.mDepartmentId = mDepartmentId;
	}

	public Date getUserCreatedOn() {
		return userCreatedOn;
	}

	public void setUserCreatedOn(Date userCreatedOn) {
		this.userCreatedOn = userCreatedOn;
	}

	public M_User getUserCreatedBy() {
		return userCreatedBy;
	}

	public void setUserCreatedBy(M_User userCreatedBy) {
		this.userCreatedBy = userCreatedBy;
	}

	public Integer getUserApproved() {
		return userApproved;
	}

	public void setUserApproved(Integer userApproved) {
		this.userApproved = userApproved;
	}

	public Date getUserApprovedOn() {
		return userApprovedOn;
	}

	public void setUserApprovedOn(Date userApprovedOn) {
		this.userApprovedOn = userApprovedOn;
	}

	public M_User getUserApprovedBy() {
		return userApprovedBy;
	}

	public void setUserApprovedBy(M_User userApprovedBy) {
		this.userApprovedBy = userApprovedBy;
	}

	public Set<M_User_Role_Map> getUserInfoForRole() {
		return userInfoForRole;
	}

	public void setUserInfoForRole(Set<M_User_Role_Map> userInfoForRole) {
		this.userInfoForRole = userInfoForRole;
	}

	public Set<M_User_App_Map> getUserInfoForApp() {
		return userInfoForApp;
	}

	public void setUserInfoForApp(Set<M_User_App_Map> userInfoForApp) {
		this.userInfoForApp = userInfoForApp;
	}

	public M_User getUserUpdatedBy() {
		return userUpdatedBy;
	}

	public void setUserUpdatedBy(M_User userUpdatedBy) {
		this.userUpdatedBy = userUpdatedBy;
	}

	public Date getUserUpdatedOn() {
		return userUpdatedOn;
	}

	public void setUserUpdatedOn(Date userUpdatedOn) {
		this.userUpdatedOn = userUpdatedOn;
	}

	@Transient private Integer tempEntityId;
	@Transient private Integer tempDepartmentId;
	@Transient private Integer tempDesignationId;
	@Transient private Long userManagerId;
	@Transient private String action;
	@Transient private String rolesAvailable;
	@Transient private String userRolesTemp;
	@Transient private String userAppsTemp;
	@Transient private String userEntitysTemp;

	public String getUserEntitysTemp() {
		return userEntitysTemp;
	}

	public void setUserEntitysTemp(String userEntitysTemp) {
		this.userEntitysTemp = userEntitysTemp;
	}

	public String getUserAppsTemp() {
		return userAppsTemp;
	}

	public void setUserAppsTemp(String userAppsTemp) {
		this.userAppsTemp = userAppsTemp;
	}

	public String getUserRolesTemp() {
		return userRolesTemp;
	}

	public void setUserRolesTemp(String userRolesTemp) {
		this.userRolesTemp = userRolesTemp;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getRolesAvailable() {
		return rolesAvailable;
	}

	public void setRolesAvailable(String rolesAvailable) {
		this.rolesAvailable = rolesAvailable;
	}

	public Integer getTempEntityId() {
		return tempEntityId;
	}

	public void setTempEntityId(Integer tempEntityId) {
		this.tempEntityId = tempEntityId;
	}

	public Integer getTempDepartmentId() {
		return tempDepartmentId;
	}

	public void setTempDepartmentId(Integer tempDepartmentId) {
		this.tempDepartmentId = tempDepartmentId;
	}

	public Integer getTempDesignationId() {
		return tempDesignationId;
	}

	public void setTempDesignationId(Integer tempDesignationId) {
		this.tempDesignationId = tempDesignationId;
	}

	public Long getUserManagerId() {
		return userManagerId;
	}

	public void setUserManagerId(Long userManagerId) {
		this.userManagerId = userManagerId;
	}

	public Integer getUserOTP() {
		return userOTP;
	}

	public void setUserOTP(Integer userOTP) {
		this.userOTP = userOTP;
	}
}