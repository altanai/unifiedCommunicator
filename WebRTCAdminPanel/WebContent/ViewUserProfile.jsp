<!-- -----------------------Header Section--------------------- -->

<%@page import="com.tcs.webrtc.adminpanel.bean.UserBean"%>
<%@include file="headder.jsp" %>
<script src="<%=request.getContextPath()%>/scripts/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="<%=request.getContextPath()%>/scripts/select2.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.msgBox.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.fancybox.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.fancybox.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/msgBoxLight.css" >
<link rel="stylesheet" type="text/css" href="css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/select2.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/start/jquery-ui-1.10.3.custom.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablestyle.css"/>
<%UserBean userBean=(UserBean)request.getAttribute("userBean"); %>
<script>
$(document).ready(function(){
	$( "#backButton").button();
	$("#backButton").click(function(){
		document.location.href='ViewAllUsers.jsp?req=view';	
	});
});
</script>




<title>Edit User Friend-list</title>

<!-- -----------------------Sidemenu Section--------------------- -->

<div style="margin-top: 100px;">

<div style="display:block;margin-left:10px; float: left; height: 900px; margin-right: 20px;">
<jsp:include page="sidemenu.jsp" />
</div>

<!-- -----------------------Content Section--------------------- -->


<div id="content" style="display: block; float:right; width:40%; margin-right: 20%; margin-left:2%; margin-bottom:2%">
<div id="test-form" align="center" style="display: block; width:100%; float:right; margin-right: 20%;margin-bottom:2%">
<fieldset>
<legend>User Profile</legend>
<table id="formtable">
<tr><td colspan="2"><br></td></tr>
<tr>
<td>Sip-URI:</td><td><input type="text" id="userSipUri" class="text-field" disabled="disabled" value="<%=userBean.getPrivateIdentity() %>" name="userSipUri" ></td>
</tr>
<tr>
<td>Display Name:</td><td><input type="text" class="text-field" name="userdisplayName" id="userDisplayName" value="<%=userBean.getDisplayName()%>" disabled="disabled"></td>
</tr>
<tr>
<td>Public-URI:</td><td><input type="text" class="text-field" name="userpublicUri" id="userPublicUri" value="<%=userBean.getPublicIdentity()%>" disabled="disabled">
</tr>
<tr>
<td>WS-URI:</td><td><input type="text" class="text-field" name="userWsUri" id="userWsUri" value="<%=userBean.getWsUri()%>" disabled="disabled"></td>
</tr>
<tr>
<td>Realm:</td><td><input type="text" class="text-field" id="userRealm" name="realm" value="<%=userBean.getRealm()%>" disabled="disabled"></td>
</tr>
<tr><td style="vertical-align: center">Profile Pic:</td><td><img src="<%=request.getContextPath() %>/AdminPanelServlet?id=<%=userBean.getPrivateIdentity()%>&action=getProfilePic" style="width:100px;height: 80px;"></td>
</tr>
<tr><td><button id="backButton" style="width: 90px">Back</button></td><td></td>
</tr>
<tr><td></td><td></td>
</tr>
<tr><td></td><td></td>
</tr>
</table>
</fieldset>
</div>
</div>
</div>

