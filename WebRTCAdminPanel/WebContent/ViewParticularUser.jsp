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
<script src="<%=request.getContextPath()%>/scripts/jquery.autocomplete.js"></script>

<script>
$(document).ready(function(){
	$( "#backButton").button();
	$( "#search").button();
	$( "#filterBy").select2();
	
	$("#backButton").click(function(e){
		e.preventDefault();
		location.reload();
	});
	
	$("#filterBy").change(function(){
		if($("#filterBy").val().match("userSipUri")){
		$( "#profile").css("display","");
		$( "#profile1").css("display","none");}
		else if($("#filterBy").val().match("userDisplayName")){
		$( "#profile").css("display","none");
		$( "#profile1").css("display","");}
		else if($("#filterBy").val().match("Select")){
			$( "#profile").css("display","none");
			$( "#profile1").css("display","none");}
	});
	
	$( "#search").click(function(){
		if($("#filterBy").val().match("Select"))
			{
				alert("Please select the type of filtering");
			}
		else if((!$("#filterBy").val().match("Select"))&& ($("#profile").val()=="")&& ($("#profile1").val()==""))
			{
				alert("Please enter some value to search by");
			}
		else if(($("#filterBy").val().match("userSipUri"))&& (!$("#profile").val()==""))
			{
				$.ajax({
					type:"POST",
					url:"AdminPanelServlet",
					data:{searchField:$("#filterBy").val(),action:'viewPaticularUser',searchVal:$("#profile").val()},
					success:function(data){
							$("#userData").css("display","");
							$("#userDisplayName").val(data.DISPLAYNAME);
							$("#userPublicUri").val(data.PUBLICIDENTITY);
							$("#userSipUri").val(data.PRIVATEIDENTITY);
							$("#userWsUri").val(data.WSURI);
							$("#userRealm").val(data.REALM);
							var value=$("#userSipUri").val();
							var src='<%=request.getContextPath() %>/AdminPanelServlet?id='+value+'&action=getProfilePic';
							$("#pic").attr("src",src);
							
							
					}
				});
			}
		else if(($("#filterBy").val().match("userDisplayName"))&& (!$("#profile1").val()==""))
		{
			$.ajax({
				type:"POST",
				url:"AdminPanelServlet",
				data:{searchField:$("#filterBy").val(),action:'viewPaticularUser',searchVal:$("#profile1").val()},
				success:function(data){
						$("#userData").css("display","");
						$("#userDisplayName").val(data.DISPLAYNAME);
						$("#userPublicUri").val(data.PUBLICIDENTITY);
						$("#userSipUri").val(data.PRIVATEIDENTITY);
						$("#userWsUri").val(data.WSURI);
						$("#userRealm").val(data.REALM);
						var value=$("#userSipUri").val();
						var src='<%=request.getContextPath() %>/AdminPanelServlet?id='+value+'&action=getProfilePic';
						$("#pic").attr("src",src);
						
				}
			});
		}
	});
	
	$("#profile").autocomplete({
		serviceUrl:'AdminPanelServlet?action=autoComplete&option=userSipUri'
	});
	$("#profile1").autocomplete({
		serviceUrl:'AdminPanelServlet?action=autoComplete&option=userDisplayName'
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


<div id="content" style="display: block; float:right; width:40%; margin-right: 20%; margin-left:2%; margin-bottom:2%" >
<div id="filterProfiles" style="margin-bottom: 10px">
<table><tr>
<td><label style=" font-size: 20px;font-style: normal;margin-right: 5px;">Search User:</label></td>
<td><input type="text" id="profile" style="width: 120px; height:26px;display: none;margin-right: 5px;outline-color: highlight;" maxlength="25"/>
<input type="text" id="profile1" style="width: 120px; height:26px;display: none;margin-right: 5px;outline-color: highlight;" maxlength="25"/>
</td>
<td><select id="filterBy"style="width: 130px;margin-right: 1%">
	<option value="Select"> Select</option>
	<option value="userSipUri">Sip-Uri</option>
	<option value="userDisplayName">Display-Name</option>
	</select>
</td>
<td><button id="search" style="width: 90px">Search</button></td>
</tr></table> 
</div>
<div id="userData" align="center" style="display: none">
<fieldset>
<!-- <legend>User Profile</legend> -->
<table id="formtable">
<tr><td colspan="2"><br></td></tr>
<tr>
<td>Sip-URI:</td><td><input type="text" id="userSipUri" class="text-field" disabled="disabled" value="" name="userSipUri"></td>
</tr>
<tr>
<td>Display Name:</td><td><input type="text" class="text-field" disabled="disabled" name="userdisplayName" id="userDisplayName" value=""></td>
</tr>
<tr>
<td>Public-URI:</td><td><input type="text" class="text-field" disabled="disabled" name="userpublicUri" id="userPublicUri" value="">
</tr>
<tr>
<td>WS-URI:</td><td><input type="text" class="text-field" disabled="disabled" name="userWsUri" id="userWsUri" value=""></td>
</tr>
<tr>
<td>Realm:</td><td><input type="text" class="text-field" disabled="disabled" id="userRealm" name="realm" value=""></td>
</tr>
<tr><td style="vertical-align: center">Profile Pic:</td><td><img id="pic" style="width:100px;height: 80px;"></td>
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

