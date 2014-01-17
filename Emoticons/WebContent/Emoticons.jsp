<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="style/gemoticons.css" type="text/css" rel="stylesheet" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery.gemoticons.js"></script>
<title>Emoticons</title>
</head>
<script>
$(document).ready(function(){
	$("#buttonChat").click(function(){
		var text=$("#textField").val();
		$("#textField").val('');
		var emo=$('<div class="chat">'+text+'</div>');
		$('.chatbox').append(emo);
        $(emo).gemoticon();
	});
});
</script>
<body>
<H2>Gmail Style-Emoticons</H2>
<div id="main">
    <textarea name="text" id="textField"></textarea>
    <button id="buttonChat">Send chat</button>
</div>
<div class="chatbox"></div>
</body>
</html>