<%@include file="headerservice.jsp"%>
</br></br>
<section id="main">

<form name="f1" method="post" action="GoogleContactsController">

<table align="center">

<tr>

<td colspan=2 align="center"><h3>Enter Credentials</h3></br></td>
</tr>
<tr>
<td>Email Address:</td>
<td><input type="text" name="emailAddress" value=<%=request.getParameter("gmailId") %>></td>
</tr>
<tr>
<td>Password:</td>
<td><input type="password" name="password"></td>
</tr>
<tr>
<td colspan=2 align="center"><input type="submit" name="submit" value="Submit"></td>
</tr>
</table>
</form>
</section>
</body>
</html>
<div id="footer-wrap"></div>