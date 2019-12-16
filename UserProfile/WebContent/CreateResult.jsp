<%@ include file="headerlogin.jsp" %> 

    <!-- main -->
    <section id="main" class="clearfix">

<table>
  <col width="800">
  <col width="800">

<tr>

<td>          
    <!-- ------Register new user  -->
 
 <%String message=request.getParameter("msg");%>
<br/>
<br/>
<h2 style="color: green;" align="center"><%=message %>!</h2>
<!-- end registration -->  
  
</td>
</tr>


<!--  <tr>
<td><a href="http://10.1.5.6:8080/WebRTC_presentation/pageone/home.jsp">Home</a></td>
</tr>
</table> -->   
</section>   
      <div id="footer-wrap"></div>

</body>
</html>
