<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.tcs.geolocation.bean.geolocation"%>

  
<%
ArrayList<geolocation> glocationdata=(ArrayList<geolocation>)request.getAttribute("glocationdata");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
         <br/>
         <br/>          
					<form action="GeolocationfriendmapServlet">
						<table>
						<tr>
						<th>Name</th>
						<th>Sip URI</th>
						<th>Latitude</th>
						<th>Longitude</th>
						<th>Date</th>
						<th>Time</th>
						
						</tr>
						
						<%
						for (int i = 0; i < glocationdata.size(); i++) {

					%>
						<tr>
						<td>
								<input type="text" name="friendName" value=<%=glocationdata.get(i).getFriendName().toString()%>>&nbsp;	
							</td>
							<td>
								<input type="text" name="sipuri" value=<%=glocationdata.get(i).getSipuri().toString()%>>&nbsp;	
							</td>
					
							<td>
								<input type="text" name="latitude" value=<%=glocationdata.get(i).getLatitude().toString()%>>&nbsp;
							</td>
			          
							<td>
								<input type="text" name="longitude" value=<%=glocationdata.get(i).getLongitude().toString()%>>&nbsp;	
							</td>
					
							<td>
								<input type="text" name="date" value=<%=glocationdata.get(i).getDate().toString()%>>&nbsp;	
							</td>
				
							<td>
								<input type="text" name="time" value=<%=glocationdata.get(i).getTime().toString()%>>&nbsp;	
							</td>
							
							<td>
								<input type="submit" name="submit"value="Submit">	
							</td>
						</tr>
						
					<% } %>
			              </table>
			              	</form>
			         
</body>
</html>