package com.anand.masters;

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

@Entity
@Table(name = "m_mail_configuration")
public class M_Mail_Configuration implements Comparable<M_Mail_Configuration> {

	@Override
	public int compareTo(M_Mail_Configuration mailConfiguration) {
		return Integer.parseInt(""+mailConfiguration.getmMailConfigurationId()) - Integer.parseInt(""+this.mMailConfigurationId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_mail_configuration_id",unique = true, nullable = false)
    private Long mMailConfigurationId;

	@Column(name = "mail_id")
    private String mailId;

	@Column(name = "mail_app_password")
    private String mailAppPassword;

	@Column(name = "active")
    private Integer active;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	@OneToOne
    @JoinColumn(name = "m_user_id_update", nullable = true)
    private M_User mUserIdUpdate;

	@Column(name = "updated_on")
    private Date updatedOn;

	public Long getmMailConfigurationId() {
		return mMailConfigurationId;
	}

	public void setmMailConfigurationId(Long mMailConfigurationId) {
		this.mMailConfigurationId = mMailConfigurationId;
	}

	public String getMailId() {
		return mailId;
	}

	public void setMailId(String mailId) {
		this.mailId = mailId;
	}

	public String getMailAppPassword() {
		return mailAppPassword;
	}

	public void setMailAppPassword(String mailAppPassword) {
		this.mailAppPassword = mailAppPassword;
	}

	public Integer getActive() {
		return active;
	}

	public void setActive(Integer active) {
		this.active = active;
	}

	public M_User getmUserId() {
		return mUserId;
	}

	public void setmUserId(M_User mUserId) {
		this.mUserId = mUserId;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public M_User getmUserIdUpdate() {
		return mUserIdUpdate;
	}

	public void setmUserIdUpdate(M_User mUserIdUpdate) {
		this.mUserIdUpdate = mUserIdUpdate;
	}

	public Date getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

	@Transient private String actionForList;

	public String getActionForList() {
		return actionForList;
	}

	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}