<%@include file="header.jsp"%>


 <!----------------------------------------------------- main ---------------------------->
    <section id="main">
<h2 align="center"> Create User</h2>
<form enctype="multipart/form-data" method="POST" name="createUserform" action="<%=request.getContextPath()%>/CreateUserServlet">
<table id="AddCustTable" align="center">
					<tr>
						<td>UserId:</td>
						<td><input id="Name" type="text" name="userid" title="Id should contain only digits only." maxlength="40"/></td>
						<td id="NameError" style="color: red;"></td>
					</tr>
					<tr>
						<td>Name:</td>
						<td><input id="Name" type="text" name="name" title="Name should contain only alphabets and whitespaces." maxlength="40"/></td>
						<td id="NameError" style="color: red;"></td>
					</tr>
					<tr>
						<td style="vertical-align: top;">Address:</td>
						<td><textarea id="Address" name="address" cols="30" rows="5" title="Address should be of maximum 200 characters."></textarea></td>
						<td id="AddressError" style="color: red;vertical-align: top;"></td>
					</tr>
					<tr>
						<td>Contact Number:</td>
						<td><input id="Contact" type="text" name="contact" title="Contact number should contain only digits." maxlength="15"/></td>
						<td id="ContactError" style="color: red;"></td>
					</tr>
					<tr>
						<td>Profile-Pic:</td>
						<td><input style="padding: 2px 0px 2px 0px;" id="File" type="file" name="picture" title="The document should be a .jpg file."/></td>
						<td id="FileError" style="color: red;"></td>
					</tr>
					<tr>
						<td>Fav. Audio-track:</td>
						<td><input style="padding: 2px 0px 2px 0px;" id="File" type="file" name="audio" title="The document should be a .mp3 file."/></td>
						<td id="FileError" style="color: red;"></td>
					</tr>
					<tr>
						<td>Fav. Video:</td>
						<td><input style="padding: 2px 0px 2px 0px;" id="File" type="file" name="video" title="The document should be a .mp4 file."/></td>
						<td id="FileError" style="color: red;"></td>
					</tr>
					<tr>
						<td></td>
						<td><input style="padding: 3px;" type="submit" name="submit" value="Submit Details"/>
						<input style="padding: 3px;" type="reset" value="Reset" id="resetButton"/></td>
					</tr>
				</table>

</form>
      </section>

 <!------------------------------------------ services -------------------------------------------->


<%@include file="footer.jsp" %>