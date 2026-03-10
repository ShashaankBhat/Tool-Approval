/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - R S Iyer
 */
package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_Role_Dao extends JpaRepository<M_Role, Long> {

	/*@Query(value="select * from m_role order by m_role_id desc limit 20 offset ?", nativeQuery = true)
	List<M_Role> getRoleWithOffset(Integer offset);*/

	List<M_Role> findByRoleActive(Integer roleActive);

	List<M_Role> findByRoleName(String roleName);

	List<M_Role> findByRoleNameAndRoleActive(String roleName, Integer roleActice);
}
