<%@page import="com.tcs.webrtc.uploadmodule.bean.UserProfile"%>
<%@page import="java.nio.file.attribute.UserPrincipalNotFoundException"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ListOfUsers</title>
</head>
<%
ArrayList<UserProfile> users=(ArrayList<UserProfile>)request.getAttribute("List");
%>
<body>
<h3 align="center">List of Users</h3>
<br/>
<br/>
<table align="center" width="400px" border="1">
<tr><td>ID</td><td>Name</td></tr>
<%for(UserProfile profile:users){ %>
<tr>
<td><a href="<%=request.getContextPath() %>/CreateUserServlet?action=getUser&id=<%=profile.getId() %>" title="Click this link to view complete profile"><%=profile.getId() %></a>
</td>
<td><%=profile.getName() %>
</td>
</tr>
<%} %>
</table>
</body>
</html>