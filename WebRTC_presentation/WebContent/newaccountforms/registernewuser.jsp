  
 <form name="f2" onsubmit="return validateRegistration(this);" method="get" action="../loginServlet">
<table align="right" style="border-color:'blue'" border="1">
<tr>
<td colspan="2" align="center"> <h2 >Sign-Up</h2><br/></td>

</tr>
<tr>
<td>Display Name*:</td>
<td><input type="text" name="displayName" id="displayName" placeholder="abc" onblur="checkDisplayName('displayName')"></td><td id="nameError"style="color: blue;font-size: 12px" ></td>
</tr>
<tr>
<td>Public Identity*:</td>
<td><input type="text" name="publicIdentity" id="publicIdentity" placeholder="abc" onblur="checkPublicIdentity('publicIdentity')"></td><td id="publicIdenError" style="color: blue;font-size: 12px"></td>
</tr>
<tr>
<td>Private Identity*:</td>
<td><input type="text" name="privateIdentity" id="privateIdentity" placeholder="sip:abc@tcs.com" onblur="checkPrivateIdentity('privateIdentity')"></td><td id="privateIdenError" style="color: blue;font-size: 12px"></td>
</tr>
<tr>
<td>Password*:</td>
<td><input type="password" name="password" id="passwordReg" placeholder="*****" onblur="checkPassword('passwordReg')"></td><td id="passwordError" style="color: blue;font-size: 12px"></td>
</tr>
<tr> 
 <td>Email:</td>
 <td><input type="text" name="wsuri" placeholder="xyz@gamil.com"></td><td></td>
</tr>
<tr>
<td>Realm*:</td>
<td><input type="text" name="realm" id="realm" placeholder="tcs.com"onblur="checkRealm('realm')"></td><td id="realmError" style="color: blue;font-size: 12px"></td>
</tr>
<tr>
<td>Secret Question:</td>
<td><select name="secretQuestion" id="secretQuestion" onmouseup="secretQuestion('secretQuestion');">
<option value ="Select">----Select---</option>
<option value="nameOfFavouriteTeacher">Name Of Favourite Teacher</option>
<option value="placeOfBirth">Place Of Birth</option>
<option value="motherMedianName">Mother Median Name</option>
<option value="bestFriend'sName">Best Friend's Name</option>
<option value="favouritePalace">Favourite Palace</option>
</select></td><td id="quesError" style="color: blue;font-size: 12px"></td>
</tr>
<tr>
<td>Secret Answer*:</td>
<td><input type="text" name="secretAnswer"  id="secretAnswer" onblur="checkForSecretAnswer('secretAnswer');"/></td><td id="answerError" style="color: blue;font-size: 12px"></td>
</tr>
 <tr>

<td  align="center"><input type="submit" name="register" value="SignUp"/></td>
<td ><input type="reset" name="reset" value="Reset"/></td>
</tr>
</table>
</form> 