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
@Table(name = "m_entity_history")
public class M_Entity_History implements Comparable<M_Entity_History> {

	@Override
	public int compareTo(M_Entity_History entity) {
		return entity.getmEntityHistoryId() - this.mEntityHistoryId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_entity_history_id",unique = true, nullable = false)
    private Integer mEntityHistoryId;

	@OneToOne
    @JoinColumn(name = "m_entity_id", nullable = true)
    private M_Entity parentEntityId;

	@Column(name = "entity_name")
    private String entityName;

	@Column(name = "entity_short_name")
    private String entityShortName;

	@Column(name = "entity_acronym")
    private String entityAcronym;

	@OneToOne
    @JoinColumn(name = "entity_source", nullable = true)
    private M_Entity entitySource;

	@OneToOne
    @JoinColumn(name = "m_location_id", nullable = true)
    private M_Location locationId;

	@Column(name = "entity_active")
    private Integer entityActive;

	@OneToOne
    @JoinColumn(name = "m_user_id", nullable = true)
    private M_User mUserId;

	@Column(name = "created_on")
    private Date createdOn;

	public Integer getmEntityHistoryId() {
		return mEntityHistoryId;
	}

	public void setmEntityHistoryId(Integer mEntityHistoryId) {
		this.mEntityHistoryId = mEntityHistoryId;
	}

	public M_Entity getParentEntityId() {
		return parentEntityId;
	}

	public void setParentEntityId(M_Entity parentEntityId) {
		this.parentEntityId = parentEntityId;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getEntityShortName() {
		return entityShortName;
	}

	public void setEntityShortName(String entityShortName) {
		this.entityShortName = entityShortName;
	}

	public String getEntityAcronym() {
		return entityAcronym;
	}

	public void setEntityAcronym(String entityAcronym) {
		this.entityAcronym = entityAcronym;
	}

	public M_Entity getEntitySource() {
		return entitySource;
	}

	public void setEntitySource(M_Entity entitySource) {
		this.entitySource = entitySource;
	}

	public M_Location getLocationId() {
		return locationId;
	}

	public void setLocationId(M_Location locationId) {
		this.locationId = locationId;
	}

	public Integer getEntityActive() {
		return entityActive;
	}

	public void setEntityActive(Integer entityActive) {
		this.entityActive = entityActive;
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