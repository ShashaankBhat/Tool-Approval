package com.anand.sso;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class GraphResponse {
    @JsonProperty("@odata.context")
    private String dataContext;

    @SuppressWarnings("rawtypes")
	@JsonProperty("businessPhones")
    public List businessPhones;

    @JsonProperty("displayName")
    public String displayName;

    @JsonProperty("companyName")
    public String companyName;

    @JsonProperty("givenName")
    private String givenName;

    @JsonProperty("jobTitle")
    public String jobTitle;

    @JsonProperty("mail")
    private String mail;

    @JsonProperty("mobilePhone")
    private String mobilePhone;

    @JsonProperty("officeLocation")
    public String officeLocation;

    @JsonProperty("preferredLanguage")
    private String preferredLanguage;

    @JsonProperty("surname")
    private String surname;

    @JsonProperty("userPrincipalName")
    public String userPrincipalName;

    @JsonProperty("id")
    private String id;

	public String getDataContext() {
		return dataContext;
	}

	public void setDataContext(String dataContext) {
		this.dataContext = dataContext;
	}

	@SuppressWarnings("rawtypes")
	public List getBusinessPhones() {
		return businessPhones;
	}

	@SuppressWarnings("rawtypes")
	public void setBusinessPhones(List businessPhones) {
		this.businessPhones = businessPhones;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getGivenName() {
		return givenName;
	}

	public void setGivenName(String givenName) {
		this.givenName = givenName;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getOfficeLocation() {
		return officeLocation;
	}

	public void setOfficeLocation(String officeLocation) {
		this.officeLocation = officeLocation;
	}

	public String getPreferredLanguage() {
		return preferredLanguage;
	}

	public void setPreferredLanguage(String preferredLanguage) {
		this.preferredLanguage = preferredLanguage;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getUserPrincipalName() {
		return userPrincipalName;
	}

	public void setUserPrincipalName(String userPrincipalName) {
		this.userPrincipalName = userPrincipalName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
}
