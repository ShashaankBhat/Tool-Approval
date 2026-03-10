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

public interface M_Role_Service {

	List<M_Role> getRoleList(HttpServletRequest request, Integer offset);

	List<M_Role> getRoleByActiveStatus(Integer roleActive);

	String saveRoleDetails(HttpServletRequest request, M_Role role);

	String getRoleDetails(HttpServletRequest request);

	Integer getUrlAccessForUser(HttpServletRequest request, String url);

}
