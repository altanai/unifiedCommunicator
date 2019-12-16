 <%@include file="headerloginnew.jsp" %>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">

<table>
<tr>
<td> <iframe src="../../UploadPicsAudioVideo/CreateUserServlet?action=getUser&id=<%=session.getAttribute("privateIdentity")%>"  height="600" width="500"  frameborder="0" align="left"></iframe>       
</td>
<td> <iframe src="<%=request.getContextPath()%>/../Otheraccounts/thirdpartyaccountsdisplayServlet?id=<%=session.getAttribute("privateIdentity")%>"  height="300" width="500"  frameborder="0" align="right"></iframe>       

<iframe src="../../Geolocation/geolocationalone.jsp"  height="300" width="500"  frameborder="0" align="right"></iframe>       

</td>
</tr>
</table>
                  
			<a href="<%=request.getContextPath()%>/deleteAccountServlet">Delete My account</a>  
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<a href="<%=request.getContextPath()%>/../Otheraccounts/thirdpartyaccountsfetchServlet?id=<%=session.getAttribute("privateIdentity")%>"> Link My Account to Other Accounts</a>    
 			
    </section>



 <!---------------------------------------------------------------------------> 
<div id="footer-wrap">
 <%-- <%@include file="footer.jsp" %> --%>
 </div> 