<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="contacts.google.googleContacts"%>
<%@page import="contacts.google.googleContacts1Servlet"%>
<%
	ArrayList<googleContacts> list = new ArrayList<googleContacts>();
	list = (ArrayList) request.getAttribute("googleContacts");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Google Contacts</title>

<!-- <script type="text/JavaScript">
	function AutoRefresh(interval) {
		setTimeout("location.reload(true);", interval);
	}
</script>
<body onload="JavaScript: AutoRefresh(6000);"> -->
</head>

<body>
	<table border="1">

		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Email Address</th>
			<th>Priority</th>
		</tr>
		<%
			for (int i = 1; i < list.size(); i++) {
		%>
		<tr>

			<td><%=list.get(i).getFirstName().toString()%></td>
			<td><%=list.get(i).getLastName().toString()%></td>
			<td><%=list.get(i).getEmailAddress().toString()%></td>
			<td><%=list.get(i).getPriority().toString()%></td>
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>