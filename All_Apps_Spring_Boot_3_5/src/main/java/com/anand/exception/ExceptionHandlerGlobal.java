package com.anand.exception;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionHandlerGlobal {

	/*This is used for any random exception that happens while running the application*/
	@ExceptionHandler(Exception.class)
	public String error(Exception e) {
		String userUploadedName = SecurityContextHolder.getContext().getAuthentication().getName();
		System.out.println("userUploadedName : "+userUploadedName);
		System.out.println("-- : "+SecurityContextHolder.getContext().getAuthentication().getDetails());
		if(userUploadedName.contains("anonymous")) {
			return "redirect:session-timeout";
		} else {
			return "redirect:deny";
		}
	}
}
