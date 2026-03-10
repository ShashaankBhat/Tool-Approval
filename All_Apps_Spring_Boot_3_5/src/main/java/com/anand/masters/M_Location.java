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
@Table(name = "m_location")
public class M_Location implements Comparable<M_Location> {

	@Override
	public int compareTo(M_Location location) {
		return Integer.parseInt(""+location.getmLocationId()) - Integer.parseInt(""+this.mLocationId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_location_id",unique = true, nullable = false)
    private Long mLocationId;

	@Column(name = "location_name")
    private String locationName;

	@OneToOne
    @JoinColumn(name = "m_zone_id", nullable = true)
    private M_Zone mZoneId;

	@Column(name = "location_active")
    private Integer locationActive;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	@OneToOne
    @JoinColumn(name = "m_user_id_updated", nullable = true)
    private M_User mUserIdUpdated;

	@Column(name = "updated_on")
    private Date updatedOn;

	public Long getmLocationId() {
		return mLocationId;
	}

	public void setmLocationId(Long mLocationId) {
		this.mLocationId = mLocationId;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public M_Zone getmZoneId() {
		return mZoneId;
	}

	public void setmZoneId(M_Zone mZoneId) {
		this.mZoneId = mZoneId;
	}

	public Integer getLocationActive() {
		return locationActive;
	}

	public void setLocationActive(Integer locationActive) {
		this.locationActive = locationActive;
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

	public M_User getmUserIdUpdated() {
		return mUserIdUpdated;
	}

	public void setmUserIdUpdated(M_User mUserIdUpdated) {
		this.mUserIdUpdated = mUserIdUpdated;
	}

	public Date getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

	@Transient private Integer zoneIdTemp;
	@Transient private String actionForList;

	public Integer getZoneIdTemp() {
		return zoneIdTemp;
	}

	public void setZoneIdTemp(Integer zoneIdTemp) {
		this.zoneIdTemp = zoneIdTemp;
	}

	public String getActionForList() {
		return actionForList;
	}

	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}