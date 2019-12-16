<%@ include file="headerservice.jsp" %>

    <!-- main -->
    <section id="main" class="clearfix">

<table>
  <col width="800">
  <col width="800">

<tr>


<td>        
  
    <!-- ------Register new user  -->
			<%-- <%@ include file="../newaccountforms/registerotheraccounts.jsp?googleid="+request.getParameter('googleid')+"&yahooid="+request.getParameter('yahooid')+"&facebookid="+request.getParameter('facebookid')+"&twitterid="+request.getParameter('twitterid')" %>--%>		
 
     <%--      <%@ include file="../newaccountforms/registerotheraccounts.jsp?googleid=request.getParameter("googleid")&yahooid=request.getParameter("yahooid")&facebookid=request.getParameter("facebookid")&twitterid=request.getParameter("twitterid")" %>
--%> 

<% session.setAttribute("googleid", request.getParameter("googleid")); 
 session.setAttribute("yahooid", request.getParameter("yahooid"));
 session.setAttribute("facebookid", request.getParameter("facebookid"));
 session.setAttribute("twitterid", request.getParameter("twitterid")); %>
 
<%@ include file="../newaccountforms/registerotheraccounts.jsp" %>
 
 	<!-- end registration --> 
  
</td>
</tr>
</table>      
      

<!-- footer -->
<div id="footer-wrap">
</div>

</body>
</html>