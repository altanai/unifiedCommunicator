<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="<%=request.getContextPath()%>/scripts/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.jtable.js"></script>
<script src="<%=request.getContextPath()%>/scripts/select2.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/metro/blue/jtable.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/select2.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/start/jquery-ui-1.10.3.custom.css"/>

<title>WebRTC-View Call Logs</title>

<script type="text/javascript">
$(document).ready(function () { 
	$('#TableContainer').jtable({
	actions: { 
		listAction: '<%=request.getContextPath()%>/ViewCallLogsServlet/ViewAllLogs'
	},
		title:'CALL-LOGS',
		paging: true,
		pageSize:5,
        sorting: true,
        defaultSorting:'CALLER ASC',
        columnSelectable: false,
        defaultDateFormat: 'dd-M-yy',
        openChildAsAccordion: true,
        saveUserPreferences: false,
        fields: { 
        	CALLER: { 
				title: 'CALLER',
				width: '20%'
			}, 
			CALLEE: { 
				title: 'CALLEE',
				width: '20%',
			},
			DAY:
			{
			sorting:false,
			title :'DAY',
			width:'20%'
			},
		STARTTIME:
		{
			title:'Start-Time',
			width:'20%'
		},
		ENDTIME:
		{
		title:'End-Time',
		width:'20%'
		}
	}
});
	
$('#TableContainer').jtable('load');
$("#columnName").select2();
$( "#datePicker").datepicker({
	dateFormat: "d/mm/yy", 
	inline: true
});
$( document ).tooltip();
$( "#FilterRecords").button();
$( "#ClearFilter").button();

$('#FilterRecords').click(function (e) {
    e.preventDefault();
    $('#TableContainer').jtable('load', {
        queryFilter: $('#filterValue').val(),
        columnName: $('#columnName').val(),
        dateFilter: $('#datePicker').val()
    });
    $("#columnName").select2();
});

$('#ClearFilter').click(function (e) {
	e.preventDefault();
	$('#filterValue').val('');
	$('#columnName').val('');
	$('#datePicker').val('');
	$('#datePicker').css('display','none');
	$('#filterValue').css('display','none');
	$('#TableContainer').jtable('load');
	 $("#columnName").select2();
});

});
</script>
<script type="text/javascript">
function processFilterRequest()
{
	var temp=document.getElementById("columnName");
	var tempVal=temp.value;
	tempVal.trim();
	if(tempVal.match("CALLEE"))
		{
		document.getElementById("filterValue").style.display="inline";
		document.getElementById("datePicker").style.display="none";
		}
	if(tempVal.match("CALLER"))
		{
		document.getElementById("filterValue").style.display="inline";
		document.getElementById("datePicker").style.display="none";
		}
	if(tempVal.match("DAY"))
		{
		document.getElementById("datePicker").style.display="inline";
		document.getElementById("filterValue").style.display="none";
		}
}
</script>
</head>
<body>
<div id="filterRecords" style="padding-left: 20px;padding-right: 20px;padding-top: 50px" >
					 <form><table>
					 <tr><td>
				     <label style="font-size: 20px;font-style: normal;font-weight: bold;margin-right: 10px">Filter by:</label></td>
				     <td><input type="text" id="filterValue" style="width: 140px; height:24px;display: none" maxlength="20" title="Please enter text to filter records"/></td>
				     <td><input type="text" id="datePicker" style="width: 140px; height:24px;display: none" maxlength="20" title="Please choose a date to filter records"/></td>
				     <td><select id="columnName" onchange="processFilterRequest();" style="width: 200px">
				        	<option>-Select-</option>
				            <option value="CALLEE">CALLEE</option>
				             <option value="CALLER">CALLER</option>
				            <option value="DAY">DAY-OF-CALL</option>
				        </select></td>
				        <td><button id="FilterRecords" style="height: 28px">FILTER</button></td>
				        <td><button id="ClearFilter" style="height: 28px">CLEAR-FILTER</button></td>
				        </tr>
				        </table>
				    </form>
				</div>
				
<div id="TableContainer" style="padding-left: 20px;padding-right: 20px;padding-top: 20px"></div>
</body>
</html>