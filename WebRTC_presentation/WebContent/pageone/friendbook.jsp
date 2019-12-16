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


 
<table bgcolor="#D8E5FF">
<tr>
<td>
<table>
	<tr>
	<td>
		<ul>
              <%  for (int i = 0; i < list.size(); i++) {
																
							if(!(session.getAttribute("privateIdentity").toString()).
															equalsIgnoreCase(list.get(i).getFriendSipURI().toString())){
										%>
									<li>
										<table>
										<tr style="width:70px">
												<td>
												<%-- <img src="<%=request.getContextPath()%>/../ViewPicsAudioVideo/CreateUserServlet?id=<%=list.get(i).getFriendSipURI().toString()%>&action=getProfilePic"  width="60" height="60" /> --%>												</td>
												<img src="<%=request.getContextPath() %>/CreateUserServlet1?id=<%=list.get(i).getFriendSipURI().toString()%>&action=getProfilePic" width="50" height="50" />											 
												</td>
												
												<td style="float:right;">
												<label id="friendname"><%=list.get(i).getFriendName().toString()%></label></br>
												<label id="friendsipuri<%=list.get(i).getFriendSipURI().toString()%>"><%=list.get(i).getFriendSipURI().toString()%></label>					
												</td>	
										</tr>							
									   
									   <tr>
												<td colspan="3">
															<!-- Audio Call -->
																			   
															<!-- Video Call -->
													            <a href="#" onClick='callUser("<%=list.get(i).getFriendName().toString()%>")'>
													                            <!-- <img src="./images/iconphone.png" /></a> -->
													                            <img src="images/icons/mobile-phone.png" width="20" height="20"/></a>
													                            
													               &nbsp;
													        <!-- Profile -->  
													               <a href="servicefriendprofile.jsp"
													                            	 onclick="return popitup('http://<%=session.getAttribute("serverip")%>:8080/ViewPicsAudioVideo/CreateUserServlet?action=getUser&id=<%=list.get(i).getFriendSipURI().toString()%>')">
													                            	 <!-- <img src="./images/iconbook.png"></a> -->
													                            	 <img src="images/icons/my-profile.png" width="20" height="20" /></a>
													                            
													                  &nbsp;
													        <!-- Offline Message -->	 
													                
													                 <a href="<%=request.getContextPath()%>/../Offlinemail/messageServlet?to=<%=list.get(i).getFriendSipURI().toString()%>" 
																						onclick="window.open(this.href, 'mywin','left=70,top=20,width=700,height=650,toolbar=1,resizable=0'); return false;" >
																					<!-- <img src="./images/iconmenu.png"></a> -->	
																					<img src="images/icons/sms-call.png" width="20" height="20"/></a>													               &nbsp;
													         
													         <!-- Remove friend -->	
																    <%-- <a href="<%=request.getContextPath()%>/FriendListController?id=<%=list.get(i).getFriendSipURI().toString()%>&action=removefriend"><img src="images/iconstar.png"></a>--%>			                            	 
													                 <a href="#" onclick="dofriendremove('friendsipuri<%=list.get(i).getFriendSipURI().toString()%>');">
													                 				<img src="images/iconstar.png" width="15" height="15"></a>
													                            	 
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

