<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%session = request.getSession();
session.setAttribute("privateIdentity", "sip:alice@tcs.com");
String currentUser=(String)session.getAttribute("privateIdentity");
if(currentUser==null||currentUser.length()==0)
{
	currentUser="";
}
%>
<script src="<%=request.getContextPath()%>/scripts/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="<%=request.getContextPath()%>/scripts/select2.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.msgBox.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/msgBoxLight.css" >
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/select2.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/textstyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/start/jquery-ui-1.10.3.custom.css"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Screening</title>
<script>
$(document).ready(function(){
	
	$("#performAction").select2();
	$("#sun1").select2();
	$("#mon1").select2();
	$("#tue1").select2();
	$("#wed1").select2();
	$("#thu1").select2();
	$("#fri1").select2();
	$("#sat1").select2();
	$("#sun2").select2();
	$("#mon2").select2();
	$("#tue2").select2();
	$("#wed2").select2();
	$("#thu2").select2();
	$("#fri2").select2();
	$("#sat2").select2();

	$("#performAction").change(function(){
		
		var itemSelected=$("#performAction").val();
		if("Select".match(itemSelected))
		{
			$("#addBlackUsers").css("display","none");
			$("#addWhiteUsers").css("display","none");
			$("#addDNDValues").css("display","none");
			$("#viewBlackUsers").css("display","none");
		}
		else if("BlackUsers".match(itemSelected))
			{
				$("#addBlackUsers").css("display", "");
				$("#addWhiteUsers").css("display", "none");
				$("#addDNDValues").css("display", "none");
				$("#viewBlackUsers").css("display", "none");
			} 
		else if ("WhiteUsers".match(itemSelected)) 
			{
				$("#addBlackUsers").css("display", "none");
				$("#addWhiteUsers").css("display", "");
				$("#addDNDValues").css("display", "none");
				$("#viewBlackUsers").css("display", "none");
			}
		else if ("DNDValues".match(itemSelected)) 
			{
				$("#addBlackUsers").css("display", "none");
				$("#addWhiteUsers").css("display", "none");
				$("#addDNDValues").css("display", "");
				$("#viewBlackUsers").css("display", "none");
			}
		});
	
	$("#whiteUser").blur(function(){
			var input=$("#whiteUser").val();
			if(input==null||input==""){
				$("#2").html("This field cannot be left blank");
				$("#whiteUser").focus();				
			}
			else
				{
				$("#2").html("");
				}
	});
	
	$("#blackUser").blur(function(){
		var input=$("#blackUser").val();
		if(input==null||input==""){
			$("#1").html("This field cannot be left blank");
			$("#blackUser").focus();				
		}
		else
		{
		$("#1").html("");
		}
	});
	
	$( "#whitelist").button();
	$( "#whitelist").click(function(){
		var sipUri=$("#whiteUser").val();
		if(sipUri==null||sipUri=="")
			{
			$("#2").html("This field cannot be left blank");
			}
		else{
		$.msgBox({
            title: "Are You Sure",
            content: "You want to add "+sipUri+" as a WhiteUser?",
            type: "confirm",
            buttons: [{ value: "Yes" }, { value: "No" }, { value: "Cancel"}],
            success: function (result) {
            	if(result=="Yes"){
					$.ajax({
							type:"POST",
							url:"ScreenCallersServlet",
							data:{action:'addWhiteUser',sip_uri:sipUri},
							success:function(data){
							$.msgBox({
								title:"Response from Server",
								content:sipUri+" "+data,
								type:"info"
							});
							$("#whiteUser").val('');
							}
							});
            			}
           		 	}
				});
			}

	});
	
	$( "#blacklist").button();
	$( "#blacklist").click(function(){
		var sipUri=$("#blackUser").val();
		if(sipUri==null||sipUri=="")
			{
			$("#1").html("This field cannot be left blank");
			}
		else{
		$.msgBox({
            title: "Are You Sure",
            content: "You want to add "+sipUri+" to BlackList?",
            type: "confirm",
            buttons: [{ value: "Yes" }, { value: "No" }, { value: "Cancel"}],
            success: function (result) {
            	if(result=="Yes"){
				$.ajax({
						type:"POST",
						url:"ScreenCallersServlet",
						data:{action:'addBlackUser',sip_uri:sipUri},
						success:function(data){
						$.msgBox({
							title:"Response from Server",
							content: sipUri+" "+data,
							type:"info",
						});	
						$("#blackUser").val('');
						}
						});
            			}
           			}
			 });
			}
		});
	
	
	$( "#dndValues").button();
	
	$( "#dndValues").click(function(){
		var sipUri=$("#blackUser").val();
		$.msgBox({
            title: "Are You Sure",
            content: "Would you like to save these timings as Do Not Disturb?Any Previous settings shall be overwritten.",
            type: "confirm",
            buttons: [{ value: "Yes" }, { value: "No" }, { value: "Cancel"}],
            success: function (result) {
                if (result == "Yes") {
                   $.ajax({
                	  type:"POST",
                	  url:"ScreenCallersServlet",
                	  data:{action:"setDND",sip_uri:sipUri,start_1:$("#mon1").val(),start_2:$("#tue1").val(),start_4:$("#wed1").val(),start_8:$("#thu1").val(),
                		  	start_16:$("#fri1").val(),start_32:$("#sat1").val(),start_64:$("#sun1").val(),stop_1:$("#mon2").val(),stop_2:$("#tue2").val(),stop_4:$("#wed2").val(),stop_8:$("#thu2").val(),
                		  	stop_16:$("#fri2").val(),stop_32:$("#sat2").val(),stop_64:$("#sun2").val()},
                	  success:function(data){
                		  $.msgBox({
                			  title:"Response from Server",
                			  content:data,
                			  type:"info",
                		  });
                	  }
                   });
                }
            }
        });
	});
	
	$("#whiteUser").autocomplete({
		serviceUrl:'ScreenCallersServlet'
	});
	
	$("#blackUser").autocomplete({
		serviceUrl:'ScreenCallersServlet'
	});
});
</script>

