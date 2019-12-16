<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="presence.beanclass.presence"%>
<%@page import="phonebook.webrtc.UserProfile"%>
<%@page import="userprofile.beanclass.friend"%>

<%
    ArrayList<presence> list = new ArrayList<presence>();
	list = (ArrayList) request.getAttribute("registrationDetails");

%>
<%
ArrayList<UserProfile> users=(ArrayList<UserProfile>)request.getAttribute("List");
%>



<!DOCTYPE html>
<!--[if IE 7 ]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8 oldie"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html>
<!--<![endif]-->

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="description" content="">
<meta name="author" content="">

<title>WebRTC client</title>

<link rel="stylesheet" href="css/style.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="css/nivo-slider.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.fancybox-1.3.4.css"
	type="text/css" />

<!--[if lt IE 9]>
	    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js"></script>
<script>
	window.jQuery
			|| document
					.write('<script src="js/jquery-1.6.1.min.js"><\/script>')
</script>

<script src="js/jquery.smoothscroll.js"></script>
<script src="js/jquery.nivo.slider.pack.js"></script>
<script src="js/jquery.easing-1.3.pack.js"></script>
<script src="js/jquery.fancybox-1.3.4.pack.js"></script>
<script src="js/init.js"></script>


</head>

<body>

<script language="javascript" type="text/javascript">
<!--
function popitup(url) {
	newwindow=window.open(url,'name','height=700,width=700');
	if (window.focus) {newwindow.focus()}
	return false;
}

// -->
</script>


<form name="myForm" action="<%=request.getContextPath()%>/FriendListController?action=findFriendURI"  method="post">
        <table>
         <tr>  
      
        <td>
	       <!-- <button onclick="var ifr=document.getElementsByName('phonebookframe')[0]; ifr.src=ifr.src;"><img src="images/iconcycle.png"></button>
	        <button><img src="images/iconstar.png"></button>
	      <button onclick="pageone/friendList/friends.jsp"><img src="images/icongroup.png"></button>  --> 
          <input type="text" name="friendName" placeholder="sip:abc@tcs.com">&nbsp;&nbsp;&nbsp;
          </td>
          <td>
        <input type="submit" name="submit" value="Add Contact">
        </td>
        </tr>
	  
        </table>
        </form> 
        <br/> 
<table bgcolor="#D8E5FF">

<tr>
  
 <td>          
	<div class="content-wrap">
	

		<section id="about-us" class="clearfix">
		
		
		

			<div class="primary">

				<p class="intro">

				</p>

				<ul class="the-team">

					<%
						for (int i = 0; i < list.size(); i++) {
							
							if(!
									("sip:"+session.getAttribute("name")+"@tcs.com").
									equalsIgnoreCase(list.get(i).getFriendSipURI().toString())){
					%>
					<li class="odd">
						<div class="thumbnail">
						<table>
						
						<tr>
							<td>
								<img src="http://<%=session.getAttribute("serverip")%>:8080/UploadPicsAudioVideo/CreateUserServlet?id=<%=list.get(i).getFriendSipURI().toString()%>&action=getProfilePic" width="60" height="60" >
								 
							</td>
						
						    <td>
								
								<table>
								    <tr>

										<td>
											<%=list.get(i).getFriendName().toString()%>&nbsp;	&nbsp;	&nbsp;	&nbsp;
										</td>
									</tr>
									
									<tr>
										<td>
											<%=list.get(i).getFriendSipURI().toString()%>&nbsp;	&nbsp;	&nbsp;	&nbsp;
										</td>
			                       </tr>
			                       
			                       <tr>
			                       		<td >

									
			                            <a href="sipml5/usercall.jsp?name=<%=list.get(i).getFriendName().toString()%>&privateIdentity=<%=list.get(i).getFriendSipURI().toString()%>"
			                            	 onclick="return popitup('sipml5/usercall.jsp?name=<%=list.get(i).getFriendName().toString()%>&privateIdentity=<%=list.get(i).getFriendSipURI().toString()%>')"
			                            	 ><img src="pageone/images/iconphone.png"></a>
			                            
			                            &nbsp;
			                            
			                            <a href="http://<%=session.getAttribute("serverip")%>:8080/ViewPicsAudioVideo/CreateUserServlet?action=getUser&id=<%=list.get(i).getFriendSipURI().toString() %>"
			                            	 onclick="return popitup('http://<%=session.getAttribute("serverip")%>:8080/ViewPicsAudioVideo/CreateUserServlet?action=getUser&id=<%=list.get(i).getFriendSipURI().toString() %>')"
			                            	 ><img src="pageone/images/iconbook.png"></a>
			                            	 
			                            	 
			                            	 <a href="<%=request.getContextPath()%>/FriendListController?id=<%=list.get(i).getFriendSipURI().toString()%>"><img src="pageone/images/iconstar.png"></a>
			                            	 
			                            	 
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
						</td>
						</tr>
						</table>
							
						</div>
						</li>
						
					<%
							}
				}
%>
				</ul>

			</div>

		</section>
	</div></td>
	</tr>
            </table>
         
   </body>
</html>
