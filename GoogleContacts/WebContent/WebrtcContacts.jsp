<%@include file="headerservice.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%
	ArrayList<String> sipuri = (ArrayList<String>) request.getAttribute("webrtcDetails");
%>

</br>
</br>
<section id="main">
<form name="f1" method="post" action="GoogleFriendsServlet">
	<table>
		<%
			for (int i = 0; i < sipuri.size(); i++) {
		%>
		<tr>
		 <% String sipURI = ""; 
				if(sipuri.get(i).toString()!=null) { 
					sipURI = sipuri.get(i).toString();
				}
				%>
			<td><input type="text" name="sipuri" value="<%=sipURI%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><input type="submit" name="submit" value="Add To Friend List"></td>
		</tr>
		<%
			}
		%>
	</table>
	</form>
</section>
</body>
</html>
<div id="footer-wrap"></div>