package message.email;

import java.security.Security;
import java.util.Properties;
import javax.net.ssl.*;

import javax.mail.*;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.sun.net.ssl.internal.ssl.*;


public class gmail {

	private static final String SMTP_HOST_NAME = "smtp.gmail.com";
	private static final String SMTP_PORT = "465";
	//private static final String emailSubjectTxt = "A test from gmail";
	//private static final String emailFromAddress = "tcscns@gmail.com";//Your mail-id which goes as From Address
	private static final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
	//private static final String sendTo =  "tara181989@gmail.com";//Addresses of recipients
	String result = null;
    String urlStr="";
	
    
    public void sendemail(String emailFromAddress1, String emailpassword1, String sendTo1,String emailSubjectTxt1,String emailMessageContent1){
    	
    	final String emailSubjectTxt =  emailSubjectTxt1;
    	final String emailMessageContent =  emailMessageContent1;
    	final String emailFromAddress = emailFromAddress1;//Your mail-id which goes as From Address
    	final String sendTo =  sendTo1;//Addresses of recipients
    	final String emailpassword = emailpassword1;
    	
		/*sending an email*/
		boolean debug = true;

           Properties props = new Properties();
           props.put("mail.smtp.host", SMTP_HOST_NAME);
           props.put("mail.smtp.auth", "true");
           props.put("mail.debug", "true");
           props.put("mail.smtp.port", SMTP_PORT);
           props.put("mail.smtp.socketFactory.port", SMTP_PORT);
           props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
           props.put("mail.smtp.socketFactory.fallback", "false");



           Session session = Session.getDefaultInstance
           (	props,new javax.mail.Authenticator()
           	{

        	protected PasswordAuthentication getPasswordAuthentication()
        		{
        	   	    return new PasswordAuthentication(emailFromAddress, emailpassword);//Mail-id and password
        		}
           	}
           );


           Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
           
           session.setDebug(debug);

           Message msg = new MimeMessage(session);
           InternetAddress addressFrom = null;
           InternetAddress addressTo=null;

           try{
					addressFrom = new InternetAddress(emailFromAddress );
					msg.setFrom(addressFrom);

			        addressTo = new InternetAddress();
			        addressTo = new InternetAddress(sendTo);

					msg.setRecipient(Message.RecipientType.TO,addressTo);
					msg.setSubject(emailSubjectTxt);
					msg.setContent(emailMessageContent, "text/html");

					Transport.send(msg);

			        
           		}

         catch(MessagingException e)
         		{
        	 		e.printStackTrace();
         		}
		/*Finish email code*/
    	   	
    }
    
  
   
}
