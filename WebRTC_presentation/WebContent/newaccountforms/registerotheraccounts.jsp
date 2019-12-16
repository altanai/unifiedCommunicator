	
        <table border=1>
        
       
		<tr>
			<td>
			
				<h2>Upload Profile Pic</h2>
				<form method="POST" name="createUserotheraccountform" action="<%=request.getContextPath()%>/../../Otheraccounts/thirdpartyaccountsServlet">
				<table id="AddCustTable" align="center">

									<tr>
										<td><img src="<%=request.getContextPath()%>/CreateUserServlet1?id=<%=session.getAttribute("privateIdentity")%>&action=getProfilePic" width="100" height="100" ></td>
										<td><input id="name" type="text" name="name"  value=<%=session.getAttribute("name")%> /></td>
									</tr>
									
									<tr>
										<td>Sip Uri:</td>
										<td><input id="sipuri" type="text" name="sipuri"  value=<%=session.getAttribute("privateIdentity")%> /></td>										
									</tr>

									<tr>
										<td><img src="socialimg/googleplus.png" width="50" height="50">Google account :</td>
										<td><input id="googleid" type="text" name="googleid" value="<%=session.getAttribute("googleid")%>"/></td>
									</tr>
									
									<tr>
										<td><img src="socialimg/yahoo.png" width="50" height="50">Yahoo account :</td>
										<td><input id="yahooid" type="text" name="yahooid" value="<%=session.getAttribute("yahooid")%>" /></td>
									</tr>
									
									<tr>
										<td><img src="socialimg/fb.png" width="50" height="50">Facebook account :</td>
										<td><input id="facebookid" type="text" name="facebookid" value="<%=session.getAttribute("facebookid")%>" /></td>
									</tr>
									
									<tr>
										<td><img src="socialimg/twitter.png" width="50" height="50">Twitter account :</td>
										<td><input id="twitterid" type="text" name="twitterid" value="<%=session.getAttribute("twitterid")%>" /></td>
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