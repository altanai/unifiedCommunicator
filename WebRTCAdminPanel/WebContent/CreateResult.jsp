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

<% String message=(String)request.getAttribute("msg");%>




<title>Edit User Friend-list</title>

<!-- -----------------------Sidemenu Section--------------------- -->

<div style="margin-top: 100px;">

<div style="display:block;margin-left:10px; float: left; height: 900px; margin-right: 20px;">
<jsp:include page="sidemenu.jsp" />
</div>

<!-- -----------------------Content Section--------------------- -->


<div id="content" style="float:right; margin-right: 400px">
<div id="test-form" align="center">

<fieldset >
<legend>Create User Profile</legend>
<%if("User added successfully".equalsIgnoreCase(message)){ %>
<img style="width: 50px; height: 50px;" src="Images/tick.jpg">
<h2 style="color: green"><%=message %></h2>
<a href="AdminHome.jsp">Return Home</a>
<%}else{ %>
<p><img src="Images/cross.jpg" style="width: 50px; height: 50px;">
<h2 style="color: red"><%=message %></h2></p>
<a href="AdminHome.jsp">Return Home</a>
<%} %>


</fieldset>

</div>
</div>
</div>

