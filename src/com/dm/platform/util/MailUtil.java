package com.dm.platform.util;

import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {
	private static MailUtil instance = new MailUtil();
	private MailUtil() {
	}
	public static MailUtil getInstance() {
		return instance;
	}
	public void sendMail(String toAddr,String subject,String content) throws MessagingException {
		Properties props = new Properties();
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.transport.protocol", "smtp");
		
		Session session = Session.getDefaultInstance(props);
		session.setDebug(true);
		
		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress("dmPlatform@163.com"));
		msg.setSubject(subject);
		msg.setSentDate(new Date());
		msg.setText(content);
		Transport trans = session.getTransport();
		trans.connect("smtp.163.com", 25, "dmPlatform", "19901012shui");
		trans.sendMessage(msg, new Address[]{new InternetAddress(toAddr)});
		trans.close();
	}
}
