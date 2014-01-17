<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   

<%@include file="headerloginnew.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
<section id="main">
<h3>Have not created profile.</h3>

<%System.out.println("noprofile.jsp"+request.getParameter("displayName")) ;%>
<%System.out.println("noprofile.jsp"+request.getParameter("privateIdentity")) ;%>

<a href="addmoredetailslater.jsp?displayName=<%=request.getParameter("displayName")%>&privateIdentity=<%=request.getParameter("privateIdentity") %>" >Create Profile</a>

</section>
</body>
</html>