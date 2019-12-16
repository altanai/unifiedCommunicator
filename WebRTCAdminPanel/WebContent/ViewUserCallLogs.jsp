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

<script type="text/javascript">
$(document).ready(function () { 
	$('#TableContainer').jtable({
	actions: { 
		listAction: '<%=request.getContextPath()%>/AdminPanelServlet?action=ViewAllLogs'
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
	dateFormat: "mm/dd/yy", 
	inline: true
});
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

<!-- -----------------------Sidemenu Section--------------------- -->

<div style="margin-top: 100px;">
<div style="display:block;margin-left:10px; float: left; height: 900px; margin-right: 20px;">
<jsp:include page="sidemenu.jsp" />
</div>

<!-- -----------------------Content Section--------------------- -->


<div>
<div id="filterRecords" style="display: block; float:right; margin-right: 20%;margin-bottom:2%" >
					<form><table>
					 <tr><td>
				      <label style=" font-size: 20px;font-style: normal;margin-right: 5px;">Filter By:</label></td>
				      <td><input type="text" id="filterValue" style="width: 120px; height:26px;display: none;margin-right: 5px;outline-color: highlight;" maxlength="20"/></td>
				     <td><input type="text" id="datePicker" style="width: 140px; height:24px;display: none;outline-color: highlight;" maxlength="20"/></td>
				     <td><select id="columnName" onchange="processFilterRequest();" style="width: 150px;margin-left: 10px;margin-right:10px">
				        	<option>-Select-</option>
				            <option value="CALLEE">CALLEE</option>
				             <option value="CALLER">CALLER</option>
				            <option value="DAY">DAY-OF-CALL</option>
				        </select></td>
				       <td><button id="FilterRecords" style="width: 80px;height: 30px">FILTER</button></td>
				        <td><button id="ClearFilter" style="width: 80px;height: 30px">CLEAR</button></td>
				        </tr>
				        </table>
				    </form>
				</div>
<div id="TableContainer" style="width: 65%; display: block; float:right; margin-right: 5%; text-shadow: none;"></div>





</div>
</div>

