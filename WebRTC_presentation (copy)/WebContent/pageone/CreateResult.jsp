<%@ include file="headerlogin.jsp" %>

    <!-- main -->
    <section id="main" class="clearfix">

<table>
  <col width="800">
  <col width="800">

<tr>

<td>          
    <!-- ------Register new user  -->
 
 <%  String message=request.getParameter("msg"); %>
<br/>
<br/>
<h2 style="color: green;" align="center"><%=message %>!</h2>
<!-- end registration -->  
  
</td>
</tr>
</table>      
      

<!-- footer -->
<%@ include file="footerlogin.jsp" %>