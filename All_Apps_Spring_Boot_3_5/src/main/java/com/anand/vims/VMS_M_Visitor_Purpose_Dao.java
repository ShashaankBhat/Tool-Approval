/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - R S Iyer
 */
package com.anand.vims;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface VMS_M_Visitor_Purpose_Dao extends JpaRepository<VMS_M_Visitor_Purpose, Long> {

	@Query(value="select * from vms_m_visitor_purpose order by m_visitor_purpose_id desc limit 20 offset ?", nativeQuery = true)
	List<VMS_M_Visitor_Purpose> getVisitorPurposeWithOffset(Integer offset);

	List<VMS_M_Visitor_Purpose> findByVisitorPurposeActive(Integer visitorPurposeActive);

	List<VMS_M_Visitor_Purpose> findByVisitorPurposeName(String visitorPurposeName);
}
