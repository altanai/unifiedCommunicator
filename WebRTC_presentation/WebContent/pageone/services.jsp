<%
String s1=(String)session.getAttribute("themename");
System.out.println(s1);
String s;
if(s1==null||s1.equals("default"))
{
s="";
}
else
	s="_"+s1;

%>
<script type="text/javascript">



function hoverimg(elemId){
	//alert("hello");
	var id=document.getElementById("elemId");
	id.style['width']='100px';
}
</script>

<!--  background-image: url('images/services_bg_blue.png');  --><!-- 
 border:solid; border-color: white; border-width: 2px; width: 950px; height:290px; padding-left: 50px;padding-top: 40px" -->
<div class="containsection" >
             <div class="row no-bottom-margin">
             
                <section class="col"  >
                    <h2><a href="serviceconferencing.jsp" target=newtab> Conferencing </a></h2>
                    <p><img class="align-left" alt="" src="images/services/webdesign<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62" /> Video Conferencing, File Sharing and Chat-room  </p>
                </section>
                
                
                <section class="col mid">
                    <h2><a href=#"" target=newtab>Profile</a></h2>
                    <p><img class="align-left" alt="" src="images/services/logo-design-and-branding<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62" />
                    <a href="serviceprofile.jsp" target=newtab>My Profile</a><br>
                    <a href="<%=request.getContextPath()%>/../Otheraccounts/thirdpartyaccountsfetchServlet?id=<%=session.getAttribute("privateIdentity")%>" target=newtab>Link To Third party accounts</a> <br>
                    <a href="<%=request.getContextPath()%>/deleteAccountServlet" target=newtab>Delete My account</a></p>
                </section>
                
				
                <section class="col">
<%--                   <h2><a href="http://<%=session.getAttribute("serverip")%>:8080/WebRTCCallLogs/logsServlet" target=newtab >History </a></h2> --%>
                  <h2><a href="#" target=newtab >History and Analytics </a></h2> 
						 <p><img class="align-left" alt="" src="images/services/seo-services<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62" />
					<a href="servicecalllogs.jsp" target=newtab>Call Logs </a><br>
                    <a href="servicegraph.jsp" target=newtab>Graphs </a></p>
                </section>
        
 			</div> 
 </div>
 <div class="containsection2">
            <div class="row">
                <section class="col">
                    <h2><a href="#" target=newtab> VoiceMail</a></h2>
                    <p><img class="align-left" alt="" src="images/services/print-design<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62"/>        
                     <a href="servicevoicemailrecord.jsp" target=newtab>Record Voice Mail</a><br>
                    <a href="servicevoicemailview.jsp" target=newtab>Listen Voice Mail</a> </p>
                </section>
                
                <section class="col mid">
                  <h2><a href="#" target=newtab> Geolocation </a></h2>
                    <p><img class="align-left" alt="" src="images/services/webdevelopment<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62" />                   
                    <a href="servicegeolocation.jsp" target=newtab>Post my Geolocation</a><br>
                    <a href="servicegeolocationfriends.jsp" target=newtab>Location of a Friend</a><br>
                     <a href="servicegeolocationfriendstogether.jsp" target=newtab>Location of all Friends</a></p>
                </section>

                <section class="col">
                
                    <h2><a href="#" target=newtab>Import Contacts  </a></h2>
                    <p><img class="align-left" alt="" src="images/services/newsletter<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62"/>
					<a href="http://localhost:8080/WebRTC_presentation/pageone/servicefbcontacts.jsp" target=newtab >Import contacts from <img src="socialmediaimages/1382539943_facebook_02.png" width="30" height="30" title="facebook"> </a> <br/>
					<a href="../../GoogleContacts/GoogleContactsController?id=<%=session.getAttribute("privateIdentity")%>" target=newtab >Import contacts from <img src="socialmediaimages/1382539976_social_0.png" width="20" height="20" title="Google Plus"> </a>
               </p>
                </section>
    		</div>  
   </div>          
 <br/><br/>