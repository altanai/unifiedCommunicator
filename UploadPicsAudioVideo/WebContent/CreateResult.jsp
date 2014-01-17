<%@include file="header.jsp" %>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">
<%String message=(String)request.getAttribute("msg"); %>
<br/>
<br/>
<h2 style="color: green;" align="center"><%=message %>!</h2>
<br/>
<br/>
<a href="Home.jsp">Back to Home</a>

      </section>

 <!------------------------------------------ services -------------------------------------------->


<%@include file="footer.jsp" %>