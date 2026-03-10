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
@Table(name = "m_zone_history")
public class M_Zone_History implements Comparable<M_Zone_History> {

	@Override
	public int compareTo(M_Zone_History zoneHistory) {
		return zoneHistory.getmZoneHistoryId() - this.mZoneHistoryId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_zone_history_id",unique = true, nullable = false)
    private Integer mZoneHistoryId;

	@OneToOne
    @JoinColumn(name = "m_zone_id", nullable = true)
    private M_Zone mZoneId;

	@Column(name = "zone_name")
    private String zoneName;

	@Column(name = "zone_active")
    private Integer zoneActive;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	public Integer getmZoneHistoryId() {
		return mZoneHistoryId;
	}

	public void setmZoneHistoryId(Integer mZoneHistoryId) {
		this.mZoneHistoryId = mZoneHistoryId;
	}

	public M_Zone getmZoneId() {
		return mZoneId;
	}

	public void setmZoneId(M_Zone mZoneId) {
		this.mZoneId = mZoneId;
	}

	public String getZoneName() {
		return zoneName;
	}

	public void setZoneName(String zoneName) {
		this.zoneName = zoneName;
	}

	public Integer getZoneActive() {
		return zoneActive;
	}

	public void setZoneActive(Integer zoneActive) {
		this.zoneActive = zoneActive;
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