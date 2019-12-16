
<table>

 
	<!-- <tr>
        	<td>Registered Successfully , You can add more details <a href="login.html">Back To Login Page</a></td>
        </tr> -->

	<tr>
		<td>

			<h2>Create Profile</h2>
			<form enctype="multipart/form-data" method="POST"
				onsubmit="return validateMoreDetails();" name="createUserform"
				action="../CreateUserServlet?name=<%=request.getParameter("privateIdentity")%>&displayName=<%=request.getParameter("displayName")%> ">
				<table id="AddCustTable" align="center">
				
					<tr>
						<td>Name:</td>
						<td><input id="Name" type="text" name="userid"
							title="Id should contain only digits only." maxlength="40"
							value=<%=request.getParameter("displayName")%> /></td>
						
						<td></td>
					</tr>
					<tr>
						<td>Sip Uri:</td>
						<td><input id="Name" type="text" name="name"
							title="Name should contain only alphabets and whitespaces."
							maxlength="40" value=<%=request.getParameter("privateIdentity")%> /></td>
					
					</tr>
						<tr>
						<td>Profile-Pic:</td>
						<td><input style="padding: 2px 0px 2px 0px;" id="picture"
							type="file" name="picture"
							title="The document should be a .jpg file."
							onchange="checkUploadedPic('picture')" /><br/><br/></td>
						<td id="imageError" style="color: red;"></td>
					</tr>
					<!-- 					<tr> -->
					<!-- 						<td>Fav. Audio-track:</td> -->
					<!-- 						<td><input style="padding: 2px 0px 2px 0px;" id="audio" type="file" name="audio" title="The document should be a .mp3 file." onchange="checkUploadedAudio('audio')"/></td> -->
					<!-- 						<td id="audioError" style="color: red;"></td> -->
					<!-- 					</tr> -->
					<!-- 					<tr> -->
					<!-- 						<td>Fav. Video:</td> -->
					<!-- 						<td><input style="padding: 2px 0px 2px 0px;" id="video" type="file" name="video" title="The document should be a .mp4 file." onchange="checkUploadedVideo('video')"/></td> -->
					<!-- 						<td id="videoError" style="color: red;"></td> -->
					<!-- 					</tr> -->
					<tr>
						<td></td>
						<td><input style="padding: 3px;" type="submit" name="submit"
							value="Submit Details" /> <input style="padding: 3px;"
							type="reset" value="Reset" id="resetButton" /></td>
					</tr>
				</table>
			</form>
		</td>
		<td>
		<h2>Personal Information</h2>
			<form action="../../UserProfile/PersonalInfoController?displayName=<%=request.getParameter("displayName")%>" method="post" name="f1">
				<table>
				
					<tr>
						<td>Sip Uri:</td>
						<td><input id="Name" type="text" name="name"
							title="Name should contain only alphabets and whitespaces."
							maxlength="40" value=<%=request.getParameter("privateIdentity")%> /></td>
						<td id="NameError" style="color: red;"></td>
					</tr>
					<tr>
						<td style="vertical-align: top;">Address:</td>
						<td><textarea id="Address" name="address" cols="25" rows="5"
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
					</tr>
					<tr>
						<td>Profile:</td>
						<td><input type="text" name="profile"><br/><br/></td>
					</tr>
					<tr>
						<td></td>
						<td><input style="padding: 3px;" type="submit" name="submit"
							value="Submit Details" /> <input style="padding: 3px;"
							type="reset" value="Reset" id="resetButton" /></td>
					</tr>
									
				</table>
			</form>
			</td>
	</tr>

	<tr>
		<td colspan=3>
			<h3>----------------------------------------------------------------------------------</h3>
		</td>
	</tr>
	<tr>
		<td>
			<form action="../../UserProfile/StudentsController" method="get" name="f1">
				<table>
					<tr>
						<td>
							<h3>Student</h3> <br />
						</td>
					</tr>

					<tr>
						<td>SipUri:</td>
						<td><input type="text" name="name" value=<%=request.getParameter("privateIdentity")%>></td>
					</tr>
					<tr>
						<td>College/Institute:</td>
						<td><input type="text" name="institute"></td>
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
		</td>
		<td>
			<form action="../../UserProfile/JobSeekersController" method="post" name="f1">
				<table>
				 
					<tr>
						<td>
							<h3>Job Seeker</h3> <br />
						</td>
					</tr>
					<tr>
						<td>SipUri:</td>
						<td><input type="text" name="name" value=<%=request.getParameter("privateIdentity")%>></td>
					</tr>
					<tr>
						<td>Qualification:</td>
						<td><input type="text" name="qualification"></td>
					</tr>
					<tr>
						<td>Field:</td>
						<td><input type="text" name="field"><br/><br/><br/></td>
					</tr>
					<tr>
						<td></td>
						<td><input style="padding: 3px;" type="submit" name="submit"
							value="Submit Details" /> <input style="padding: 3px;"
							type="reset" value="Reset" id="resetButton" /></td>
					</tr>
				</table>
			</form>
			
		</td>

		<td align="right">
			<form action="../../UserProfile/ProfessionalsController" method="get" name="f1">
				<table >

					<tr>
						<td>
							<h3>Professional</h3> <br />
						</td>
					</tr>
					<tr>
						<td>SipUri:</td>
						<td><input type="text" name="name" value=<%=request.getParameter("privateIdentity")%>></td>
					</tr>
					<tr>
						<td>Job Title:</td>
						<td><input type="text" name="jobtitle"></td>
					</tr>
					<tr>
						<td>Project:</td>
						<td><input type="text" name="project"></td>
					</tr>
					<tr>
						<td>Industry:</td>
						<td><input type="text" name="industry"><br/><br/></td>
					</tr>
					<tr>
						<td></td>
						<td><input style="padding: 3px;" type="submit" name="submit"
							value="Submit Details" /> <input style="padding: 3px;"
							type="reset" value="Reset" id="resetButton" /></td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
</table>
<br/>
<br />
<br />
<br />
