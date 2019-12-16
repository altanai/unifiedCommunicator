<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %> 
    <%@ page import="com.tcs.webrtc.interest.dao.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Display interests </title>
</head>
<body>
<%
InterestDao intdao=new InterestDao();
Map<String, String> map=intdao.getallinterests();

for (Map.Entry<String, String> entry : map.entrySet())
{
  //  System.out.println(entry.getKey() + "/" + entry.getValue());
  
  %>
   
   Interest Scope : <%=entry.getKey() %>  <&nbsp> Value: <%=entry.getValue() %> </br>
   
  
  <%
}
%>
</body>
</html>