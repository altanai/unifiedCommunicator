
        <table border=1>
        
        <tr>
        	<td>Registered Successfully , You can add more details </td>
        </tr>
		
		<tr>
			<td>
			
				<h2>Upload Profile Pic</h2>
				<form enctype="multipart/form-data" method="POST" onsubmit="return validateMoreDetails();" name="createUserform" action="../CreateUserServlet">
				<table id="AddCustTable" align="center">
									<tr>
										<td>Name:</td>
										<td><input id="Name" type="text" name="userid" title="Id should contain only digits only." maxlength="40" value=<%=request.getParameter("displayName")%> /></td>
										<td id="NameError" style="color: red;"></td>
										<td ></td>
									</tr>
									<tr>
										<td>Sip Uri:</td>
										<td><input id="Name" type="text" name="name" title="Name should contain only alphabets and whitespaces." maxlength="40" value=<%=request.getParameter("privateIdentity")%> /></td>
										<td id="NameError" style="color: red;"></td>
									</tr>
									<tr>
						<!-- 				<td style="vertical-align: top;">Address:</td>
										<td><textarea id="Address" name="address" cols="30" rows="5" title="Address should be of maximum 200 characters." onblur="checkForAddress('Address')"></textarea></td>
										<td id="addressError" style="color: red;vertical-align: top;"></td>
									</tr>
									<tr>
										<td>Contact Number:</td>
										<td><input id="Contact" type="text" name="contact" title="Contact number should contain only digits." maxlength="15" onblur="checkContactNumber('Contact')"/></td>
										<td id="contactError" style="color: red;"></td>
									</tr> -->
									<tr>
										<td>Profile-Pic:</td>
										<td><input style="padding: 2px 0px 2px 0px;" id="picture" type="file" name="picture" title="The document should be a .jpg file." onchange="checkUploadedPic('picture')"/></td>
										<td id="imageError" style="color: red;"></td>
									</tr>
									----------------------------
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
										<td><input style="padding: 3px;" type="submit" name="submit" value="Submit Details"/>
										<input style="padding: 3px;" type="reset" value="Reset" id="resetButton"/></td>
									</tr>
								</table>
				</form>
		</td>
	</tr>
</table>

<br/>