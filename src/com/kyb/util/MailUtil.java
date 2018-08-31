package com.kyb.util;

import java.util.Properties;

import  javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {
	
	public  void send_email(String to,String text) throws MessagingException
	{
		Properties properties = new Properties();
		properties.put("mail.smtp.host","smtp.qq.com");
     	properties.put("mail.smtp.auth","true"); 		
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.port", "465");
	
		Session session = Session.getInstance(properties,new Authenticator() {
			
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("3410731246@qq.com", "epdgunzhblhucjhd");
				
			}
		});
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress("3410731246@qq.com"));
		message.setRecipient(Message.RecipientType.TO,new InternetAddress(to));
		message.setSubject("”√ªßº§ªÓ");
		message.setContent(text,"text/html;charset=UTF-8");
		Transport.send(message);
		
	}
	

}
