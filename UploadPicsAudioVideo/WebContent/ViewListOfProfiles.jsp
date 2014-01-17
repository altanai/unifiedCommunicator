<%@page import="com.tcs.webrtc.uploadmodule.bean.UserProfile"%>

<%@page import="java.util.ArrayList"%>
<%@include file="header.jsp" %>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">
<%
ArrayList<UserProfile> users=(ArrayList<UserProfile>)request.getAttribute("List");
%>

<h3 align="center">List of Users</h3>
<br/>
<br/>
<table align="center" width="400px" border="1">
<tr><td>Name</td></tr>
<%for(UserProfile profile:users){ %>
<tr>
<td><a href="<%=request.getContextPath() %>/CreateUserServlet?action=getUser&id=<%=profile.getName() %>" title="Click this link to view complete profile"><%=profile.getName() %></a>
</td>


</tr>
<%} %>
</table>
      </section>

 <!------------------------------------------ services -------------------------------------------->


<%@include file="footer.jsp" %>