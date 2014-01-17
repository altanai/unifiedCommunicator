<%@include file="headerservice.jsp" %>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">

          <iframe src="../../UploadPicsAudioVideo/CreateUserServlet?action=getUser&id=sip:<%=session.getAttribute("name")%>@tcs.com"  height="500" width="1000"  frameborder="0" scrolling="no"></iframe>       
    <h4 align="center"><a href="<%=request.getContextPath()%>/deleteAccountServlet" > Delete My Account </a></h4>
    
      </section>

  
 <!---------------------------------------------------------------------------> 

<%@include file="footerservice.jsp" %>