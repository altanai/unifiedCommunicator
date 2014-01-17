<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="login.webrtc.login"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="login.userlogin.forgotPasswordServlet"%>
<%
	ArrayList<login> list = new ArrayList<login>();
	list = (ArrayList) request.getAttribute("password");
%>
<%@ include file="headerlogin.jsp" %>

    <!-- main -->
    <section id="main">
<form>
        <table>
	
		<tr>
			<th><h3>Your Password Is:</h3><br/><br/></th>
			
			<td>&nbsp;&nbsp;&nbsp;<%=request.getParameter("pass")%></td>
		</tr>	
					
<!-- 		
		<tr>
			<td><a href="login.jsp">Back To Login Page</a></td>
		</tr> -->
	</table>

</form>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

 <!-- footer -->
<%@ include file="footerlogin.jsp" %>