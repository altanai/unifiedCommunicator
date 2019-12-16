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
<script>
$(document).ready(function(){
	$( "#createButton").button();
	$( "#resetButton").button();
	
	$("#userDisplayName").blur(function(){
		var input=$("#userDisplayName").val();
		if(input==null||input==""){
			$("#tr1").css("display","");	
			$("#1").html("This field cannot be left blank");
			$("#userDisplayName").css("outline-style","solid");	
			$("#userDisplayName").css("outline-color","red");
			$("#userDisplayName").css("outline-width","thin");
			
		}
		else
			{
			$("#tr1").css("display","none");	
			$("#1").html("");
			$("#userDisplayName").css("outline-style","");	
			$("#userDisplayName").css("outline-color","");
			$("#userDisplayName").css("outline-width","");
			
			}
	});
	
	$("#userPublicUri").blur(function(){
		var input=$("#userPublicUri").val();
		if(input==null||input==""){
			$("#tr2").css("display","");	
			$("#2").html("This field cannot be left blank");
			$("#userPublicUri").css("outline-style","solid");	
			$("#userPublicUri").css("outline-color","red");
			$("#userPublicUri").css("outline-width","thin");	
			
		}
		else
			{
			$("#tr2").css("display","none");	
			$("#2").html("");
			$("#userPublicUri").css("outline-style","");	
			$("#userPublicUri").css("outline-color","");
			$("#userPublicUri").css("outline-width","");
			
			}
	});
	
	$("#userSipUri").blur(function(){
		var input=$("#userSipUri").val();
		if(input==null||input==""){
			$("#tr3").css("display","");	
			$("#3").html("This field cannot be left blank");
			$("#userSipUri").css("outline-style","solid");	
			$("#userSipUri").css("outline-color","red");
			$("#userSipUri").css("outline-width","thin");	
		}
		else
			{
			$("#tr3").css("display","none");	
			$("#3").html("");
			$("#userSipUri").css("outline-style","");	
			$("#userSipUri").css("outline-color","");
			$("#userSipUri").css("outline-width","");
			}
	});
	
	$("#userRealm").blur(function(){
		var input=$("#userRealm").val();
		if(input==null||input==""){
			$("#tr5").css("display","");	
			$("#5").html("This field cannot be left blank");
			$("#userRealm").css("outline-style","solid");	
			$("#userRealm").css("outline-color","red");
			$("#userRealm").css("outline-width","thin");		
		}
		else
			{
			$("#tr5").css("display","none");	
			$("#5").html("");
			$("#userRealm").css("outline-style","");	
			$("#userRealm").css("outline-color","");
			$("#userRealm").css("outline-width","");
			}
	});
	
	$("#userWsUri").blur(function(){
		var input=$("#userWsUri").val();
		if(input==null||input==""){
			$("#tr4").css("display","");	
			$("#4").html("This field cannot be left blank");
			$("#userWsUri").css("outline-style","solid");	
			$("#userWsUri").css("outline-color","red");
			$("#userWsUri").css("outline-width","thin");		
		}
		else
			{
			$("#tr4").css("display","none");	
			$("#4").html("");
			$("#userWsUri").css("outline-style","");	
			$("#userWsUri").css("outline-color","");
			$("#userWsUri").css("outline-width","");
			}
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
<form id="createUserProfile" method="post" action="<%=request.getContextPath()%>/CreateUserServlet1" enctype="multipart/form-data" onsubmit="return validate();">
<fieldset>
<legend>Create User Profile</legend>

<table id="formtable">
<tr><td colspan="3"><br></td></tr>
<tr>
<td>Display Name:</td><td><input type="text" class="text-field" name="userdisplayName" id="userDisplayName" value=""></td><td></td>
</tr>
<tr id="tr1" style="display: none;">
<td style="height: 12px;"></td><td style=" height: 12px;"><span id="1" style="color: red;font-size: 12px"></span></td><td style=" height: 12px;"></td></tr>
<tr>
<td>Public-URI:</td><td><input type="text" class="text-field" name="userpublicUri" id="userPublicUri" value=""></td><td></td>
</tr>
<tr id="tr2" style="display: none;">
<td style=" height: 12px;"></td><td style=" height: 12px;"><span id="2" style="color: red;font-size: 12px"></span></td><td style=" height: 12px;"></td></tr>
<tr>
<tr>
<td>Sip-URI:</td><td><input type="text" id="userSipUri" class="text-field"  name="userSipUri"></td><td></td>
</tr>
<tr id="tr3" style="display: none;">
<td style=" height: 12px;"></td><td style=" height: 12px;"><span id="3" style="color: red;font-size: 12px"></span></td><td style=" height: 12px;"></td></tr>
<tr>
<tr>
<td>WS-URI:</td><td><input type="text" class="text-field" name="userWsUri" id="userWsUri" value=""></td><td></td>
</tr>
<tr id="tr4" style="display: none;">
<td style=" height: 12px;"></td><td style=" height: 12px;"><span id="4" style="color: red;font-size: 12px"></span></td><td style=" height: 12px;"></td></tr>
<tr>
<tr>
<td>Realm:</td><td><input type="text" class="text-field" id="userRealm" name="userRealm" value=""></td><td></td>
</tr>
<tr id="tr5" style="display: none;">
<td style=" height: 12px;"></td><td style=" height: 12px;"><span id="5" style="color: red;font-size: 12px"></span></td><td style=" height: 12px;"></td></tr>
<tr>
<tr>
<td>Profile-Pic:</td><td><input type="file" name="userPic" id="userPic"></td><td></td>
<tr><td></td><td><br></td><td></td>
</tr>
<tr><td><button id="createButton" style="width: 90px">Create</button></td><td><input type="reset" id="resetButton" style="width: 90px"></td><td></td>
</tr>
<tr><td></td><td></td>
</tr>
<tr><td></td><td></td>
</tr>
</table>
<input type="hidden" name="action" value="createUserProfile">
</fieldset>
</form>
</div>
</div>
</div>

