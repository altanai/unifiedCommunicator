<%@include file="header.jsp" %>


 <!-----------------------------------------------------Analytics ---------------------------->
    <section id="main">
 
         <iframe src="http://<%=session.getAttribute("serverip")%>:8080/EnhancedWebRTCCallLogs/AnalyticsServlet"
        id="myIframe" frameborder="0" width="1000" height="700" align="left" scrolling="no"></iframe> 
           
                      
<%--       </section>

<%@include file="footer.jsp" %> --%>