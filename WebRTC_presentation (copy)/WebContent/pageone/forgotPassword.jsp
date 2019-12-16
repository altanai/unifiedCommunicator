<%@ include file="headerlogin.jsp" %>

    <!-- main -->
    <br/><br/><br/><br/><br/>
   <form name="f1" method="get" action="../forgotPasswordServlet">
<table>
<h2 >Enter Your Secret Answer </h2>
<br/>
<tr>
<td>User Name:</td>
<td><input type="text" name="userName"></td>
</tr>
<tr>
<td>Secret Question:</td>
<td><select name="secretQuestion">
<option value ="Select">----Select---</option>
<option value="nameOfFavouriteTeacher">Name Of Favourite Teacher</option>
<option value="placeOfBirth">Place Of Birth</option>
<option value="motherMedianName">Mother Median Name</option>
<option value="bestFriend'sName">Best Friend's Name</option>
<option value="favouritePalace">Favourite Palace</option>
</select></td>
</tr>
<tr>
<td>Secret Answer:</td>
<td><input type="text" name="secretAnswer"/><br/><br/><br/></td>
</tr>
<tr>
<td colspan=2 align="center"><input type="submit" name="register" value="Show Password"/></td>
</tr>

</table>
</form>


<!-- footer -->
<div id="footer-wrap"></div>