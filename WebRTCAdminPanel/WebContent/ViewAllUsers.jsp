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

<script>
$(document).ready(function () { 
	$('#tableContainer').jtable({
	actions: { 
		listAction: '<%=request.getContextPath()%>/AdminPanelServlet?action=viewAllUsers'<% if(request.getParameter("req").equalsIgnoreCase("edit")){%>,
		deleteAction: '<%=request.getContextPath()%>/AdminPanelServlet?action=deleteUser'<%}%>
	},
		title:'User List',
		paging: true,
		pageSize:5,
        sorting: true,
        defaultSorting:'DISPLAYNAME ASC',
        columnSelectable: false,
        defaultDateFormat: 'dd-M-yy',
        openChildAsAccordion: true,
        saveUserPreferences: false,
        fields: { 
        	DISPLAYNAME: { 
				title: 'Display Name',
				width: '25%',
			}, 
			PUBLICIDENTITY: { 
				title: 'Public Identity',
				width: '25%',
			},
			PRIVATEIDENTITY:
			{
			key:true,
			title :'Private Identity',
			width:'30%',
			}<% if(request.getParameter("req").equalsIgnoreCase("view")){%>,
			DETAILS: {
				width:'20%',
			    title: 'Details',
			    sorting:false,
			  	display: function (data) {
			    	var newData=data.record.PRIVATEIDENTITY;
			    	var $link = $('<a href="AdminPanelServlet?action=viewUserDetail&value='+newData+'" style="color:blue">View Details</a>');
			    	 
			        return $link; 
			    }
			}<%} else{%>,
			EDIT: {
				width:'20%',
			    title: 'Edit',
			    sorting:false,
			  display: function (data) {
			    	var newData=data.record.PRIVATEIDENTITY;
			    	var $link = $('<a href="AdminPanelServlet?action=editUserDetail&value='+newData+'" style="color:blue">Edit Details</a>');
			        return $link; 
			    }
			}
			<%}%>
	}
});
	
$('#tableContainer').jtable('load');
$( "#FilterRecords").button();
$( "#ClearFilter").button();
$("#columnName").select2();

$("#columnName").change(function(){
	if($("#columnName").val().match("DISPLAYNAME")){
	$( "#filterValue").css("display","");}
	else if($("#columnName").val().match("PRIVATEIDENTITY")){
	$( "#filterValue").css("display","");}
	else if($("#columnName").val().match("Select")){
		$( "#filterValue").css("display","none");}
});
$("#ClearFilter").click(function(e){
	 e.preventDefault();
	$( "#filterValue").css("display","none");
	$('#filterValue').val('');
	$('#tableContainer').jtable('load');
	$('#columnName').val('');
});

$('#FilterRecords').click(function (e) {
    e.preventDefault();
    $('#tableContainer').jtable('load', {
        queryFilter: $('#filterValue').val(),
        columnName: $('#columnName').val(),
    });
});
});
</script>




<title>Edit User Friend-list</title>

<!-- -----------------------Sidemenu Section--------------------- -->

<div style="margin-top: 8%;">

<div style="display:block;margin-left:1%; float: left; height: 72%; margin-right: 2%;">
<jsp:include page="sidemenu.jsp" />
</div>

<!-- -----------------------Content Section--------------------- -->


<div>
<div id="filterRecords" style="display: block; float:right; margin-right: 20%;margin-bottom:2%" >
					 <form><table>
					 <tr><td>
				     <label style=" font-size: 20px;font-style: normal;margin-right: 5px;">Filter By:</label></td>
				     <td><input type="text" id="filterValue" style="width: 120px; height:26px;display: none;margin-right: 5px;outline-color: highlight;" maxlength="20"/></td>
				     <td><select id="columnName" style="width: 130px;margin-right: 1%">
				        	<option value="Select">-Select-</option>
				            <option value="DISPLAYNAME">Display-Name</option>
				            <option value="PRIVATEIDENTITY">Sip-Uri</option>
				        </select></td>
				        <td><button id="FilterRecords" style="width: 80px;height: 30px">FILTER</button></td>
				        <td><button id="ClearFilter" style="width: 80px;height: 30px">CLEAR</button></td>
				        </tr>
				        </table>
				    </form>
				</div>
<div id="tableContainer" style="width: 65%; display: block; float:right; margin-right: 5%; text-shadow: none;"></div>
</div>
</div>

