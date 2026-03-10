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

public interface VMS_M_Visitor_Govt_Type_Service {

	List<VMS_M_Visitor_Govt_Type> getVisitorTypeList(HttpServletRequest request, Integer offset);

	List<VMS_M_Visitor_Govt_Type> getVisitorTypeByActiveStatus(Integer visitorTypeGovtActive);

	String saveVisitorTypeDetails(HttpServletRequest request, VMS_M_Visitor_Govt_Type visitorType);

	String getVisitorTypeDetails(HttpServletRequest request);

}
