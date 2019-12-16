<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
			<form>
				<table>
					<tr>
						<td>
							<h3>Student</h3> <br />
						</td>
					</tr>

					<tr>
						<td>SipUri:</td>
						<td><input type="text" name="sipuri" value=<%=request.getParameter("privateIdentity")%>></td>
					</tr>
					<tr>
						<td>College/Institute:</td>
						<td><input type="text" name="college"></td>
					</tr>
					<tr>
						<td>Course/Degree:</td>
						<td><input type="text" name="course"></td>
					</tr>
					<tr>
						<td>Subjects:</td>
						<td><input type="text" name="subject"><br/><br/></td>
					</tr>
					<tr>
						<td></td>
						<td><input style="padding: 3px;" type="submit" name="submit"
							value="Submit Details" /> <input style="padding: 3px;"
							type="reset" value="Reset" id="resetButton" /></td>
					</tr>
				</table>
			</form>
</body>
</html>