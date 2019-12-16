<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
//read ip from file 
var ip;
  function readip()
  {
  var pathOfFileToRead = "presentation_server_config.txt";

  ip = FileHelper.readStringFromFileAtPath
  	(
  		pathOfFileToRead
  	);
  }

  function FileHelper()
  {}
  {
  	FileHelper.readStringFromFileAtPath = function(pathOfFileToReadFrom)
  	{
  		var request = new XMLHttpRequest();
  		request.open("GET", pathOfFileToReadFrom, false);
  		request.send(null);
  		var returnValue = request.responseText;
  		return returnValue;
  	}
  }
  readip(); 
  alert( " ip "+ ip);
 //reda server ip from file end 


</script>
  


</head>
<body>
 reda ip from local file in pageone
</body>
</html>