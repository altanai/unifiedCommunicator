<%@include file="header.jsp"%>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">

<table align="center" width="400px" border="1">
<tr>
<td colspan="2" align="center">Task To Perform. 
</td>
</tr>

<tr>
<td>Create User
</td>
<td><a href="CreateUserProfile.jsp">Click Here</a>
</td>
</tr>
<tr>
<td>ViewListOfUsers
</td>
<td><a href="<%=request.getContextPath() %>/CreateUserServlet?action=ViewList">Click Here</a>
</td>
</tr>


</table>
      </section>

 <!------------------------------------------ services -------------------------------------------->


<%@include file="footer.jsp" %>