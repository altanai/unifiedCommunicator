<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>WebRTC</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/ScreenCallersServlet" method="post">
<H2>Block Users</H2>
Sip-Uri:<input type="text" name="sip_uri" id="sip_uri">
<input type="submit" value="Screen User"/>
<input type="hidden" value="addBlackUser" name="action">
</form>
</body>
</html>