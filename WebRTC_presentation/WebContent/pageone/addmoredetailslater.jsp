<%@ include file="headerloginnew.jsp" %>

    <!-- main -->
    <section id="main" class="clearfix">

<table>
  <col width="800">
  <col width="800">

<tr>
<td>          
			 <!-- ------Register new user  -->
			<%-- <%@ include file="../newaccountforms/registernewuserstep2.jsp" %> --%>
			<!-- end registration --> 
	
          <iframe src="../newaccountforms/registernewuserstep2.jsp"  height="300" width="1000"  frameborder="0" scrolling="no"></iframe>       
  
</td>
</tr>

<tr>
<td>

<iframe src="../../UserProfile/address.jsp"  height="500" width="1000"  frameborder="0" scrolling="no"></iframe>       

</td>
</tr>

<tr>
<td>

<iframe src="../../UserProfile/student.jsp"  height="500" width="300"  frameborder="0" scrolling="no"></iframe>       

</td>
<td>

<iframe src="../newaccountforms/jobseeker.jsp"  height="500" width="300"  frameborder="0" scrolling="no"></iframe>       

</td>
<td>

<iframe src="../newaccountforms/professional.jsp"  height="500" width="300"  frameborder="0" scrolling="no"></iframe>       

</td>
</tr>

</table>      
      

<!-- footer -->
<%@ include file="footer.jsp" %>