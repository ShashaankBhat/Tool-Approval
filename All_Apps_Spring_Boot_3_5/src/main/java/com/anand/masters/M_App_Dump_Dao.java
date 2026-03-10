/**
 * *******************************************************************************************
 * Copyright © 2025 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - S Iyer
 */
package com.anand.masters;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface M_App_Dump_Dao extends JpaRepository<M_App_Dump, Long> {

	/*@Query(value="select * from m_app_dump order by m_app_dump_id desc limit 20 offset ?", nativeQuery = true)
	List<M_App_Dump> getAppDumpWithOffset(Integer offset);*/

	List<M_App_Dump> findByAppDumpActive(Integer appDumpActive);

	List<M_App_Dump> findByAppDumpName(String appDumpName);

	List<M_App_Dump> findByAppDumpEntity(M_Entity appDumpEntity);
}
