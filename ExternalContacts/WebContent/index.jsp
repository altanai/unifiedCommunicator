<%@page import="org.scribe.model.Token"%>
<%@page import="org.scribe.builder.ServiceBuilder"%>
<%@page import="org.scribe.oauth.OAuthService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Facebook Friends using Java </title>
</head>
<body>
	<a href="https://www.facebook.com/dialog/oauth?client_id=160619387481905&redirect_uri=http://localhost:8080/facebookfriends/FriendsListServlet">Click Here for FaceBook</a>
	<%
	OAuthService service = new ServiceBuilder()
	.provider(LinkedInApi.class)
	.apiKey("75mczb8zn9ubkd")
	.apiSecret("ZU4PZJzHA692vift")
	.scope("r_fullprofile")
	.scope("r_emailaddress")
	.scope("r_network")
	.build();
		
	Token requestToken = service.getRequestToken();

	 %>
	<a href="https://api.linkedin.com/uas/oauth/authorize?oauth_token=<%=requestToken.getToken()%>&redirect_uri=http://localhost:8080/facebookfriends/index.jsp">Click Here For Linkedin</a>
</body>
</html>