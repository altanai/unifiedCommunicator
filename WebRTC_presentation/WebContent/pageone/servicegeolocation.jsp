<%@include file="headerservice.jsp" %>

 <%--    <section id="main"> --%>
 
 <br/><br/> <br/><br/>
         <iframe src="http://<%=session.getAttribute("serverip")%>:8080/Geolocation/ViewUserServlet?user=sip:<%=session.getAttribute("name")%>@tcs.com"
        width="1000" height="700" align="left" scrolling="no"></iframe> 
                     
<%--       </section>

<%@include file="footer.jsp" %> --%>