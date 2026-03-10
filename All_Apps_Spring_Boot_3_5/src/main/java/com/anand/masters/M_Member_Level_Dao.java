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
public interface M_Member_Level_Dao extends JpaRepository<M_Member_Level, Long> {

	/*@Query(value="select * from m_member_level order by m_member_level_id desc limit 20 offset ?", nativeQuery = true)
	List<M_Member_Level> getMemberLevelWithOffset(Integer offset);*/

	List<M_Member_Level> findByMemberLevelActive(Integer roleActive);

	List<M_Member_Level> findByMemberLevelName(String roleName);
}
