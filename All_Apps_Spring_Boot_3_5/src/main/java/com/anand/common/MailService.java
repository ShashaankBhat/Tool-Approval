package com.anand.common;

import java.io.File;
import java.net.URLDecoder;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

import jakarta.activation.DataHandler;
import jakarta.activation.FileDataSource;
import jakarta.activation.DataSource;
import jakarta.mail.Authenticator;
import jakarta.mail.BodyPart;
import jakarta.mail.Message;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

import org.springframework.stereotype.Repository;

@Repository
public class MailService {
	/*Creates a thread pool that reuses fixed number of threads(as specified by noOfThreads in this case).*/
	private ScheduledExecutorService mailThreadService = Executors.newScheduledThreadPool(20);

	/*private static String emailUserName = "hr@anandgroupindia.net.in";
	private static String emailPassword = "qcdgadxrxvkfkubc";*/
	private static String emailUserName = "eim.notification@anandgroupindia.net.in";
	private static String emailPassword = "ztmohifxihlcukrh";

	public void sendEmail(String subject, String bodyContent, String mailTo) {
		mailThreadService.submit(new Runnable() {
			@Override
			public void run() {
				try {
					Properties props = new Properties();

					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.socketFactory.port", "587");
					props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", "587"); //port 587 for tls use
					props.put("mail.smtp.socketFactory.fallback", "true");
					props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Adds gmail to trusted smtp
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.ssl.protocols", "TLSv1.2"); //Forces TLS
					
		            Session session = Session.getInstance(props, new Authenticator() {
		            	protected PasswordAuthentication getPasswordAuthentication() {
		            		return new PasswordAuthentication(emailUserName, emailPassword);
		            	}
		            });
		            Message msg = new MimeMessage(session);
		            msg.setFrom(new InternetAddress(emailUserName, false));
		            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mailTo));
		            msg.setSubject(subject);
		            Multipart multipart = new MimeMultipart();
		            BodyPart content = new MimeBodyPart();
		            content.setContent(bodyContent, "text/html");
		            multipart.addBodyPart(content);
		            
		            System.out.println("***********");
		            System.out.println(this.getClass().getClassLoader().getResource("").getPath());
		            System.out.println("***********");
		            String path = this.getClass().getClassLoader().getResource("").getPath().replace("/classes/","/classes/static/usedStaticFiles/essentials/images");
		            String fullPath = URLDecoder.decode(path, "UTF-8");
		            
		            BodyPart logo = new MimeBodyPart();
		            System.out.println(fullPath);
		            DataSource logoFile = new FileDataSource(fullPath+File.separator+"logo.png");
		            logo.setDataHandler(new DataHandler(logoFile));
		            logo.setHeader("Content-ID", "<logoImage>");
		            multipart.addBodyPart(logo);
		            logoFile = null; logo = null;
		            
		            content = null;
		            msg.setContent(multipart);
		            msg.saveChanges();
		            Transport.send(msg);
		            System.out.println("Mail Sent");
		            System.out.println("***********");
		            multipart = null; msg = null;
		            session = null; props = null;
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public void sendEmailToCcAndBcc(String subject, String bodyContent, List<String> mailTo, List<String> ccTo, List<String> bccTo) {
		mailThreadService.submit(new Runnable() {
			@Override
			public void run() {
				try {
					Properties props = new Properties();

					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.socketFactory.port", "587");
					props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", "587"); //port 587 for tls use
					props.put("mail.smtp.socketFactory.fallback", "true");
					props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Adds gmail to trusted smtp
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.ssl.protocols", "TLSv1.2"); //Forces TLS
					
		            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
		            	protected PasswordAuthentication getPasswordAuthentication() {
		            		return new PasswordAuthentication(emailUserName, emailPassword);
		            	}
		            });
		            Message msg = new MimeMessage(session);
		            msg.setFrom(new InternetAddress(emailUserName, false));
		            for(String toEmail : mailTo) {
		            	msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		            }
		            if(ccTo !=  null && ccTo.size() != 0) {
		            	for(String toCc : ccTo) {
			            	msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(toCc));
			            }
		            }
		            if(bccTo !=  null && bccTo.size() != 0) {
		            	for(String toBccEmail : bccTo) {
			            	msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(toBccEmail));
			            }
		            }
		            msg.setSubject(subject);
		            Multipart multipart = new MimeMultipart();
		            BodyPart content = new MimeBodyPart();
		            content.setContent(bodyContent, "text/html");
		            multipart.addBodyPart(content);
		            
		            System.out.println("***********");
		            System.out.println(this.getClass().getClassLoader().getResource("").getPath());
		            System.out.println("***********");
		            String path = this.getClass().getClassLoader().getResource("").getPath().replace("/classes/","/classes/static/usedStaticFiles/essentials/images");
		            String fullPath = URLDecoder.decode(path, "UTF-8");
		            
		            BodyPart logo = new MimeBodyPart();
		            System.out.println(fullPath);
		            DataSource logoFile = new FileDataSource(fullPath+File.separator+"logo.png");
		            logo.setDataHandler(new DataHandler(logoFile));
		            logo.setHeader("Content-ID", "<logoImage>");
		            multipart.addBodyPart(logo);
		            logoFile = null; logo = null;
		            
		            content = null;
		            msg.setContent(multipart);
		            msg.saveChanges();
		            Transport.send(msg);
		            System.out.println(subject+" - Mail Sent");
		            System.out.println("***********");
		            multipart = null; msg = null;
		            session = null; props = null;
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public void sendToCcBccMail(String subject, String bodyContent, List<String> mailTo, List<String> ccTo, List<String> bccTo) {
		mailThreadService.submit(new Runnable() {
			@Override
			public void run() {
				try {
					Properties props = new Properties();
					/*props.put("mail.smtp.host", "smtp.gmail.com");   
		            props.put("mail.smtp.socketFactory.port", "465");   
		            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		            props.put("mail.smtp.auth", "true");   
		            props.put("mail.smtp.port", "465");
		            props.put("mail.smtp.socketFactory.fallback", "true");*/
					
					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.socketFactory.port", "465");
					props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", "465");
					props.put("mail.smtp.socketFactory.fallback", "true");
		            
					/*props.put("mail.smtp.auth", "true");
		            props.put("mail.smtp.starttls.enable", "true");
		            props.put("mail.smtp.host", "smtp.gmail.com");
		            props.put("mail.smtp.port", "587");
		            props.put("mail.smtp.socketFactory.fallback", "true");*/
		            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
		            	protected PasswordAuthentication getPasswordAuthentication() {
		            		return new PasswordAuthentication(emailUserName, emailPassword);
		            	}
		            });
		            Message msg = new MimeMessage(session);
		            msg.setFrom(new InternetAddress(emailUserName, false));
		            for(String toEmail : mailTo) {
		            	msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("sheshadhri.iyer@anandgroupindia.com"));
		            }
		            if(ccTo !=  null && ccTo.size() != 0) {
		            	for(String toCc : ccTo) {
			            	msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(toCc));
			            }
		            }
		            if(bccTo !=  null && bccTo.size() != 0) {
		            	for(String toBccEmail : bccTo) {
			            	msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(toBccEmail));
			            }
		            }
		            msg.setSubject(subject);
		            Multipart multipart = new MimeMultipart();
		            BodyPart content = new MimeBodyPart();
		            content.setContent(bodyContent, "text/html");
		            multipart.addBodyPart(content);
		            content = null;
		            msg.setContent(multipart);
		            msg.saveChanges();
		            Transport.send(msg);
		            System.out.println("Mail Sent");
		            multipart = null; msg = null;
		            session = null; props = null;
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
}