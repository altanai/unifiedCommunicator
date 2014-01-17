<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>

function myFunction(element)
{
alert( "in func ");
//var val=document.getElementById(element).value;
//var val=document.getElementById(element).innerText;
var val=document.getElementById(element).innerHTML;
//var val=document.getElementById(element);
alert( "value"+ val);
};

</script>
</head>

<body>

<!-- <input type="text" id="abc" name="abc"> -->

<label id="abc"> altanai</label>

<button onclick="myFunction('abc')">Try it</button>



</body>
</html>