</head>
<body>

<div id="action" style="padding-left: 200px;padding-top: 100px">
<label style="font-size: 24px;font-style: normal;font-weight: bold;margin-right: 10px">Action:</label>
<select id="performAction" style="width: 180px">
<option>Select</option>
<option value="BlackUsers">Add Black Users</option>
<option value="WhiteUsers">Add White Users</option>
<option value="DNDValues">Add Do Not Disturb</option>
</select>
</div>

<div id="addBlackUsers" style="padding-left: 200px;padding-top: 20px">
<h2>Add Black Users</h2>
<table><tr><td>
<label style="font-size: 20px;font-style: normal;margin-right: 10px">Current User:</label></td>
<td><input type="text" class="text-field" value="<%=currentUser%>" disabled="disabled"></td><td></td>
<tr><td colspan="3"><br/></td></tr>
<tr><td>
<label style="font-size: 20px;font-style: normal;margin-right: 10px">Black User:</label></td>
<td><input type="text" class="text-field" id="blackUser" name="blackUser"></td><td><span id="1" style="color: red"></span></td></tr>
<tr><td colspan="3"><br/></td></tr>
<tr><td></td><td><input type="submit" id="blacklist" value="Submit"></td></tr>
</table>
</div>


<div id="addWhiteUsers" style="padding-left: 200px;padding-top: 20px">
<h2>Add White Users</h2>
<table><tr><td>
<label style="font-size: 20px;font-style: normal;margin-right: 10px">Current User:</label></td>
<td><input type="text" class="text-field" value="<%=currentUser%>" disabled="disabled"></td><td></td>
<tr><td colspan="3"><br/></td></tr>
<tr><td>
<label style="font-size: 20px;font-style: normal;margin-right: 10px">White User:</label></td>
<td><input type="text" class="text-field" id="whiteUser" name="whiteUser"></td><td><span id="2" style="color: red"></span></td></tr>
<tr><td colspan="3"><br/></td></tr>
<tr><td></td><td><input type="submit" id="whitelist" value="Submit"></td></tr>
</table>
</div>


<div id="addDNDValues" style="padding-left: 200px;padding-top: 20px">
<h2>Do Not Disturb</h2>
<table width="60%">
<tr>
<td align="left" width="20%" style="font-size: 20px;font-weight: bold;">Day</td>
<td align="left" width="20%" style="font-size: 20px;font-weight: bold;">Start-Time</td>
<td align="left" width="20%" style="font-size: 20px;font-weight: bold;">End-Time</td>
</tr>

<tr style="height: 50x">
<td width="20%">MONDAY</td>
<td align="left" width="20%"><select class=span10 name="start_1" id="mon1" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
<td align="left" width="20%"><select class=span10 name="stop_1" id="mon2" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
</tr>

<tr>
<td width="20%">TUESDAY</td>
<td align="left" width="20%"><select class=span10 name="start_2" id="tue1" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
<td align="left" width="20%"><select class=span10 name="stop_2" id="tue2" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
</tr>

<tr>
<td width="20%">WEDNESDAY</td>
<td align="left" width="20%"><select class=span10 name="start_4" id="wed1" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
<td align="left" width="20%"><select class=span10 name="stop_4" id="wed2" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
</tr>

<tr>
<td width="20%">THURSDAY</td>
<td align="left" width="20%"><select class=span10 name="start_8" id="thu1" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
<td align="left" width="20%"><select class=span10 name="stop_8" id="thu2" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
</tr>

<tr height="15px">
<td width="20%">FRIDAY</td>
<td align="left" width="20%"><select class=span10 name="start_16" id="fri1" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
<td align="left" width="20%"><select class=span10 name="stop_16" id="fri2" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
</tr>

<tr>
<td width="20%">SATURDAY</td>
<td align="left" width="20%"><select class=span10 name="start_32" id="sat1" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
<td align="left" width="20%"><select class=span10 name="stop_32" id="sat2" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
</tr>

<tr>
<td width="20%">SUNDAY</td>
<td align="left" width="20%"><select class=span10 name="start_64" id="sun1" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
<td align="left" width="20%"><select class=span10 name="stop_64" id="sun2" style="width: 160px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td>
</tr>
<tr><td colspan="3"><br/></td></tr>
<tr><td><input type="submit" id="dndValues" value="Submit"></td><td colspan="2"></td></tr>
</table>
</div>
</body>
</html>
