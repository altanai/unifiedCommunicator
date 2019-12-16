<%@include file="headerservice.jsp" %>

 <%--    <section id="main"> --%>
 
 <br/><br/> <br/><br/>
         <iframe src="http://<%=session.getAttribute("serverip")%>:8080/Geolocation/ViewUserServlet?user=<%=session.getAttribute("privateIdentity")%>"
        width="1100" height="700" align="left" scrolling="no"></iframe> 
                     
<%--       </section>

<%@include file="footer.jsp" %> --%>