         
             
              
               <form method="post" action="../loginServlet" id="loginform" onsubmit="return validateLogin(this);">
<table align="right">
                   <tr>
                    <td> Username : 
                    <input name="userName" type="text" id="userName" /><p id="nameError1" style="color: blue;font-size: 12px"></p>
                    </td>

                    
                    <td>Password : 
                    <input name="password" type="password" id="password1" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p id="passwordError1" style="color: blue;font-size: 12px"></p>
                  </td>
<td  align="right">
					<input type="submit"  value="Login" class="button">
         			<!-- <input type="reset" value="Reset" class="button"> -->
         			</td>
                  
                   
                    
					</tr>
					<tr>
					
					<td  colspan="3" align="right"><a href="forgotPassword.jsp">Forgot Password</a><br/></td>
					<!--  <td><a href="../sipml5/expert.htm" target=newtab> Settings </a><br/></td>-->
					</tr>
    </table>
                </form>


   
            