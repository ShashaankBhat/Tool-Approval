package com.anand.masters;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "m_user_entity_map")
public class M_User_Entity_Map implements Comparable<M_User_Entity_Map> {

	@Override
	public int compareTo(M_User_Entity_Map userEntityMap) {
		// TODO Auto-generated method stub
		return Integer.parseInt(""+userEntityMap.entityInfoForUsers.getmEntityId()) - Integer.parseInt(""+this.entityInfoForUsers.getmEntityId());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "m_user_entity_map_id",unique = true, nullable = false)
    private Long mUserEntityMapId;

	@ManyToOne
    @JoinColumn(name="m_user_id", nullable=true)
    private M_User userInfoForEntity;

	@OneToOne
    @JoinColumn(name = "m_entity_id", nullable = true)
	private M_Entity entityInfoForUsers;

	@Column(name="user_entity_active")
	private Integer userEntityActive;

	@Column(name="user_entity_created_on")
	private Date userEntityCreatedOn;

	@OneToOne
    @JoinColumn(name = "user_entity_created_by", nullable = true)
	private M_User userEntityCreatedBy;
}