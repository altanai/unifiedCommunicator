<%@page import="com.tcs.webrtc.adminpanel.bean.UserBean"%>
<%@include file="headder.jsp" %>

<script src="<%=request.getContextPath()%>/scripts/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="<%=request.getContextPath()%>/scripts/select2.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.msgBox.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.fancybox.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.fancybox.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/msgBoxLight.css" >
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/select2.css"/>
<link rel="stylesheet" type="text/css" href="css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/start/jquery-ui-1.10.3.custom.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablestyle.css"/>
<title>Edit User Friend-list</title>
<%UserBean userBean=(UserBean)request.getAttribute("userBean"); %>
<script type="text/javascript">
$(document).ready(function(){
	
	$( "#editProfile").button();
	$( "#editProfile1").button();
	$( "#backButton").button();
	$( "#editProfile").click(function(){
		var displayName=$("#userDisplayName").val();
		var publicIdentity=$("#userPublicUri").val();
		var privateIdentity=$("#userSipUri").val();
		var WsUri=$("#userWsUri").val();
		var Realm=$("#userRealm").val();
		if(displayName==null||displayName=="")
			{
			$("#1").html("Field cannot be left blank.");
			$("#userDisplayName").focus();
			}
		else if(publicIdentity==null||publicIdentity=="")
			{
			$("#2").html("Field cannot be left blank.");
			$("#userPublicUri").focus();
			}
		else if(WsUri==null||WsUri=="")
			{
			$("#3").html("Field cannot be left blank.");
			$("#userWsUri").focus();
			}
		else if(Realm==null||Realm=="")
			{
			$("#4").html("Field cannot be left blank.");
			$("#userRealm").focus();
			}
		else{
		$.msgBox({
        title: "Are You Sure",
        content: "You want to update the details?",
        type: "confirm",
        buttons: [{ value: "Yes" }, { value: "No" }, { value: "Cancel"}],
        success: function (result) {
        	if(result=="Yes"){
        		$.ajax({
					type:"POST",
					url:"AdminPanelServlet",
					data:{action:'editUser',userDisplayName:displayName,userSipUri:privateIdentity,userPublicIdentity:publicIdentity,userWsUri:WsUri,realm:Realm},
					success:function(data){
					$.msgBox({
						title:"Response from Server",
						content:data+"!",
						type:"info"
					});
					if(data.match("User Data updated successfully"))
						{
						$("#backButton").css("display","");
						$( "#editProfile").css("display","none");
						$( "#editProfile1").css("display","none");
						}
					}
					});
    	    	}
        	}
        });	
		}
	});
	$("#editProfile1").click(function(){
		document.location.href='ViewAllUsers.jsp?req=edit';	
	});
	$("#backButton").click(function(){
		document.location.href='ViewAllUsers.jsp?req=edit';	
	});
	
	$("#userDisplayName").blur(function(){
		var input=$("#userDisplayName").val();
		if(input==null||input==""){
			$("#1").html("This field cannot be left blank.");
			$("#userDisplayName").focus();				
		}
		else
		{
		$("#1").html("");
		}
	});
	$("#userPublicUri").blur(function(){
		var input=$("#userPublicUri").val();
		if(input==null||input==""){
			$("#2").html("This field cannot be left blank.");
			$("#userPublicUri").focus();				
		}
		else
		{
		$("#2").html("");
		}
	});
	$("#userWsUri").blur(function(){
		var input=$("#userWsUri").val();
		if(input==null||input==""){
			$("#3").html("This field cannot be left blank.");
			$("#userWsUri").focus();				
		}
		else
		{
		$("#3").html("");
		}
	});
	$("#userRealm").blur(function(){
		var input=$("#userRealm").val();
		if(input==null||input==""){
			$("#4").html("This field cannot be left blank.");
			$("#userRealm").focus();				
		}
		else
		{
		$("#4").html("");
		}
	});
      
});
</script>


<div style="margin-top: 100px;">

<div style="display:block;margin-left:10px;margin-right:20px; float: left; height: 900px;">
<jsp:include page="sidemenu.jsp" />
</div>

<div id="content" style="display: block; float:right; width:40%; margin-right: 20%; margin-left:2%; margin-bottom:2%">
<div id="test-form" align="center" style="display: block; width:100%; float:right; margin-right: 20%;margin-bottom:2%">
<fieldset>
<legend>Edit User Profile</legend>

<table id="formtable">
<tr><td colspan="3"><br></td></tr>
<tr>
<td>Sip-URI:</td><td><input type="text" id="userSipUri" class="text-field" disabled="disabled" value="<%=userBean.getPrivateIdentity() %>" name="userSipUri"></td><td></td>
</tr>
<tr>
<td>Display Name:</td><td><input type="text" class="text-field" name="userdisplayName" id="userDisplayName" value="<%=userBean.getDisplayName()%>"></td><td><span id="1" style="color: red;font-size: 12px"></span></td>
</tr>
<tr>
<td>Public-URI:</td><td><input type="text" class="text-field" name="userpublicUri" id="userPublicUri" value="<%=userBean.getPublicIdentity()%>"></td><td><span id="2" style="color: red;font-size: 12px"></span></td>
</tr>
<tr>
<td>WS-URI:</td><td><input type="text" class="text-field" name="userWsUri" id="userWsUri" value="<%=userBean.getWsUri()%>"></td><td><span id="3" style="color: red;font-size: 12px"></span></td>
</tr>
<tr>
<td>Realm:</td><td><input type="text" class="text-field" id="userRealm" name="realm" value="<%=userBean.getRealm()%>"></td><td><span id="4" style="color: red;font-size: 12px"></span></td>
</tr>
<tr><td></td><td><br></td><td></td>
</tr>
<tr><td><button id="editProfile" style="width: 90px">Update</button><button id="backButton" style="display: none;width: 90px">Back</button></td><td><button id="editProfile1" style="width:90px">Cancel</button></td><td></td>
</tr>
<tr><td></td><td></td>
</tr>
<tr><td></td><td></td>
</tr>
</table>
<input type="hidden" name="action" value="editUser">
</fieldset>
</div>
</div>
</div>

