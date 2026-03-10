package com.anand.index;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.anand.common.Common_Constants;

@RestController
public class IndexRestController {

	@GetMapping("checkForDomain")
    public String validateDomain(HttpServletRequest request) {
		StringBuilder response = new StringBuilder();
		System.out.println("request.getParameter(\"userEmailId\"): "+request.getParameter("userEmailId"));
		System.out.println(Common_Constants.domainSet1.contains(request.getParameter("userEmailId").split("@")[1]));
        try {
        	if(request.getRequestURL().toString().contains("local") || request.getRequestURL().toString().contains("127.0.0.1") ||
        			request.getRequestURL().toString().contains("172.16.6.42")) {
        		response.append("none");
        	} else if(Common_Constants.domainSet1.contains(request.getParameter("userEmailId").split("@")[1])) {
        		System.out.println("2: "+request.getRequestURL().toString());
            	/*Azure Enterprise Application Name - ANAND-Central-Test*/
        		response.setLength(0);
            	if(request.getRequestURL().toString().contains("all-apps")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=4ce17fa2-9752-4489-ab82-014b4fd0b602"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/all-apps/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=2cb9d070-795b-49c8-a0ad-d5dc3cea1921"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/all-apps/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else if(request.getRequestURL().toString().contains("check-sheet")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=4ce17fa2-9752-4489-ab82-014b4fd0b602"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/check-sheet/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=2cb9d070-795b-49c8-a0ad-d5dc3cea1921"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/check-sheet/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else if(request.getRequestURL().toString().contains("coaching")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=4ce17fa2-9752-4489-ab82-014b4fd0b602"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/coaching/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=2cb9d070-795b-49c8-a0ad-d5dc3cea1921"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/coaching/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            			/*response.append("none");*/
            		}
            	} else if(request.getRequestURL().toString().contains("visitor-management")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=4ce17fa2-9752-4489-ab82-014b4fd0b602"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/visitor-management/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=2cb9d070-795b-49c8-a0ad-d5dc3cea1921"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/visitor-management/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            			/*response.append("none");*/
            		}
            	} else {
            		response.append("https://login.microsoftonline.com/8ab2a5cc-70b9-4dd0-a70d-42307a4be2ed/oauth2/v2.0/authorize?"
                			+ "response_type=token&client_id=2cb9d070-795b-49c8-a0ad-d5dc3cea1921"
                			+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                			+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                			+ "&redirect_uri=http://localhost:8080/sso/redirect"
                			+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            	}
            	
            	
            } else if(Common_Constants.domainSet2.contains(request.getParameter("userEmailId").split("@")[1])) {
            	System.out.println("2"+request.getRequestURL().toString());
            	response.setLength(0);
            	if(request.getRequestURL().toString().contains("all-apps")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/5fe42ea5-6916-40b7-811e-0340710315ca/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=ec7313e3-08d1-4549-9d1c-a2392140a4ac"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/all-apps/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/5fe42ea5-6916-40b7-811e-0340710315ca/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=ec7313e3-08d1-4549-9d1c-a2392140a4ac"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/all-apps/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else if(request.getRequestURL().toString().contains("check-sheet")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/5fe42ea5-6916-40b7-811e-0340710315ca/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=ec7313e3-08d1-4549-9d1c-a2392140a4ac"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/check-sheet/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/5fe42ea5-6916-40b7-811e-0340710315ca/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=ec7313e3-08d1-4549-9d1c-a2392140a4ac"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/check-sheet/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else if(request.getRequestURL().toString().contains("visitor-management")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/5fe42ea5-6916-40b7-811e-0340710315ca/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=ec7313e3-08d1-4549-9d1c-a2392140a4ac"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/visitor-management/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/5fe42ea5-6916-40b7-811e-0340710315ca/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=ec7313e3-08d1-4549-9d1c-a2392140a4ac"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/visitor-management/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else {
            		/*GIL Tenanet - Gabriel Java Projects*/
            		response.append("https://login.microsoftonline.com/5fe42ea5-6916-40b7-811e-0340710315ca/oauth2/v2.0/authorize?"
                			+ "response_type=token&client_id=ec7313e3-08d1-4549-9d1c-a2392140a4ac"
                			+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                			+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                			+ "&redirect_uri=http://localhost:8080/sso/redirect"
                			+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            	}
            	/*response.append("2");*/
            } else if(Common_Constants.domainSet3.contains(request.getParameter("userEmailId").split("@")[1])) {
            	response.setLength(0);
            	
            	if(request.getRequestURL().toString().contains("all-apps")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/17df320f-1642-4a77-a0b3-5a7edbc878a8/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=8e501530-5268-4250-9c81-eeaf8a325a60"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/all-apps/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/17df320f-1642-4a77-a0b3-5a7edbc878a8/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=8e501530-5268-4250-9c81-eeaf8a325a60"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/all-apps/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else if(request.getRequestURL().toString().contains("check-sheet")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/17df320f-1642-4a77-a0b3-5a7edbc878a8/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=8e501530-5268-4250-9c81-eeaf8a325a60"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/check-sheet/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/17df320f-1642-4a77-a0b3-5a7edbc878a8/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=8e501530-5268-4250-9c81-eeaf8a325a60"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/check-sheet/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else if(request.getRequestURL().toString().contains("visitor-management")) {
            		if(request.getRequestURL().toString().contains("anandapps.anandgroupindia.com")) {
            			/*Production Environment*/
            			response.append("https://login.microsoftonline.com/17df320f-1642-4a77-a0b3-5a7edbc878a8/oauth2/v2.0/authorize?"
            				+ "response_type=token&client_id=8e501530-5268-4250-9c81-eeaf8a325a60"
            				+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
            				+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
            				+ "&redirect_uri=https://anandapps.anandgroupindia.com/visitor-management/sso/redirect"
            				+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		} else {
            			/*UAT Environment*/
            			response.append("https://login.microsoftonline.com/17df320f-1642-4a77-a0b3-5a7edbc878a8/oauth2/v2.0/authorize?"
                    		+ "response_type=token&client_id=8e501530-5268-4250-9c81-eeaf8a325a60"
                    		+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                    		+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                    		+ "&redirect_uri=https://ananduat.anandgroupindia.com/visitor-management/sso/redirect"
                    		+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            		}
            	} else {
            		/*AiPL Tenanet - AiPL Java Projects*/
            		response.append("https://login.microsoftonline.com/17df320f-1642-4a77-a0b3-5a7edbc878a8/oauth2/v2.0/authorize?"
                			+ "response_type=token&client_id=8e501530-5268-4250-9c81-eeaf8a325a60"
                			+ "&scope=openid%20profile%20offline_access%20https://graph.microsoft.com/User.Read"
                			+ "&state=ABjEhhBGwPwmCTRa4bbauVUvI3paUn3ev-ApLrPPrh8%3D"
                			+ "&redirect_uri=http://localhost:8080/sso/redirect"
                			+ "&nonce=zhrehC3buq4FkdKERV4XEeT-PCiCdTVzXnWgXBVcLeo&sso_reload=true");
            	}            	
            	
            	/*response.append("3");*/
            } else {
            	response.append("none");
            }
        } catch (Exception ex) {
        	response.append("error");
        }
        System.out.println(response.toString()+" final response");
        return response.toString();
    }
}
