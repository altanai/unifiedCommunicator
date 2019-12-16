<%@ include file="headerlogin.jsp" %>

    <!-- main -->
    <section id="main" class="clearfix">

<table>
	<tr>
	<td>
	    	 <!-- -----Sign in using fb  -->
		     <%@ include file="fb/oauthfb.jsp" %> <BR/>
			<!-- end signin -->       
	</td>
	</tr>
	
	<tr>
	<td>
	    	 <!-- -----Sign in using google mid part -->
		     <%@ include file="google/oauthgooglemid.jsp" %> <BR/>
			<!-- end signin -->       
	</td>
	</tr>
</table>


<table border=1>
  <col width="1000">
  <col width="1000">

	<tr>
		<td>
		<img src="images/slides/images.jpg">
		</td>
		
		<td>          
					<!-- ------Register new user  -->
					<%@ include file="../newaccountforms/registernewuser.jsp" %>
					<!-- end registration --> 
		  
		</td>
	</tr>
</table>      
      

<!-- footer -->
<div id="footer-wrap"></div>

<%-- <%@ include file="footerlogin.jsp" %> --%>
 <!-- -----Sign in using google  -->
 <%@ include file="google/oauthgooglebottom.jsp" %>
<!-- end signin -->  