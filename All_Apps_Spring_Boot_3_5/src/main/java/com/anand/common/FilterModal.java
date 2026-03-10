/**
 * ******************************************************************************************
 * Copyright © 2024 ANAND Automotive Private Limited. All rights reserved.					*
 * No part of this product may be reproduced in any form by any means without prior			*
 * written authorization of ANAND Automotive Private Limited and its licensors, if any.		*
 * ******************************************************************************************
 * Author - ANAND Automotive Private Limited - Corporate IT - R S Iyer						*
 * ******************************************************************************************
 */
package com.anand.common;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FilterModal {

	private Long parentEntityId;

	private Long childEntityId;

	private Long zoneId;

	private Long departmentId;
}