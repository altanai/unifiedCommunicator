 <%@include file="headerloginnew.jsp" %>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">

          <iframe src="../../UploadPicsAudioVideo/CreateUserServlet?action=getUser&id=<%=session.getAttribute("privateIdentity")%>"  height="600" width="1000"  frameborder="0"></iframe>       

			<a href="<%=request.getContextPath()%>/deleteAccountServlet">Delete My account</a>  
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<a href="<%=request.getContextPath()%>/../Otheraccounts/thirdpartyaccountsServlet"> Link My Account to Other Accounts</a>    
 			
    </section>



 <!---------------------------------------------------------------------------> 
<div id="footer-wrap">
 <%-- <%@include file="footer.jsp" %> --%>
 </div> 