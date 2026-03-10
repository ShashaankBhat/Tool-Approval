/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - R S Iyer
 */
package com.anand.masters;
/**
 * *******************************************************************************************
 * Copyright © 2025 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Anand Group India - S Iyer
 */
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface M_App_Service {

	List<M_App> getAppList(HttpServletRequest request, Integer offset);

	List<M_App> getAppByActiveStatus(Integer roleActive);

	String saveAppDetails(HttpServletRequest request, M_App role);

	String getAppDetails(HttpServletRequest request);
}
