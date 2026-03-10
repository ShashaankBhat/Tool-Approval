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

import jakarta.servlet.http.HttpServletRequest;

public interface M_Member_Level_Service {

	List<M_Member_Level> getMemberLevelList(HttpServletRequest request, Integer offset);

	List<M_Member_Level> getMemberLevelByActiveStatus(Integer memberLevelActive);

	String saveMemberLevelDetails(HttpServletRequest request, M_Member_Level memberLevel);

	String getMemberLevelDetails(HttpServletRequest request);

}
