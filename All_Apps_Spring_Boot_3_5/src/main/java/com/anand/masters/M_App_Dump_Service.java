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

import jakarta.servlet.http.HttpServletRequest;

public interface M_App_Dump_Service {

	List<M_App_Dump> getAppDumpList(HttpServletRequest request, Integer offset);

	List<M_App_Dump> getAppDumpByActiveStatus(Integer roleActive);

	String saveAppDumpDetails(HttpServletRequest request, M_App_Dump appDump);

	String getAppDumpDetails(HttpServletRequest request);

	List<M_App_Dump> getAppDumpListByEntity(Long mEntityId);

	List<M_App_Dump> getAppDumpListByEntityName(String entityName);
}
