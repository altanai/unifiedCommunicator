<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablestyle.css"/>
<script src="scripts/jquery-1.9.1.js"></script>
<script type="text/javascript">
var xmlHttpRequest;
if (window.XMLHttpRequest) {
	xmlHttpRequest = new XMLHttpRequest();
} else if (window.ActiveXObject) {
	xmlHttpRequest = new ActiveXObject(MICROSOFT.XMLHTTP);
}
function getJSON()
{
	alert("geetinig json");
	xmlHttpRequest.open("GET", "VoiceMailServlet?action=getListOfVoiceMails",true);
	xmlHttpRequest.onreadystatechange=testJSONResponse;
	xmlHttpRequest.send();
	}
function testJSONResponse()
{
	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
		{
			document.getElementById("dynamo").innerHTML="";
			var table=$('<table id="formtable"></table>');
			var jsonResponseFromServer=eval('('+xmlHttpRequest.responseText+')');
			var i=0;
			$.each(jsonResponseFromServer.Records, function(key, val) {
				 var tr=$('<tr></tr>');
				 i++;
			$.each(val, function(k, v){
				$('<td><input type="radio" name="friends" id="friends'+i+'">'+v+'</td>').appendTo(tr);
		    });
			tr.appendTo(table);
		});
			table.appendTo('#dynamo');
		}
}
</script>
</head>
<body>
<div id="dynamo">sfbeugbweoigbfovsweegbsnbdrlkgn;idohflkbrnopdfvoidnglk/nvbosfbwivsiuvbv
vvawefkwj vskjgsdkvns 
/fewuyfg ewifs i ma sdh hopsshubha slove sshdwta fadn '
afbwednblvkbsgkesn;odnbl;dpodbndm 
slergneondzf.h selkbzdv</div>
<table border='1' id="display"></table>
<button onclick="getJSON();">CLick</button>
</body>
</html>