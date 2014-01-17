<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
var successHandler = function( data, textStatus, jqXHR ) {
	  // After success reload table with JavaScript
	  // based on data...
	};

	var errorHandler = function( jqXHR, textStatus, errorThrown ) {
	  // Error handler. AJAX request failed.
	  // 404 or KO from server...
	  alert('Something bad happened while reloading the table.');
	};

	var reloadData = function() { 
	  // Process your request
	  var request = new Object();
	  request.id = 'some id'; // some data

	  // Make the AJAX call
	  jQuery.ajax({
	    type       : 'POST',
	    url        : 'http://domain/context/reload-data-url',
	    contentType: 'application/json',
	    data       : JSON.stringify(request)
	    success    : successHandler,
	    error      : errorHandler
	  });
	};
</script>

</head>
<body>
 html page 
</body>
</html>