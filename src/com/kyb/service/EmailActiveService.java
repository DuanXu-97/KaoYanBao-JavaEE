package com.kyb.service;

import java.util.UUID;

import javax.mail.MessagingException;

import com.kyb.util.MailUtil;

public class EmailActiveService {

	public void send_email_service(String to,String username) throws MessagingException {
		
	MailUtil mUtil = new MailUtil();
	String code = UUID.randomUUID().toString().replace("-", "");  //�������code��
	String text =  "<html><head></head><body><h1>����һ�⼤���ʼ�,����������������</h1><h3><a href='http://39.107.251.172/kybnew/ActiveServlet?username="+username+"&code="
            + code + "'>http://39.107.251.172/kybnew/EmailActive?username="+username+"&code=" + code + "</href></h3></body></html>";
	mUtil.send_email(to, text);
	
	}

}
