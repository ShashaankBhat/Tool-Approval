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

import jakarta.servlet.http.HttpServletRequest;

public interface VMS_M_Visitor_Purpose_Service {

	List<VMS_M_Visitor_Purpose> getVisitorPurposeList(HttpServletRequest request, Integer offset);

	List<VMS_M_Visitor_Purpose> getVisitorPurposeByActiveStatus(Integer visitorPurposeActive);

	String saveVisitorPurposeDetails(HttpServletRequest request, VMS_M_Visitor_Purpose visitorPurpose);

	String getVisitorPurposeDetails(HttpServletRequest request);

}
