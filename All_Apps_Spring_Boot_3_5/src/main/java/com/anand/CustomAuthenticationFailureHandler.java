package com.anand;

import java.io.IOException;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		// TODO Auto-generated method stub
		String errorMessage = exception.getMessage();
        Throwable cause = exception.getCause();
        if (exception instanceof BadCredentialsException) {
        	if (cause != null && cause instanceof BadCredentialsException) {
        		errorMessage = cause.getMessage();
        	} else {
        		errorMessage = "Invalid username or password";
        	}
        	request.setAttribute("regMsg_login", errorMessage);
        	request.setAttribute("css_login", "danger");
        	request.getRequestDispatcher("/login?error=true").forward(request, response);
        	System.out.println("Bad Credentials: "+exception.getMessage());
        	return;
        } else if (exception instanceof LockedException) {
        	System.out.println("Locked: "+exception.getMessage());
            errorMessage = exception.getMessage();
        } else if (exception instanceof DisabledException) {
        	System.out.println("Disabled: "+exception.getMessage());
            errorMessage = "Your account is disabled. Please contact the administrator.";
        } else if (exception instanceof AccountExpiredException) {
        	System.out.println("Expired: "+exception.getMessage());
            errorMessage = "Your account has expired. Please contact the administrator.";
        }else {
            errorMessage = "Authentication failed. Please try again.";
        }
        System.out.println("errorMessage: "+errorMessage);
        request.setAttribute("regMsg_login", errorMessage);
        request.setAttribute("css_login", "danger");
        request.getRequestDispatcher("/login?error=true").forward(request, response);
	}
}
