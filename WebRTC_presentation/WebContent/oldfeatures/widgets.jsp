<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%@ page language="java"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>JSP Multiple Checkbox</title>
</head>
<body><form name="form1" onsubmit="checkBoxValidation()">
<table align="center">
<tr>
<td><input type="checkbox" name="widget" value="<iframe id='datetime' src ='../widgets/dateTime.jsp'></iframe>"/> Date Time</td>
<td><input type="checkbox" name="widget" value="<iframe id='googlecalendar' src ='../widgets/googleCalendar.jsp'></iframe>"/>Google Calendar</td>
<td><input type="checkbox" name="widget" value="<iframe id='googlemap' src ='../widgets/googleMap.jsp'></iframe>"/>Google Map</td>
<td><input type="checkbox" name="widget" value="<iframe id='twitter' src ='../widgets/twitter.jsp'></iframe>"/>Twitter</td>
<td><input type="checkbox" name="widget" value="<iframe id='weather' src ='../widgets/weather.jsp'></iframe>"/>Weather</td>
<td><input type="checkbox" name="widget" value="<iframe id='gmail' src ='../widgets/gmail.jsp'></iframe>"/>GMail</td>
<td><input type="checkbox" name="widget" value="<iframe id='stockticker' src ='../widgets/stockTicker.jsp'></iframe>"/>Stock Ticker</td>
<td><input type="checkbox" name="widget" value="<iframe id='weather' src ='../widgets/weather.jsp'></iframe>"/>Weather</td>

</tr>
<tr >
<td colspan="8" align="center" ><input type="submit" value="submit"/></td>
</tr>
</table>
</form>

<%-- <%String widgets[]= request.getParameterValues("widget");
if(widgets != null){%>
<ul>
<%for(int i=0; i<widgets.length; i++){%>
<li><%=widgets[i]%></li>
<%}%>
</ul>
<%}%> --%>

<%String widgets[]= request.getParameterValues("widget");
if(widgets != null){%>
<table>
<tr>
<%for(int i=0; i<widgets.length; i++){%>
<td>
<%=widgets[i]%>
</td>
<%}%>
</tr>
<%}%>
</table>
</body>
</html>