package com.anand;

import com.anand.masters.M_User;
import com.anand.masters.M_User_Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired private M_User_Service mUserService;

	private static final int MAX_LOGIN_ATTEMPTS = 3;
	private static final long ONE_HOUR_IN_MILLIS = 60 * 60 * 1000; // 1 hour in milliseconds

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		try {
			M_User mUser = mUserService.getUserInformationByUserName(authentication.getName());
			if(mUser == null){
				System.out.println("1 -------------------");
				throw new BadCredentialsException("Invalid username");
			} else {
				String passwordInDB = mUser.getUserPassword();
				BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
				String userEnteredPassword = authentication.getCredentials().toString();
				System.out.println(passwordInDB);
				System.out.println(userEnteredPassword);
				System.out.println(authentication.getCredentials().toString().equalsIgnoreCase(mUser.getUserPassword()));
				System.out.println(encoder.matches(userEnteredPassword, passwordInDB));
				Integer proceedFlag = 1;
				if(!authentication.getCredentials().toString().equalsIgnoreCase(mUser.getUserPassword())) {
					if(!encoder.matches(userEnteredPassword, passwordInDB)) {
						proceedFlag = 0;
					}
				}
				System.out.println("Proceed Flag: "+proceedFlag);
				if(proceedFlag.compareTo(0) == 0) {
					System.out.println("2 -------------------");
					incrementLoginAttempts(mUser.getUserLoginId());
					throw new BadCredentialsException("Invalid username or password");
				} else {
					resetLoginAttempts(mUser.getUserLoginId());
					List<GrantedAuthority> rolesForUser = getRolesForUser(mUser);
					System.out.println("3 ------------------- : "+authentication.getName());
					// Create authenticated user
					//return new UsernamePasswordAuthenticationToken(authentication.getName(), userEnteredPassword, rolesForUser);
					try {
						return new UsernamePasswordAuthenticationToken(authentication.getName(), userEnteredPassword, rolesForUser);
					} catch(Exception e) {
						e.printStackTrace();
						return null;
					}

				}
			}
		} catch (BadCredentialsException ex) {
			System.out.println("4 -------------------");
			ex.printStackTrace();
			throw new BadCredentialsException("2 Invalid username or password", ex);
		} catch (LockedException ex) {
			System.out.println("5 -------------------");
			ex.getMessage();
			incrementLoginAttempts(authentication.getName());
			throw new BadCredentialsException("1 Your ccount is temporarily locked faor 1 hour due to multiple failed login attempts.Please contact to adminstrator", ex);
		} catch (Exception ex) {
			System.out.println("6 -------------------");
			ex.printStackTrace();
			throw new BadCredentialsException("3 Invalid username or password", ex);
		}
	}

	private List<GrantedAuthority> getRolesForUser(M_User mUser) {
		System.out.println("1234567890");
		StringBuilder roles = new StringBuilder();
		List<String> roless = mUserService.getUserRolesByUserLoginId(mUser.getUserLoginId());
		System.out.println(roless.size());
		if(roless.size() != 0) {
			for(String object : roless) {
				System.out.println(object);
				if(roles.toString().length() > 0) {
					roles.append(",");
				}
				roles.append(object);
			}
		}
		roless = null;
		System.out.println("Roles:"+roles.toString());
		List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(roles.toString()));
        return authorities;
    }

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

	private void incrementLoginAttempts(String username) {
		M_User mUser = mUserService.getUserInformationByUserName(username);
		Date lastLogin = mUser.getUserLastLogin();
		Integer currentLoginAttempts = mUser.getUserLoginCount();
		System.out.println("Login Attenpts "+mUser.getUserLoginId()+": "+currentLoginAttempts);
		if(currentLoginAttempts != null ) {
			if (currentLoginAttempts >= MAX_LOGIN_ATTEMPTS) {
				if (lastLogin != null && System.currentTimeMillis() - lastLogin.getTime() > ONE_HOUR_IN_MILLIS) {
					System.out.println("Reset Login Attempt Count");
					mUserService.resetLoginAttempts(mUser.getUserLoginId());
				} else {
					System.out.println("Alert for 1hr");
					throw new LockedException("Your account is temporarily locked for 1 hour due to multiple failed login attempts.Please contact to adminstrator");
				}
			} else {
				/*Increment login attempts*/
				System.out.println("Increment Login Attempt Count");
				mUserService.incrementLoginCount(mUser.getUserLoginId());
				throw new BadCredentialsException("Invalid username or password");
			}
		} else {
			System.out.println("NULL ATTEMPTS Increment Login Attempt Count");
			mUserService.incrementLoginCount(mUser.getUserLoginId());
			throw new BadCredentialsException("Invalid username or password");
		}
	}

	private void resetLoginAttempts(String username) {
		System.out.println("Reset Login Attempt Count: "+username);
		mUserService.resetLoginAttempts(username);
	}
}