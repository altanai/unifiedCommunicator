<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%session.setAttribute("privateIdentity", "sip:bob@tcs.com"); %>
<a href="<%=request.getContextPath() %>/VoiceMailServlet?action=record&id=<%=session.getAttribute("privateIdentity").toString() %>">Record Voice Mail</a><br>
<a href="<%=request.getContextPath() %>/ViewVoiceMails.jsp">Listen Voice Mail</a>

</body>
</html>