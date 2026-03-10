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
@Table(name = "m_location_history")
public class M_Location_History implements Comparable<M_Location_History> {

	@Override
	public int compareTo(M_Location_History zoneHistory) {
		return zoneHistory.getmLocationHistoryId() - this.mLocationHistoryId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_location_history_id",unique = true, nullable = false)
    private Integer mLocationHistoryId;

	@OneToOne
    @JoinColumn(name = "m_location_id", nullable = true)
    private M_Location mLocationId;

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

	public Integer getmLocationHistoryId() {
		return mLocationHistoryId;
	}

	public void setmLocationHistoryId(Integer mLocationHistoryId) {
		this.mLocationHistoryId = mLocationHistoryId;
	}

	public M_Location getmLocationId() {
		return mLocationId;
	}

	public void setmLocationId(M_Location mLocationId) {
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
}