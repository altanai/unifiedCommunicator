

	<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/start/jquery-ui-1.10.3.custom.css"/> --%> 
	<script>
	$(function() {
		$( "#accordion" ).accordion({
			heightStyle: "content" ,
			collapsible: true,
		});
		 $( "#menu" ).menu();
		    $( "#menu1" ).menu();
		    $( "#menu2" ).menu();
	});
	</script>
	

<div id="accordion">
	<h3 style="color: white;  font-size: 15px;text-shadow: none;width: 215px">Profile Related Operation</h3>
	<div style="width: 193px;">
		<ul id="menu" style="list-style: none; border: none; width: 215px; padding: 0px; margin: 0px;">
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath() %>/AddUserProfile.jsp">Add User Profile</a></li>
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath() %>/ViewParticularUser.jsp">View User Profile</a></li>
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath() %>/ViewAllUsers.jsp?req=edit">Edit User Profile</a></li>
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath() %>/resetuserpassword.jsp">Password Management</a></li>
		</ul>
	</div>
	<h3 style="color: white;  font-size: 15px;text-shadow: none;width: 215px">Manage Friendlist</h3>
	<div style="width: 193px;">
		<ul id="menu1" style="list-style: none; border: none; width: 215px; padding: 0px; margin: 0px;">
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath()%>/ManageFriendlist.jsp">Manage Friend List</a></li>
		</ul>
	</div>
	<h3 style="color: white;  font-size: 15px;text-shadow: none;width: 215px">Miscellaneous Operations</h3>
	<div style="width: 193px;">
		<ul id="menu2" style="list-style: none; border: none; width: 215px; padding: 0px; margin: 0px;">
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath() %>/ViewAllUsers.jsp?req=view">View All Users</a></li>
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath() %>/ViewUserCallLogs.jsp">View User Calllogs</a></li>
		<li><a  style="font-size: 14px;" href="<%=request.getContextPath() %>/AdminPanelServlet?action=viewgraph">View User Usage Details</a></li>
		</ul>
	</div>
	
</div>
