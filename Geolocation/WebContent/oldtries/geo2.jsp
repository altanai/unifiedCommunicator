<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>WEBRTC:SIP-Call</title>

<script type="text/javascript">
var arr2;
var arr;//Array Variable declared globally


var xmlHttpRequest;
if(window.XMLHttpRequest)
	{
	xmlHttpRequest=new XMLHttpRequest();
	}
else if(window.ActiveXObject)
	{
	xmlHttpRequest=new ActiveXObject(MICROSOFT.XMLHTTP);
	}
function makeSipCall()	//ADD These to the original call javascript
{
	arr2=new Array(); 
	arr2[arr2.length]=document.getElementById("caller").value;
	arr2[arr2.length]=document.getElementById("callee").value;
	var startTime=new Date();
	arr2[arr2.length]=startTime.getTime();
	document.getElementById("HangUp").disabled=false;
	document.getElementById("CALL").disabled=true;
	
}
function eraseResponseMessage()
{
	document.getElementById("serverReply").innerHTML="";
	}
	
function endCall()//ADD These to the original hangup javascript
{
	var endTime=new Date();
	arr2[arr2.length]=endTime.getTime();
	document.getElementById("caller").value="";
	document.getElementById("callee").value="";
	
	
	arr=new Array();
	arr[arr.length]="sip:altanai@tcs.com";
	arr[arr.length]="1231";
	arr[arr.length]="2354235";
	
	var DateTime=new Date();
	arr[arr.length]=DateTime.getTime();
	arr[arr.length]=DateTime.getDate();
	
	
	
	sendDataToUpload();
}

function sendDataToUpload() //This function makes use of AJAX To Call the Servlet
{
	xmlHttpRequest.open("POST", "http://10.1.5.3:8080/Geolocation/GeolocationstoreServlet?sipuri="+arr[0]+"&latitude="+arr[1]+"&longitude="+arr[2]+"&date="+arr[3]+"&time="+arr[4], true);
	xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
	xmlHttpRequest.send();
	
}
function receiveMessageFromServer()
{
	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
		{
		document.getElementById("serverReply").innerHTML=xmlHttpRequest.responseText;
		document.getElementById("HangUp").disabled=true;
		document.getElementById("CALL").disabled=false;
		}
}
</script>
</head>
<body>
<H2 style="color: gray;" align="center">Making SIP Calls</H2>
<br/>
<br/>
<table align="center">
<tr><td></td><td></td></tr>
<tr><td>Sender:</td><td><input type="text" name="caller" id="caller" onfocus="eraseResponseMessage()"></td></tr>
<tr><td>Receiver:</td><td><input type="text" name="callee" id="callee"></td></tr>
<tr><td><br/></td><td><br/></td></tr>
<tr><td align="center"><button id="CALL" onclick="makeSipCall()">CALL</button></td><td><button id="HangUp" disabled="disabled" onclick="endCall()">HANGUP</button></td></tr>
</table>
<h3 align="center" id="serverReply"></h3>
</body>
</html>