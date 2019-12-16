<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<Script>
function popitup(url) {

    LeftPosition = (screen.width) ? (screen.width - 800) / 2 : 0;
    TopPosition = (screen.height) ? (screen.height - 700) / 2 : 0;
    var sheight = (screen.height) * 0.9;
    var swidth = (screen.width) * 0.8;          

  
 settings = 'width='+swidth+',height='+sheight+',top='+TopPosition+', left='+ LeftPosition+',menubar=no,resizable=no,scrollbars=yes,location=no,toolbar=no,addressbar=no,titlebar=no'
  
 newwindow = window.open(url, '', settings);
    if (window.focus) { newwindow.focus() }
    return false;
}

function popitup2(url) {

    LeftPosition = (screen.width) ? (screen.width - 800) / 2 : 0;
    TopPosition = (screen.height) ? (screen.height - 700) / 2 : 0;
    var sheight = (screen.height) * 0.9;
    var swidth = (screen.width) * 0.8;          

 //   settings = 'height='+ sheight + ',width='+ swidth + ',top=' + TopPosition + ',left=' + LeftPosition + ',scrollbars=yes,resizable=yes,toolbar=no,status=no,menu=no, directories=no,titlebar=no,location=no,addressbar=no'
   
 settings = 'width='+swidth+',height='+sheight+',top='+TopPosition+', left='+ LeftPosition+',menubar=no,resizable=no,scrollbars=yes,location=no,toolbar=no,addressbar=no,titlebar=no'
  
 newwindow = window.open(url, '', settings);
    if (window.focus) { newwindow.focus() }
    return false;
}
</Script>
open new window
<input type ="button" value="open new window " onclick="popitup()">
</body>
</html>