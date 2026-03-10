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

@Entity
@Table(name = "m_mail_configuration_history")
public class M_Mail_Configuration_History implements Comparable<M_Mail_Configuration_History> {

	@Override
	public int compareTo(M_Mail_Configuration_History mailConfigurationHistory) {
		return mailConfigurationHistory.getmMailConfigurationHistoryId() - this.mMailConfigurationHistoryId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_mail_configuration_history_id",unique = true, nullable = false)
    private Integer mMailConfigurationHistoryId;

	@OneToOne
    @JoinColumn(name = "m_mail_configuration_id", nullable = true)
    private M_Mail_Configuration mMailConfigurationId;

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

	public Integer getmMailConfigurationHistoryId() {
		return mMailConfigurationHistoryId;
	}

	public void setmMailConfigurationHistoryId(Integer mMailConfigurationHistoryId) {
		this.mMailConfigurationHistoryId = mMailConfigurationHistoryId;
	}

	public M_Mail_Configuration getmMailConfigurationId() {
		return mMailConfigurationId;
	}

	public void setmMailConfigurationId(M_Mail_Configuration mMailConfigurationId) {
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
}