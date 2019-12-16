<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="presence.beanclass.presence"%>
<jsp:include page="/phonebookLineServlet" />
<%@page import="phonebook.webrtc.UserProfile"%>
<%@page import="userprofile.beanclass.friend"%>

<%
    ArrayList<presence> list = new ArrayList<presence>();
    
	list = (ArrayList) request.getAttribute("registrationDetails");

%>
<%
ArrayList<UserProfile> users=(ArrayList<UserProfile>)request.getAttribute("List");
%>


<script>
function dofriendadd(element) 
{ 

    var xmlHttp = new XMLHttpRequest(); 
    var frinedtobeadded = document.getElementById(element).value;
    
    xmlHttp.open("GET","http://localhost:8080/WebRTC_presentation/FriendListController?action=findFriendURI&friendName="+frinedtobeadded+"&name=<%=session.getAttribute("name")%>", true);     
    xmlHttp.send(); 
}

function dofriendremove(element) 
{ 

    var xmlHttp = new XMLHttpRequest(); 
    var frinedtoberemoved = document.getElementById(element).value;
    
    xmlHttp.open("GET","http://localhost:8080/WebRTC_presentation/FriendListController?action=removefriend&friendName="+frinedtoberemoved+"&name=<%=session.getAttribute("name")%>", true);     
    xmlHttp.send(); 
}
</script>


<!-- adding new frnds   --> 
 <%-- <form name="myForm" action="<%=request.getContextPath()%>/FriendListController?action=findFriendURI"  method="post"> --%>
 <form name="addfriendform">      
        <table>
         <tr>  
	        <td>
	          <input type="text" name="friendName" id="friendName" placeholder="sip:abc@tcs.com">&nbsp;&nbsp;&nbsp;
	          </td>
	          <td>
	        <input type="button" name="submit" value="Add Contact" onclick="dofriendadd('friendName')">
	        </td>
        </tr>
        </table>
</form> 
 <!--  end add new frnd    -->
 
 
<table bgcolor="#D8E5FF">
<tr>
<td>
<table>
<tr>
	<td>
	   <ul>
   <%
				for (int i = 0; i < list.size(); i++) {
							
					if(!
						(session.getAttribute("privateIdentity")).
									equals(list.get(i).getFriendSipURI().toString())){
	%>
						<li>
						<table>
						<tr style="width:70px">
						<td>
						<img src="http://<%=session.getAttribute("serverip")%>:8080/UploadPicsAudioVideo/CreateUserServlet?id=<%=list.get(i).getFriendSipURI().toString()%>&action=getProfilePic"  width="60" height="60" />
						</td>
						<td>
						 
						</td>
						<td style="float:right;">
						<%=list.get(i).getFriendName().toString()%></br>
						<%=list.get(i).getFriendSipURI().toString()%>
						
						</td>								
						<tr style="float:left;width:100px">
						<td>
									   <!-- Audio Call -->
									   
									  <!-- Video Call -->
			                            <a href="#" onClick='callUser("<%=list.get(i).getFriendName().toString()%>")'>
			                            <img src="./images/iconphone.png" /></a>
			                            
			                            &nbsp;
			                          <!-- Profile -->  
			                            <a href="http://<%=session.getAttribute("serverip")%>:8080/ViewPicsAudioVideo/CreateUserServlet?action=getUser&id=<%=list.get(i).getFriendSipURI().toString()%>"
			                            	 onclick="return popitup('http://<%=session.getAttribute("serverip")%>:8080/ViewPicsAudioVideo/CreateUserServlet?action=getUser&id=<%=list.get(i).getFriendSipURI().toString()%>')"
			                            	 ><img src="./images/iconbook.png"></a>
			                            
			                            &nbsp;
			                            <!-- Offline Message -->	 
			                            <a href="serviceofflinemessages.jsp" 
												onclick="window.open(this.href, 'mywin','left=20,top=20,width=500,height=500,toolbar=1,resizable=0'); return false;" >
											<img src="./images/iconmenu.png"></a>
			                            	 
										 &nbsp;
			                            <!-- Remove friend -->	
										<%-- <a href="<%=request.getContextPath()%>/FriendListController?id=<%=list.get(i).getFriendSipURI().toString()%>&action=removefriend"><img src="images/iconstar.png"></a>--%>			                            	 
			                            <a href="#" onclick="dofriendremove(<%=list.get(i).getFriendSipURI().toString()%>);"><img src="images/iconstar.png"></a>
			                            	 
			                            <% if (list.get(i).getPresence().toString().equalsIgnoreCase("online")) {%>
											<input type="submit" name="submit" style=" border-radius: 5px; height: 15px; background: green;" id="sub2" value="  ">
										<% } else if(list.get(i).getPresence().toString().equalsIgnoreCase("offline")) { %>
											<input type="submit" name="submit" style=" border-radius: 5px; height: 15px; background: red;" id="sub2" value="  ">
										<%} else { %>	
										    <input type="submit" name="submit" style=" border-radius: 5px; height: 15px; background: white;" id="sub2" value="  ">
										<%} %>
										</td>
		</tr>
</table>
</li>
			<%
							}
				}
%>
</ul>

</td>
</tr>
</table>
</td>
</tr>
</table>