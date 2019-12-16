	
        <table border=1>
        
        <tr>
        	<td>Registered Successfully , You can add more details </td>
        </tr>
		
		<tr>
			<td>
			
				<h2>Upload Profile Pic</h2>
				<form method="POST" name="createUserotheraccountform" action="<%=request.getContextPath()%>/../../Otheraccounts/thirdpartyaccountsServlet">
				<table id="AddCustTable" align="center">
									
									<tr>
										<td>Name:</td>
										<td><input id="name" type="text" name="name"  value=<%=session.getAttribute("name")%> /></td>
									</tr>
									
									<tr>
										<td>Sip Uri:</td>
										<td><input id="sipuri" type="text" name="sipuri"  value=<%=session.getAttribute("privateIdentity")%> /></td>										
									</tr>

									<tr>
										<td>Google account :</td>
										<td><input id="googleid" type="text" name="googleid" value="none"/></td>
									</tr>
									
									<tr>
										<td>Yahoo account :</td>
										<td><input id="yahooid" type="text" name="yahooid" value="none" /></td>
									</tr>
									
									<tr>
										<td>Facebook account :</td>
										<td><input id="facebookid" type="text" name="facebookid" value="none" /></td>
									</tr>
									
									<tr>
										<td>Twitter account :</td>
										<td><input id="twitterid" type="text" name="twitterid" value="none" /></td>
									</tr>

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