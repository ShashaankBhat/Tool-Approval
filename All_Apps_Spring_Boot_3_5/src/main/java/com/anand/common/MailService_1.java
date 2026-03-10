package com.anand.common;
/*
 * import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.File;

@Service*/
public class MailService_1 {

	/*
	 * @Autowired private JavaMailSender mailSender;
	 * 
	 * public void sendMail(String to, String subject, String bodyContent) throws
	 * Exception { MimeMessage message = mailSender.createMimeMessage();
	 * 
	 * true = multipart message MimeMessageHelper helper = new
	 * MimeMessageHelper(message, true);
	 * 
	 * helper.setFrom("your_email@gmail.com"); helper.setTo(to);
	 * helper.setSubject(subject);
	 * 
	 * HTML content helper.setText(bodyContent, true);
	 * 
	 * Attach inline image (logo.png) String path = this.getClass().getClassLoader()
	 * .getResource("") .getPath() .replace("/classes/",
	 * "/classes/static/usedStaticFiles/essentials/images"); String fullPath =
	 * java.net.URLDecoder.decode(path, "UTF-8");
	 * 
	 * FileSystemResource res = new FileSystemResource(new File(fullPath +
	 * File.separator + "logo.png")); helper.addInline("logoImage", res);
	 * 
	 * mailSender.send(message); System.out.println("Mail sent successfully!"); }
	 */
}
