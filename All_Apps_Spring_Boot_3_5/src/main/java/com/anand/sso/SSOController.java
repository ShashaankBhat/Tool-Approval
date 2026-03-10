package com.anand.sso;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestTemplate;

import com.anand.masters.M_User_Service;

@Controller
public class SSOController {

	@Autowired private M_User_Service mUserService;
	@Autowired private AuthenticationManager authenticationManager;

	@GetMapping("sso/redirect")
	public String handleOAuthCallback() {
		System.out.println("SSO Redirect");
		return "sso_redirect";
	}

	@GetMapping("sso/main")
	public String handleOAuthCallbackMain() {
		System.out.println("SSO Redirect Main");
		return "redirect:/main";
	}

	@GetMapping("sso/sign-up")
	public String handleOAuthCallbackSignUp(HttpServletRequest request) {
		System.out.println("SSO Redirect Sign UP SSO");
		return "redirect:/sign-up-mid?email="+request.getParameter("email")+"&firstName="+request.getParameter("firstName")+"&lastName="+request.getParameter("lastName");
	}

	@PostMapping("sso/accessToken/checkUser")
	public ResponseEntity<UserResponse> handleAccessToken(@RequestBody TokenRequest tokenRequest) {
		try {
			String accessToken = tokenRequest.getToken();
			String email = getEmail(accessToken);
			Boolean userExists = mUserService.checkUserExists(email.split("-")[0]);
			UserResponse response = new UserResponse();
			response.setUserExists(userExists);
			System.out.println("***/n"+email);
			response.setEmail(email.split("-")[0]);
			response.setFirstName(email.split("-")[1].split(" ")[0]);
			response.setLastName(email.split("-")[1].split(" ")[1]);
			response.setCompanyName(email.split("-")[2]);
			System.out.println(email.split("-")[2]);
			userExists = null; email = null; accessToken = null;
			return new ResponseEntity<>(response, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	private String getEmail(String token) {
		try {
			System.out.println("getEmail function");
			HttpHeaders headers = new HttpHeaders();
			headers.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
			headers.add(HttpHeaders.AUTHORIZATION, ("Bearer " + token));
			HttpEntity<Object> entity = new HttpEntity<>(headers);
			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<GraphResponse> responseEntity = restTemplate.exchange("https://graph.microsoft.com/v1.0/me",
					HttpMethod.GET, entity, GraphResponse.class);
			GraphResponse result = responseEntity.getBody();
			StringBuilder checkCompanyName = new StringBuilder();
			if (result == null) {
				throw new RuntimeException("Not found");
			} else {
				ResponseEntity<GraphResponse> responseEntityC = restTemplate.exchange("https://graph.microsoft.com/beta/users/"+result.getId(),
						HttpMethod.GET, entity, GraphResponse.class);
				GraphResponse resultC = responseEntityC.getBody();
				if (resultC == null) {
					throw new RuntimeException("Not found");
				} else {
					System.out.println("Comapny Name: "+resultC.getCompanyName());
					checkCompanyName.append(resultC.getCompanyName());
				}
			}
			System.out.println("checkCompanyName: "+checkCompanyName.toString());
			return result.getMail()+"-"+result.getDisplayName()+"-"+checkCompanyName.toString();
		} catch (Exception ex) {
			throw new RuntimeException("Username Not Found");
		}
	}

	@PostMapping("sso/authenticateUser")
	private ResponseEntity<Boolean> performLogin(@RequestBody UserResponse user, HttpServletRequest request) {
		try {
			System.out.println("authenticateUser function");
			String userLoginId = user.getEmail();
			String userPassword = mUserService.getUserPassword(userLoginId);
			UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userLoginId, userPassword);
			Authentication authentication = authenticationManager.authenticate(token);
			SecurityContextHolder.getContext().setAuthentication(authentication);
			// Set authentication in SecurityContext
	        SecurityContext context = SecurityContextHolder.createEmptyContext();
	        context.setAuthentication(authentication);
	        SecurityContextHolder.setContext(context);

	        // Persist context in session
	        HttpSession session = request.getSession(true);
	        session.setAttribute(
	            HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
	            context
	        );

			System.out.println("----------------------------"+authentication.getName());
			System.out.println("Authentication Complete ----");
			System.out.println("----------------------------");
			return new ResponseEntity<>(true, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(false, HttpStatus.OK);
		}
	}

	@PostMapping("authenticateUserCompanyAppPage")
	private ResponseEntity<Boolean> authenticateUserCompanyAppPage(@RequestBody String userEmail) {
		try {
			System.out.println("authenticateUser function from company page: "+userEmail);
			String userPassword = mUserService.getUserPassword(userEmail);
			UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userEmail, userPassword);
			Authentication authentication = authenticationManager.authenticate(token);
			SecurityContextHolder.getContext().setAuthentication(authentication);
			return new ResponseEntity<>(true, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(false, HttpStatus.OK);
		}
	}
}