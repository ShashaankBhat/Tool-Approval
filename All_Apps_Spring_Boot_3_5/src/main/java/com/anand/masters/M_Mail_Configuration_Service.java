package com.anand.masters;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public interface M_Mail_Configuration_Service {

	List<M_Mail_Configuration> getMailConfigurationList(HttpServletRequest request, Integer offset);

	List<M_Mail_Configuration> getMailConfigurationByActiveStatus(Integer mailConfigurationActive);

	String saveMailConfigurationDetails(HttpServletRequest request, M_Mail_Configuration MailConfiguration)  throws Exception;

	String getMailConfigurationDetails(HttpServletRequest request);
}
