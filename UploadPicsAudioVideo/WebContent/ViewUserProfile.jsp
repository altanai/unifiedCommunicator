<%@page import="com.tcs.webrtc.uploadmodule.bean.UserProfile"%>
<%-- <%@include file="header.jsp"%> --%>



 <!----------------------------------------------------- main ---------------------------->
    <section id="main">
<%UserProfile user=(UserProfile)request.getAttribute("user");%>
<form enctype="multipart/form-data" name="f2" method="post" action="<%=request.getContextPath()%>/updateDetailsServlet">
      <table  >
<tr>

<td colspan=2><img src="<%=request.getContextPath() %>/CreateUserServlet?id=<%=user.getName()%>&action=getProfilePic" width="180" height="210"/>
</td>
<%-- <td>

<form enctype="multipart/form-data" name="f2" method="post" action="<%=request.getContextPath() %>/updateDetailsServlet">
<table> --%>

 <td ><input type="text" name="name" value="<%=user.getName()%>" readonly>
</td>

</tr>

<tr>
<td><input style="padding: 2px 0px 2px 0px;" id="File" type="file" name="picture" /></td>
<td id="FileError" style="color: red;"></td>

<td><input type="submit" name="submit" value="Update"></td>

</tr>
<!-- </table>
</form>
</td>
</tr> -->
</table>
</form>
<br/>

 
<br/>
<br/>
<form name="f1" method ="get" action="<%=request.getContextPath()%>/updateDetailsServlet">
<table>
<tr>
<td>Display Name:</td>
<td><input type="text" name="displayName" value="<%= user.getDisplayName().toString()%>"></td>
</tr>
<tr>
<td>Public Identity:</td>
<td><input type="text" name="publicIdentity" value="<%= user.getPublicIdentity().toString()%>"></td>
</tr>
<tr>
<td>Private Identity: &nbsp;&nbsp;&nbsp;&nbsp;</td>
<%-- <td><%= user.getPrivateIdentity().toString() %></td> --%>
<td><input type="text" name="privateIdentity" value="<%= user.getPrivateIdentity().toString()%>" readonly="readonly"></td>
</tr>
<tr>
<td>Password:</td>
<td><input type="text" name="password" value="<%= user.getPassword().toString()%>"></td>
</tr>
 <tr>
<td>Email:</td>
<td><input type="text" name="wsUri" value="<%= user.getWsUri().toString()%>"></td>
</tr> 
<tr>
<td>Realm:</td>
<td><input type="text" name="realm" value="<%= user.getRealm().toString()%>"><br/><br/></td>
</tr>

<%--  <tr>
<td>Favorite Audio Track:
</td>
<td><a href="<%=request.getContextPath() %>/CreateUserServlet?id=<%=user.getName()%>&action=audio" title="Click this link to download a copy of this Audio" target="_blank"> <%=user.getAudiofile() %></a>
</td>
</tr>
<tr>
<td>Favorite Video Track:
</td>
<td><a href="<%=request.getContextPath() %>/CreateUserServlet?id=<%=user.getName()%>&action=video" title="Click this link to download a copy of this Video" target="_blank"><%=user.getVideofile() %></a>
</td>
</tr> --%> 
<tr>
<td colspan="2" align="center"><input type="submit" name="submit" value="Update"></td>
</tr>
</table> 
</form> 
                 
      </section>
 <!------------------------------------------ services -------------------------------------------->


<%-- <%@include file="footer.jsp" %> --%>
