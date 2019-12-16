<%@page import="com.tcs.webrtc.uploadmodule.bean.UserProfile"%>

 <%@include file="header.jsp" %> 


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">
<%UserProfile user=(UserProfile)request.getAttribute("user"); %>

      <table  >
<tr>

<td colspan=2><img src="<%=request.getContextPath() %>/CreateUserServlet?id=<%=user.getName()%>&action=getProfilePic" width="180" height="210"/>
</td>
<%-- <td>

<form enctype="multipart/form-data" name="f2" method="post" action="<%=request.getContextPath() %>/updateDetailsServlet">
<table> --%>

 </tr>


<!-- </table>
</form>
</td>
</tr> -->

<br/>

 
<br/>
<br/>

<tr>
<td>Display Name:</td>
<td><%= user.getDisplayName().toString() %></td>
</tr>
<tr>
<td>Public Identity:</td>
<td><%= user.getPublicIdentity().toString() %></td>
</tr>
<tr>
<td>Private Identity: &nbsp;&nbsp;&nbsp;&nbsp;</td>
<%-- <td><%= user.getPrivateIdentity().toString() %></td> --%>
<td><%= user.getPrivateIdentity().toString() %></td>
</tr>
<%-- <tr>
<td>Password:</td>
<td><%= user.getPassword().toString() %></td>
</tr> --%>
 <tr>
<td>Email:</td>
<td><%= user.getWsUri().toString() %></td>
</tr>
<tr> 
<td>Realm:</td>
<td><%= user.getRealm().toString() %><br/><br/></td>
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

</table> 

                 
      </section>
 <!------------------------------------------ services -------------------------------------------->


<div id="footer-wrap"></div> 
