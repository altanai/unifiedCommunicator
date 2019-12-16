<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form enctype="multipart/form-data" method="POST"
				onsubmit="return validateMoreDetails();" name="createUserform"
				action="../CreateUserServlet">
				<table id="AddCustTable" align="center">
				
					<tr>
						<td>Name:</td>
						<td><input id="Name" type="text" name="userid"
							title="Id should contain only digits only." maxlength="40"
							value=<%=request.getParameter("displayName")%> /></td>
						<td id="NameError" style="color: red;"></td>
						<td></td>
					</tr>
					<tr>
						<td>Sip Uri:</td>
						<td><input id="Name" type="text" name="name"
							title="Name should contain only alphabets and whitespaces."
							maxlength="40" value=<%=request.getParameter("privateIdentity")%> /></td>
						<td id="NameError" style="color: red;"></td>
					</tr>
					<tr>
						<td style="vertical-align: top;">Address:</td>
						<td><textarea id="Address" name="address" cols="30" rows="5"
								title="Address should be of maximum 200 characters."
								onblur="checkForAddress('Address')"></textarea></td>
						<td id="addressError" style="color: red; vertical-align: top;"></td>
					</tr>
					<tr>
						<td>City:</td>
						<td><input type="text" name="city"></td>
					</tr>
					<tr>
						<td>State:</td>
						<td><input type="text" name="state"></td>
					</tr>
					<tr>
						<td>Country:</td>
						<td><input type="text" name="country"></td>
					</tr>
					<tr>
						<td>Contact No.:</td>
						<td><input id="Contact" type="text" name="contact"
							title="Contact number should contain only digits." maxlength="15"
							onblur="checkContactNumber('Contact')" /></td>
						<td id="contactError" style="color: red;"></td>
					</tr>
					<tr>
						<td>Profile:</td>
						<td><input type="text" name="profile"></td>
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