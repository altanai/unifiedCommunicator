<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%session.setAttribute("privateIdentity",request.getParameter("id") ); %>

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="scripts/jquery.jtable.js"></script>
<script src="scripts/select2.js"></script>
<link rel="stylesheet" type="text/css" href="themes/metro/blue/jtable.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="css/select2.css"/>
<link rel="stylesheet" type="text/css" href="css/start/jquery-ui-1.10.3.custom.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
function updateStatus(data){
	 $.ajax({
			type:"POST",
			url:"VoiceMailServlet",
			data:{action:'updateReadStatus',mailId:data.id},
			success:function(data){
			}
	 });
}
</script>
<script>
$(document).ready(function () { 
	
	
	$('#TableContainer').jtable({
		actions: { 
			listAction: '<%=request.getContextPath()%>/VoiceMailServlet?action=getVoiceMails',
			deleteAction: '<%=request.getContextPath()%>/VoiceMailServlet?action=deleteVoiceMail&delFrom='+$( "input:radio[name=mailBox]:checked" ).val()+''			
		},
			title:'VOICE-MAILS',
			paging: true,
			pageSize:5,
	        sorting: true,
	        defaultSorting:'MAILTIME ASC',
	        columnSelectable: false,
	        defaultDateFormat: 'dd-M-yy',
	        openChildAsAccordion: true,
	        saveUserPreferences: false,
	        fields: { 
	        	FROMUSER: { 
					title: 'FROM-USER',
					width: '22%'
				}, 
				TOUSER: { 
					key:true,
					title: 'TO-USER',
					width: '22%',
				},
				MAILTIME:
				{
					title :'TIME',
					width:'21%'
				},
				VOICEMAIL: {
					width:'34%',
				    title: 'VOICE-MAIL',
				    sorting:false,
					display: function (data) {
						 var temp=$("#from").val();
				   		 temp=temp.replace(".","_");
				   		 temp=temp.replace(":","_");
				   		temp=temp.replace("@","_");
				    	var newData1="VoiceMails/"+temp+"/"+data.record.MAILID+".wav";
				    	var $link = $('<audio controls  id="'+newData1+'" onclick="updateStatus(this);"><source src="'+newData1+'" type="audio/mp3" ></audio> ');
				        return $link; 
				    }
				},
				MAILID:{
					key:true,
                    type: 'hidden',
				}
		}
	});
	
	$('#TableContainer').jtable('load',{
		searchIn:$( "input:radio[name=mailBox]:checked" ).val(),
		searchBy:'UNREAD',
		});
	$("#tableForOutbox").css("display","none");
	
	$( "#FilterRecords").button();
	$( "#ClearFilter").button();
	$("#columnName").select2();
	$( "#FilterRecords1").button();
	$( "#ClearFilter1").button();
	$("#columnName1").select2();
	
	$( "#datePicker").datepicker({
		dateFormat: "yy-mm-dd", 
		inline: true
	});
	

	$('#FilterRecords').click(function (e) {
	    e.preventDefault();
	    $('#TableContainer').jtable('load',{
			searchIn:$( "input:radio[name=mailBox]:checked" ).val(),
			searchBy:$("#columnName").val(),
			});
	    $("#columnName").select2();
	});

	$('#ClearFilter').click(function (e) {
		e.preventDefault();
		$('#columnName').val('');
		$('#datePicker').val('');
		$('#datePicker').css('display','none');
		$('#filterValue').css('display','none');
		$('#TableContainer').jtable('load',{
			searchIn:$( "input:radio[name=mailBox]:checked" ).val(),
			searchBy:'UNREAD',
			});
		$("#columnName").select2();
	});
	
	
	$('#FilterRecords1').click(function (e) {
		var isEmpty=false;
	    e.preventDefault();
	    if($("#columnName1").val().match("DATE")&&$("#datePicker").val()=="") 
	    	{
	    	isEmpty=true;
	    	$("#datePicker").focus();
	    	}
	    if(!isEmpty)
	    	{
	    	$('#TableContainer').jtable('load',{
				searchIn:$( "input:radio[name=mailBox]:checked" ).val(),
				searchBy:$('#columnName1').val(),
				field:$("#datePicker").val()
				});
	    	}
	    $("#columnName").select2();
	});

	$('#ClearFilter1').click(function (e) {
		e.preventDefault();
		$('#columnName1').val('');
		$('#datePicker').val('');
		$('#datePicker').css('display','none');
		$('#filterValue').css('display','none');
		$('#TableContainer').jtable('load',{
			searchIn:$( "input:radio[name=mailBox]:checked" ).val(),
			searchBy:'ALL',
			});
		$("#columnName1").select2();
	});
	
	$("#outbox").change(function(){
		$("#tableForInbox").css("display","none");
		$("#tableForOutbox").css("display","");
		$('#TableContainer').jtable('load',{
			searchIn:$( "input:radio[name=mailBox]:checked" ).val(),
			searchBy:'ALL',
			});
	});

	$("#inbox").change(function(){
		$("#tableForOutbox").css("display","none");
		$("#tableForInbox").css("display","");
		$('#TableContainer').jtable('load',{
			searchIn:$( "input:radio[name=mailBox]:checked" ).val(),
			searchBy:'UNREAD',
			});
	});
	$("#columnName1").change(function(){
		if($("#columnName1").val().match("ALL")){
			$( "#datePicker").css("display","none");
			$("#datePicker").val('');	
		}
			else if($("#columnName1").val().match("DATE")){
			$( "#datePicker").css("display","");}
			else if($("#columnName1").val().match("Select")){
				$( "#datePicker").css("display","none");
				$("#datePicker").val('');	}
	});
	
	
});
</script>
<title>Insert title here</title>
</head>
<body>
<div id="filterRecords" style="display: block; margin-left: 20%;margin-top:2%;margin-bottom:2%" >
<table>
<tr>
<td><label style=" font-size: 20px;font-style: normal;margin-right: 5px;">Search In:</label></td>
<td width="100px"><input type="radio" checked="checked" name="mailBox" id="inbox" value="INBOX">INBOX</td>
<td width="100px"><input type="radio" name="mailBox" id="outbox" value="SENTBOX">SENTBOX</td>
<td></td>
</tr>
</table>
<table style="margin-top: 10px" id="tableForInbox">
<tr><td>
<label style=" font-size: 20px;font-style: normal;margin-right: 5px;">Filter By:</label></td>
<td><select id="columnName" style="width: 130px;margin-right: 1%">
<option value="Select">-Select-</option>
<option value="READ">READ</option>
<option value="UNREAD">UNREAD</option>
<option value="ALL">ALL</option>
</select></td>
<td><button id="FilterRecords" style="width: 80px;height: 30px">FILTER</button></td>
<td><button id="ClearFilter" style="width: 80px;height: 30px">CLEAR</button></td>
</tr>
</table>
<table style="margin-top: 10px" id="tableForOutbox">
<tr><td>
<label style=" font-size: 20px;font-style: normal;margin-right: 5px;">Filter By:</label></td>
<td><input type="text" id="datePicker" style="width: 100px; height:24px;display: none;outline-color: highlight;" maxlength="20"/></td>
<td><select id="columnName1" style="width: 130px;margin-right: 1%">
<option value="Select">-Select-</option>
<option value="ALL">ALL</option>
<option value="DATE">DATE</option>
</select></td>
<td><button id="FilterRecords1" style="width: 80px;height: 30px">FILTER</button></td>
<td><button id="ClearFilter1" style="width: 80px;height: 30px">CLEAR</button></td>
</tr>
</table>
</div>	
<input type="hidden" id="from" name="from" value="<%=session.getAttribute("privateIdentity").toString() %>">
<div id="TableContainer" style="width: 65%; display: block; margin-left: 20%; text-shadow: none;"></div>		    
				
</body>
</html>