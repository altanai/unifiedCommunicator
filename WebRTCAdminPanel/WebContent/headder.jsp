<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ADMIN PANEL</title>

<link rel="stylesheet" href="css/style_blue.css" type="text/css" media="screen" />

<%if(session.getAttribute("adminType")==null){response.sendRedirect("Login.jsp");}%>

</head>
<body>
<div id="header-wrap">
    <header>

		 
		   
	<div><img src="css/jquery-smoothness-theme/images/tcs_logo.png" style="float: left;">

 
        <div style="float:right; font-size:16px; color:white; text-decoration: none; text-shadow: none;">Welcome ADMIN<br>
        <a style="color: white; font-size:14px; margin-right: 30px;" href="AdminHome.jsp">Home</a>
        <a style="color: white; font-size:14px;" href="<%=request.getContextPath()%>/AdminPanelServlet?action=logout">LogOut</a>
</div>

</div>
    </header>
</div>
</body>
</html>