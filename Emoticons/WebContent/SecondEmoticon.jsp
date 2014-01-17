<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="style/jquery.cssemoticons.css">
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.cssemoticons.min.js" type="text/javascript"></script>

<title>Emoticons</title>
<script>
$(document).ready(function(){
	$("#chat").click(function(){
		$("#chatMsg").html($("#chatText").val());
		$("#chatText").val('');
		$('.text').emoticonize({
		}); 
	});
});
</script>
</head>
<body>
<H2>Normal Emoticons</H2>
<textarea id="chatText"></textarea>
<button id="chat">Send Chat</button>
<p id="chatMsg" class="text"></p>
</body>
</html>