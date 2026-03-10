<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <link rel="shortcut icon" href="/usedStaticFiles/essentials/images/favicon/favicon_blue.ico" type="image/x-icon">
		<title>123123ANAND GROUP | SSO | Redirect</title>
		<style>
			body {
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh; /* Ensure the body takes up the full viewport height */
				margin: 0; /* Remove default margin */
			}
			.loader {
				border: 16px solid #f3f3f3; /* Light grey */
				border-top: 16px solid #3498db; /* Blue */
				border-radius: 50%;
				width: 120px;
				height: 120px;
				animation: spin 2s linear infinite;
			}
			@keyframes spin {
				0% { transform: rotate(0deg); }
				100% { transform: rotate(360deg); }
			}
		</style>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	</head>
    <body>
    	<h1>
    		<div class="loader"></div>
    		<div>Please Wait.</div>
    	</h1>
    	<script>
    	    var currentUrl = window.location.href;
    	    console.log(currentUrl);
    		var fragment = window.location.hash;
    		//Check if the fragment contains "access_token"
    		if (fragment.includes("access_token=")) {
    			// Extract the access token value
    			var params = fragment.split("&")[0];
    			var accessToken = params.split("=")[1];
    			$.ajax({
    				url: 'accessToken/checkUser',
    				type: 'POST',
    				contentType: 'application/json',
    				data: JSON.stringify({ token: accessToken }),
    				success: function (response) {
    					console.log('Access token sent successfully:', response);
    					var emailFromSSO = response.email;
    					if (response.userExists === true) {
    						console.log("User Exists");
    						authenticateUser(response, emailFromSSO);
    					} else {
    						console.log("User Not Exists");
    						var emailFromSSO = response.email;
    						if(currentUrl.indexOf("all-apps") != -1) {
    							if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
            						window.location.href = '/all-apps/app-company-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName)+'&companyName='+encodeURIComponent(response.companyName);
            					} else {
            						window.location.href = '/app-company-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName)+'&companyName='+encodeURIComponent(response.companyName);;
            					}
    						} else if(currentUrl.indexOf("check-sheet") != -1) {
    							if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
        							window.location.href = '/check-sheet/sso/sign-up?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName);
        						} else {
        							window.location.href = '/sign-up-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+response.firstName+'&lastName='+response.lastName;
        						}
    						} else if(currentUrl.indexOf("coaching") != -1) {
    							if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
        							window.location.href = '/coaching/sso/sign-up?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName);
        						} else {
        							window.location.href = '/sign-up-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+response.firstName+'&lastName='+response.lastName;
        						}
    						} else if(currentUrl.indexOf("visitor-management") != -1) {
    							if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
        							window.location.href = '/visitor-management/sso/sign-up?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName);
        						} else {
        							window.location.href = '/sign-up-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+response.firstName+'&lastName='+response.lastName;
        						}
    						} else {
    							if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
            						//window.location.href = '/all-apps/app-company-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName)+'&companyName='+encodeURIComponent(response.companyName);
            						window.location.href = '/all-apps/sign-up-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+response.firstName+'&lastName='+response.lastName;
            					} else {
            						//window.location.href = '/app-company-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName)+'&companyName='+encodeURIComponent(response.companyName);;
            						window.location.href = '/sign-up-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+response.firstName+'&lastName='+response.lastName;
            					}
    						}
    					}
    				},
    				error: function (error) {
    					// Handle errors if the POST request fails
    					console.error('Error sending access token:', error);
    				}
    			});
    		} else {
    			console.log("token not available");
    		}
    		function authenticateUser(userRequest, emailFromSSO) {
    			$.ajax({
    				url: 'authenticateUser',
    				type: 'POST',
    				contentType: 'application/json',
    				data: JSON.stringify(userRequest),
    				success: function (response) {
    					console.log('Login successful:', response);
    					console.log("1");
    					// Handle the success response as needed
    					console.log("currentUrl: "+currentUrl);
    					if(currentUrl.indexOf("all-apps") != -1) {
    						if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
    							window.location.href = '/all-apps/app-company-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(userRequest.firstName)+'&lastName='+encodeURIComponent(userRequest.lastName)+'&companyName='+encodeURIComponent(userRequest.companyName);
    						} else {
    							window.location.href = '/app-company-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(userRequest.firstName)+'&lastName='+encodeURIComponent(userRequest.lastName)+'&companyName='+encodeURIComponent(userRequest.companyName);;
    						}
    					} else if(currentUrl.indexOf("check-sheet") != -1) {
    						if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
    							window.location.href = '/check-sheet/main-sso';
    						} else {
    							window.location.href = '/main-sso';
    						}
    					} else if(currentUrl.indexOf("coaching") != -1) {
    						if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
    							window.location.href = '/coaching/main-sso';
    						} else {
    							window.location.href = '/main-sso';
    						}
    					} else if(currentUrl.indexOf("visitor-management") != -1) {
    						if(currentUrl.indexOf("ananduat") != -1 || currentUrl.indexOf("anandapps") != -1) {
    							window.location.href = '/visitor-management/main-sso';
    						} else {
    							window.location.href = '/main-sso';
    						}
    					} else {
    						console.log("1");
    						window.location.href = '/main-sso';
    						//window.location.href = '/app-company-mid?email='+encodeURIComponent(emailFromSSO)+'&firstName='+encodeURIComponent(response.firstName)+'&lastName='+encodeURIComponent(response.lastName)+'&companyName='+encodeURIComponent(response.companyName);;
    					}
    				},
    				error: function (error) {
    					console.error('Error performing login:', error);
    				}
    			});
    		}
    	</script>
    </body>
</html>