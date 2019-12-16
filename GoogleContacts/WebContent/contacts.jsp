<%@include file="headerservice.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%
ArrayList<String> strlist = (ArrayList<String>) request.getAttribute("details");
%>


</br>
</br>
<section id="main">
	<table>
		<%
			for (int i = 0; i < strlist.size(); i++) {
				System.out.println(" " + strlist.get(i).toString());
				String delims = "[*]";
				String token[] = strlist.get(i).toString().split(delims);
		%>
		<tr>
			<td><a href="GoogleFriendsServlet?id=<%=token[0]%>"><%=token[0]%></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<%-- <td><img src=<%=token[1]%> title="image"></td> --%>
			<%-- <td><%=request.getParameter(") %></td> --%>
		</tr>
		<%
			}
		%>
	</table>
</section>
</body>
</html>
<div id="footer-wrap"></div>