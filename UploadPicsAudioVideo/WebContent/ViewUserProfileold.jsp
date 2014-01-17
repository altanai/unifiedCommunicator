<%@page import="com.tcs.webrtc.uploadmodule.bean.UserProfile"%>
<%@include file="header.jsp" %>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">
<%UserProfile user=(UserProfile)request.getAttribute("user"); %>

      <table width="500px" align="center" border="1" bordercolor="blue">
<tr>
<td><img src="<%=request.getContextPath() %>/CreateUserServlet?id=<%=user.getName()%>&action=getProfilePic" width="180" height="210"/>
</td>

</tr>
<tr>
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
</tr>
</table>  
                 
      </section>

 <!------------------------------------------ services -------------------------------------------->


<%@include file="footer.jsp" %>