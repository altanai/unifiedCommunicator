<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" type="text/css" href="css/login-box.css"/>
<title></title>
</head>
<body style="background-color: white;">


<div style="padding: 100px 0 0 250px;">


<div id="login-box">

<H2>Admin Login</H2><br>
Please Enter your Credentials.
<br />
<br />
<% String msg="";
if(request.getAttribute("loginMsg")!=null){msg=request.getAttribute("loginMsg").toString();}
%>
<%=msg %>
<form action="<%=request.getContextPath() %>/AdminPanelServlet" method="post">
<div id="login-box-name" style="margin-top:20px;">User Id:</div><div id="login-box-field" style="margin-top:20px;"><input name="userid" class="form-login" title="Username" value="" size="30" maxlength="2048" /></div>
<div id="login-box-name">Password:</div><div id="login-box-field"><input name="password" type="password" class="form-login" title="Password" value="" size="30" maxlength="2048" /></div>
<input type="hidden" name="action" value="login">

<br />

<br />
<br />

<input type="submit"  name="Enter" value="Login" style="margin-left:90px;height: 30px;width: 90px" />
	 </form>			

</div>

</div>


</body>
</html>