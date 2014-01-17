<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>
<h1 align="center">Dear administrator welcome</h1>
<br/>
<br/>
<br/>

<table align="center" width="400px" border="1">
<tr>
<td colspan="2" align="center">Task To Perform. 
</td>
</tr>

<tr>
<td>Create User
</td>
<td><a href="CreateUserProfile.jsp">Click Here</a>
</td>
</tr>
<tr>
<td>ViewListOfUsers
</td>
<td><a href="<%=request.getContextPath() %>/CreateUserServlet?action=ViewList">Click Here</a>
</td>
</tr>


</table>
</body>
</html>