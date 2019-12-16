<!-- -----------------------Header Section--------------------- -->

<%@include file="headder.jsp" %>

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="scripts/jquery.jtable.js"></script>
<script src="scripts/select2.js"></script>
<link rel="stylesheet" type="text/css" href="themes/metro/blue/jtable.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="css/select2.css"/>
<link rel="stylesheet" type="text/css" href="css/start/jquery-ui-1.10.3.custom.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablestyle.css"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#btn").button();	
});

</script>
<!-- -----------------------Sidemenu Section--------------------- -->

<div style="margin-top: 100px;">

<div style="display:block;margin-left:10px; float: left; height: 900px; margin-right: 20px;">
<jsp:include page="sidemenu.jsp" />
</div>
<%String msg; if(request.getAttribute("msg")!=null){msg=request.getAttribute("msg").toString();} else{msg="";}%>

<div id="content" style="display: block; float:right; width:40%; margin-right: 20%; margin-left:2%; margin-bottom:2%">
<form action="<%=request.getContextPath()%>/AdminPanelServlet">
<fieldset>
<legend style="text-align: center;">Reset User's Password</legend>
<br>
<p style="font-size: 14px; color: blue;"><%=msg %></p>
<input type="hidden" name="action" value="resetpwd">
<table id="formtable">

<tr><td style="padding: 5px;"> User Sip Uri: </td><td><input type="text"class="text-field" name="sipUri"></td></tr>
<tr><td></td><td><input type="submit" id="btn" value="Reset Password"></td></tr>


</table>
</fieldset>
</form>
</div>



</div>