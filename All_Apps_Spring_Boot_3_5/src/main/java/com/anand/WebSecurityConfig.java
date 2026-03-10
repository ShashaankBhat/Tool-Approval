/**
 * *******************************************************************************************
 * Copyright © 2021 Anand Group India. All rights reserved.
 * No part of this product may be reproduced in any form by any means without prior
 * written authorization of Anand Automotive Private Limited and its licensors, if any.
 * *******************************************************************************************
 * Author - Sheshadhri Iyer
 */
package com.anand;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class WebSecurityConfig {

	@Autowired private DataSource dataSource;

	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		return bCryptPasswordEncoder;
	}

	@Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new CustomAuthenticationFailureHandler();
    }

	/** Ignore these folders and allow the spring boot app to read files from these */
	/** *************************************************************************** */
	@Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
		System.out.println("Web Security Configuration");
        return (web) -> web.ignoring().requestMatchers("/images/**","/plugins/**","/dist/**","/usedStaticFiles/**");
    }

	@Bean
    public UserDetailsManager users(DataSource dataSource) {
		System.out.println("User Detail Configuration");
        JdbcUserDetailsManager users = new JdbcUserDetailsManager(dataSource);
        users.setUsersByUsernameQuery("select user_login_id as username, user_password as password, user_active as enable from m_user where user_login_id = ?");
        users.setAuthoritiesByUsernameQuery("select ium.user_login_id as username, irm.role_name as role from m_user ium "
				   + "join m_user_role_map iurm on iurm.m_user_id = ium.m_user_id "
				   + "join m_role irm on irm.m_role_id = iurm.m_role_id "
				   + "where ium.user_login_id = ?");
        return users;
    }

	/** Basic Project Configuration which will affect the basic mapping load of the project */
	/** *********************************************************************************** */
	@Bean
    protected SecurityFilterChain httpSecurityConfig(HttpSecurity http) throws Exception {
		System.out.println("Basic Project Configuration");
		http.headers(cache -> cache.disable());
		http
				/* .headers().frameOptions().disable() */
		.headers(headers -> headers.frameOptions(frame -> frame.disable()))
		.authorizeHttpRequests(request -> request.requestMatchers("/", "/login", "/checkForDomain", "/forgot-password","/sign-up","/sign-up-mid","/app-company",
				"/sso/redirect", "/sso/authenticateUser", "/sso/accessToken/checkUser", "/sso/main", "/sso/sign-up", "/app-company-mid", "/authenticateUserCompanyAppPage",
				"/getSubmittedAnswers","/submitAnswers","/deleteQuestion","/checkUserExists", "/session-timeout", "/deny").permitAll()
				.requestMatchers("/WEB-INF/**","/main-sso").permitAll()
		.anyRequest().authenticated())
			.formLogin(formLogin -> formLogin.loginPage("/login").failureUrl("/login?error=true")
					.defaultSuccessUrl("/main").permitAll()
					.usernameParameter("email")
					.passwordParameter("password")
					.successHandler(new SuccessLoginHandler())
					.failureHandler(authenticationFailureHandler()))
			.logout(logout -> logout.logoutUrl("/logout").logoutSuccessUrl("/login?logout=out"))
			.exceptionHandling(exception -> exception.accessDeniedPage("/deny"));
		http.sessionManagement(session -> session.maximumSessions(1));

		/*Cross-Site Request Forgery*/
		http.csrf(csrf -> csrf.disable());
		return http.build();
	}

	/** Used to store the persistent login tokens for a user. */
	/** ***************************************************** */
	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		System.out.println("Persistent Token Repository");
		JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
		tokenRepository.setDataSource(dataSource);
		return tokenRepository;
    }

	/** SSO Reference */
	/*@Bean public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
		System.out.println("AuthenticationManager");
		return http.getSharedObject(AuthenticationManagerBuilder.class).build();
	}*/
	@Bean
    public AuthenticationManager authenticationManager(CustomAuthenticationProvider customProvider) {
        return new ProviderManager(List.of(customProvider));
    }

}
