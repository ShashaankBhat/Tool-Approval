/**
 * ******************************************************************************************
 * Copyright © 2021-2022 ANAND Automotive Private Limited. All rights reserved.				*
 * No part of this product may be reproduced in any form by any means without prior			*
 * written authorization of ANAND Automotive Private Limited and its licensors, if any.		*
 * ******************************************************************************************
 * Author - ANAND Automotive Private Limited - Corporate IT - R S Iyer						*
 * ******************************************************************************************
 */
package com.anand.exception;

import jakarta.servlet.http.HttpServletResponse;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CatchErrorController implements ErrorController {

	@RequestMapping("error") //NOSONAR
	public String handleError(HttpServletResponse response) {
		System.out.println(response.getStatus() +" - "+ HttpStatus.NOT_FOUND.value());
		if(response.getStatus() == HttpStatus.NOT_FOUND.value()) {
			return "pageNotFound";
		} else if(response.getStatus() == HttpStatus.BAD_REQUEST.value()) {
			return "pageNotFound";
		} else {
			return "denyPage";
		}
	}
}
