<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>

/* <!-- -ajax to send data to server --> */

var arr;  //Array Variable declared globally
var xmlHttpRequest;
if(window.XMLHttpRequest)
	{
	xmlHttpRequest=new XMLHttpRequest();
	}
else if(window.ActiveXObject)
	{
	xmlHttpRequest=new ActiveXObject(MICROSOFT.XMLHTTP);
	}
	

/* <!-- - end ajax code  --> */ 

function sendDataToUpload() //This function makes use of AJAX To Call the Servlet
{
	alert("uploading data to servlet 2");
	xmlHttpRequest.open('POST', 'http://localhost:8080/Geolocation/gservlet',true);
	xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
	xmlHttpRequest.send();
	alert("done uploading data");
}

</script>
</head>
<body>
   <button onclick="sendDataToUpload()">send</button>
</body>
</html>