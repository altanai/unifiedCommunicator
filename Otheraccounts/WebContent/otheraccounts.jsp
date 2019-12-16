<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% session.setAttribute("googleid", request.getParameter("googleid")); 
 session.setAttribute("yahooid", request.getParameter("yahooid"));
 session.setAttribute("facebookid", request.getParameter("facebookid"));
 session.setAttribute("twitterid", request.getParameter("twitterid")); %>
</head>
<body>
<form method="POST" name="createUserotheraccountform" action="<%=request.getContextPath()%>/../../Otheraccounts/thirdpartyaccountsServlet">
				<table id="AddCustTable" align="center">

<%-- 									<tr>
										<td><img src="<%=request.getContextPath() %>/CreateUserServlet1?id=<%=request.getParameter("privateIdentity")%>&action=getProfilePic" width="60" height="60" ></td>
										<td><input id="name" type="text" name="name"  value=<%=session.getAttribute("name")%> /></td>
									</tr>
									
									<tr>
										<td>Sip Uri:</td>
										<td><input id="sipuri" type="text" name="sipuri"  value=<%=session.getAttribute("privateIdentity")%> /></td>										
									</tr> --%>

									<tr>
										<td><img src="socialimg/googleplus.png" width="30" height="30" >Google account :</td>
										<td><input id="googleid" type="text" name="googleid" value="<%=session.getAttribute("googleid")%>"/></td>
									</tr>
									
									<tr>
										<td><img src="socialimg/yahoo.png" width="30" height="30">Yahoo account :</td>
										<td><input id="yahooid" type="text" name="yahooid" value="<%=session.getAttribute("yahooid")%>" /></td>
									</tr>
									
									<tr>
										<td><img src="socialimg/fb.png" width="30" height="30">Facebook account :</td>
										<td><input id="facebookid" type="text" name="facebookid" value="<%=session.getAttribute("facebookid")%>" /></td>
									</tr>
									
									<tr>
										<td><img src="socialimg/twitter.png" width="30" height="30">Twitter account :</td>
										<td><input id="twitterid" type="text" name="twitterid" value="<%=session.getAttribute("twitterid")%>" /></td>
									</tr>

									<tr>
										<td></td>
										<td><input style="padding: 3px;" type="submit" name="submit" value="Submit Details"/>
										<input style="padding: 3px;" type="reset" value="Reset" id="resetButton"/></td>
									</tr>
								</table>
				</form>
</body>
</html>