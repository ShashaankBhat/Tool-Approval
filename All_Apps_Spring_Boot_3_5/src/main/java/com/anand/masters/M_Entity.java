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
@Table(name = "m_entity")
public class M_Entity implements Comparable<M_Entity> {

	@Override
	public int compareTo(M_Entity entity) {
		return Integer.parseInt(""+entity.getmEntityId()) - Integer.parseInt(""+this.mEntityId);
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_entity_id",unique = true, nullable = false)
    private Long mEntityId;

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

	@OneToOne
    @JoinColumn(name = "m_user_id_updated", nullable = true)
    private M_User mUserIdUpdated;

	@Column(name = "updated_on")
    private Date updatedOn;

	public Long getmEntityId() {
		return mEntityId;
	}

	public void setmEntityId(Long mEntityId) {
		this.mEntityId = mEntityId;
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

	@Transient private Integer parentEntityId;
	@Transient private Integer loationIdTemp;
	@Transient private String actionForList;

	public Integer getParentEntityId() {
		return parentEntityId;
	}

	public void setParentEntityId(Integer parentEntityId) {
		this.parentEntityId = parentEntityId;
	}

	public Integer getLoationIdTemp() {
		return loationIdTemp;
	}

	public void setLoationIdTemp(Integer loationIdTemp) {
		this.loationIdTemp = loationIdTemp;
	}

	public String getActionForList() {
		return actionForList;
	}

	public void setActionForList(String actionForList) {
		this.actionForList = actionForList;
	}
}