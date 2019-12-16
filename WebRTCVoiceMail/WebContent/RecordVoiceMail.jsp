<%@page import="java.util.ArrayList"%>
<%@page import="com.tcs.webrtc.voicemail.bean.FriendBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%session.setAttribute("privateIdentity",request.getParameter("id") ); %>

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="css/start/jquery-ui-1.10.3.custom.css"/>
<link rel="stylesheet" type="text/css" href="css/Custom.css"/>
<link rel="stylesheet" type="text/css" href="css/progress.css"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#start-record").button();
	$("#stop-record").button();
	$("#play").button();
	$("#saveVideo").button();
	$("#discardAudio").button();
	$("#selectFrnd").button();
	
	$("#play").click(function(e){
   		e.preventDefault();
   		window.open($("#instantPlayback").val(),"_blank");
	});
		
		$("#saveVideo").click(function(e){
				$("#upload1").css("display","");
		   		 e.preventDefault();
		   		 var temp=$("#from").val()+"to";
		   		 temp=temp.replace(".","_");
		   		 temp=temp.replace(":","_");
		   		 temp=temp.replace("@","_");
		   		 var temp1=$("#to").val();
		   		 temp1=temp1.replace(".","_");
	   			 temp1=temp1.replace(":","_");
	   			 temp1=temp1.replace("@","_");
	   			 var file=temp+temp1+".wav";
	   		 	 $.ajax({
					type:"POST",
					url:"VoiceMailServlet",
					data:{action:'saveVoiceMail',fileName:file,from:$("#from").val(),to:$("#to").val()},
					success:function(data){
						$("#upload1").css("display","none");
						alert(data);
					}
	   		 });
		
   		});
		$("#discardAudio").click(function(e){
   		 e.preventDefault();
   		 var file=$("#from").val()+"to"+$("#to").val()+".wav";
   		 alert(file);
   		 $.ajax({
				type:"POST",
				url:"VoiceMailServlet",
				data:{action:'discardVoiceMail',fileName:file,from:$("#from").val(),to:$("#to").val()},
				success:function(data){
					alert(data);
					$("#saveVideo").css("display","none");
					$("#play").css("display","none");
					$("#discardAudio").css("display","none");
				}
   		 });
   	});
		$("#selectFrnd").click(function(){
			var value=$("input:radio[name=radiobutton]:checked").val();
		$("#to1").val(value);
		$("#to").val(value);
		});
		
		$("#to1").blur(function(){
			$("#to").val($("#to1").val());
		});
		
	
});
</script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>RecordRTC-together Demo</title>
<meta name="description" content="RecordRTC-together Demo">
<meta name="viewport" content="width=device-width">
<title>Record Voice Mail</title>
</head>

<body>

<div id="videoRecording">
<%-- <a href="<%=request.getContextPath() %>/VoiceMailServlet?action=getListOfVoiceMails" >View Voice-Mails</a> --%>
<fieldset style="float: left;">
<legend>Record Voice-Mail</legend>
<table id="voiceMailTable" align="center">
<tr><td><br></td><td></td></tr>
<tr>

	<td><label style="align:right;">Recipient:</label></td>
	<td><input type="text" id="to1" placeholder="Select a friend from list" class="text-field"></td>
	
</tr>

<tr><td><br></td><td></td></tr>
<tr>
	<td align="center" colspan="3"><audio controls id="client-audio" ></audio></td>
	
</tr>
<tr><td align="center" style="width: 300px" colspan="3"><button id="start-record">Start Recording</button><button id="stop-record" style="display: none;">Stop Recording</button></td>
</tr>
<tr>
	<td align="center" style="width: 150px;"><button id="play" style="display: none;">Play Mail</button></td>
	<td align="center" style="width: 150px"><button id="discardAudio" style="display: none;">Discard Mail</button></td>
	<td align="center" style="width: 150px"><button id="saveVideo" style="display: none;">Send Mail</button></td>
</tr>
<tr><td colspan="3"><br></td></tr>
<tr>
<td colspan="3" align="center">
<div class="container" id="recording" style="display: none">
	<div class="contentBar">
    	<div id="block_1" class="barlittle"></div>
        <div id="block_2" class="barlittle"></div>
        <div id="block_3" class="barlittle"></div>
        <div id="block_4" class="barlittle"></div>
        <div id="block_5" class="barlittle"></div>
    </div>
</div>
<div id="upload" style="display: none">
<div style="margin-bottom: 5px; padding-left: 10px;">PROCESSING...</div>
<div class="circle" ></div>
<div class="circle1"></div>
</div>
<div id="upload1" style="display: none">
<div style="margin-bottom: 5px; padding-left: 10px;">SENDING MAIL</div>
<div class="circle" ></div>
<div class="circle1"></div>
</div>

</td>

</tr>
</table>
</fieldset>
<%FriendBean friendBean= new FriendBean();
	friendBean=(FriendBean)request.getAttribute("friendList");
	ArrayList<String> friendList= friendBean.getFriendList();%>
	
	
	
<fieldset style="width: 20%; height:100%; float: right; margin-right: 10%; margin-top: 0%;">
<legend>Friend List</legend>
<button id="selectFrnd">Select Recipient</button>
<div style="overflow:auto; max-height: 300px;">
<table align="left">
<%for(String currentFriend:friendList){ %>
<tr>
<td align="left"><input type="radio" id="radiobutton" name="radiobutton" value="<%=currentFriend%>"><%=currentFriend%></td>
</tr>
<%} %>

</table>
</div>
</fieldset>
</div>
<input type="hidden" id="from" name="from" value="<%=session.getAttribute("privateIdentity").toString() %>">
<input type="hidden" id="to" name="to">
<input type="hidden" id="data"><script src="scripts/whammy.js"></script>
<input type="hidden" id="instantPlayback">
<script src="scripts/StereoRecorder.js"></script>
<script src="scripts/record-rtc.js"></script>
<script src="scripts/main.js"></script>
	
</body>
</html>