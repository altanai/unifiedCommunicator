<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BitsPedia - Facebook Friends List</title>

<style type="text/css">
#result_friends {
    margin: 0 auto;
    overflow: hidden;
    width: 900px;
}
#result_friends h2 {
    text-align: center;
}
#result_friends div {
    border: 1px solid #888;
    box-shadow: 3px 3px 0 #000;
    float: left;
    margin-bottom: 10px;
    margin-right: 10px;
    padding: 5px;
    width: 275px;
}
#result_friends img {
    float: left;
    margin-right: 10px;
}


</style>

</head>
<body>
	<h1>Friends List</h1>
	<table>
		<c:forEach items="${friendsList}" var="user">
			<tr>
				<td><img src='https://graph.facebook.com/<c:out value="${user.id}"/>/picture?type=normal' /></td>
				<td><c:out value="${user.name}" /></td>
				<td><c:out value="${user.id}"/></td>
				<td><c:out value="${user.gender}"/></td>
				<td><c:out value="${user.email}"/></td>
				
			</tr>
		</c:forEach>
	</table>
</body>
</html>