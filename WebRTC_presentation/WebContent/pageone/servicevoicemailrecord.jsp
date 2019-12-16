<%@include file="headerservice.jsp" %>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">

          <iframe src="<%=request.getContextPath()%>/../../WebRTCVoiceMail/VoiceMailServlet?action=record&id=<%=session.getAttribute("privateIdentity").toString() %>"  height="1000" width="1000"  frameborder="0" scrolling="no"></iframe>       
    
      </section>

  
 <!---------------------------------------------------------------------------> 

<%@include file="footerservice.jsp" %>