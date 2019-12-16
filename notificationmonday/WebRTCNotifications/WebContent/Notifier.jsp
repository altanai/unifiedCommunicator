<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="css/ui.notify.css" />
<link rel="stylesheet" type="text/css" href="css/start/jquery-ui-1.10.3.custom.css"/>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="scripts/jquery.notify.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Notification</title>
<script type="text/javascript">
function create( template, vars, opts ){
	return $container.notify("create", template, vars, opts);
}

$(function(){
	$container = $("#container").notify();
	var refreshId = setInterval(function(){
		
	  $("#container").html('');
		$.ajax({
			type:"POST",
			url:'NotificationServlet',
			data:{userId:'sip:bob@tcs.com',action:'getFreshNotifications'},
		 	success:function(data)
		 	{
		 		 $.each(data.Notifications, function(key, val) {
		 				 create("withIcon", { title:'New '+val.TYPE+' received!', text:val.DETAILS+' <a style="color:white;text-decoration:underline; cursor: pointer;"  id="'+val.ID+'" class="ui-notify-close" onclick="updateStatus(this);">Listen</a>', icon:'info.png' },{ 
				 			 expires:false
				 			});
		 		}); 
		 	}
		});  
    }, 10000);
});
function updateStatus(data){
	 	 $.ajax({
			type:"POST",
			url:'NotificationServlet',
			data:{notificationId:data.id , action:'updateNotificationStatus'},
		 	success:function(response)
		 	{
		 		console.log(response);	
		 	}
		});
	 	window.open("Tester.jsp","_blank","toolbar=yes, scrollbars=yes, resizable=yes, top=100, left=200, width=600, height=400");
	}
</script>

</head>
<body>
<div id="container" style="display:none">
<div id="withIcon">
	<a class="ui-notify-close ui-notify-cross" href="#">x</a>
			<div style="float:left;margin:0 10px 0 0"><img src="info.png" alt="warning" style="width: 64px;height: 64px" /></div>
			<h1 >!{title}</h1>
			<p>!{text}</p> 	
</div>
</div>
</body>
</html>