<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Offline Messages</title>

<script type="text/javascript">
function fb() {
//	alert("fb");
form.target = 'messageServlet';
form.submit();
}


function gmail() {
//	alert("gmail");
form.target = 'FacebookServlet';
form.submit();
}
</script>

</head>
<body>

<form method="get">
<table>
	<tr>
		<td>To : </td>
		<td><input type="text" name="to" name="to" value=""/> </td>
		
	</tr>
	<tr>
		<td>Message : </td>
		<td> <textarea id="textArea" disabled="disabled"  rows="6" cols="30" style="background-color:white;"></textarea></td>
		</td>
	</tr>
</table>


</br>

<!-- <input type="button" name="newWin" value="Facebook Message" onclick="fb();"></br>
<input type="button" name="SameWin" value ="Gmail" onclick="gmail();"></br> -->

&nbsp;</br>

Send Message via Facebook : <a id="myLink" href="javascript:fb();"><img src="socialmediaimages/1382539943_facebook_02.png" width="40" height="40"></a>

&nbsp;</br>

Send Message via Gmail : <a id="myLink" href="javascript:gmail();"><img src="socialmediaimages/1382540053_Android-Gmail.png" width="40" height="40"></a>

&nbsp;</br>

Send Message via Yahoo mail :<img src="socialmediaimages/1382540139_picons14.png" width="40" height="40">


</form>
</body>
</html>