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
                    <h2><a href="serviceprofile.jsp" target=newtab>Profile</a></h2>
                    <p><img class="align-left" alt="" src="images/services/logo-design-and-branding<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62" />Profile Description </p>
                </section>
                
				
                <section class="col">
<%--                   <h2><a href="http://<%=session.getAttribute("serverip")%>:8080/WebRTCCallLogs/logsServlet" target=newtab >History </a></h2> --%>
                  <h2><a href="servicecalllogs.jsp" target=newtab > History </a></h2> 
						 <p><img class="align-left" alt="" src="images/services/seo-services<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62" />Call Logs </p>

                </section>
        
 			</div> 
 </div>
 <div class="containsection2">
            <div class="row">
                <section class="col">
                    <h2><a href="serviceofflinemessages.jsp" target=newtab> Offline Messages</a></h2>
                    <p><img class="align-left" alt="" src="images/services/print-design<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62"/> Offline Messages using external services </p>
                </section>
                
                <section class="col mid">
                  <h2><a href="servicegeolocation.jsp" target=newtab> Geolocation </a></h2>
                    <p><img class="align-left" alt="" src="images/services/webdevelopment<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62" />Location of user and friends </p>
                </section>

                <section class="col">
                
                    <h2><a href="servicegraph.jsp" target=newtab> Analytics </a></h2>
                    <p><img class="align-left" alt="" src="images/services/newsletter<%=s %>.png" onmouseover="this.width=68;this.height=70;" onmouseout="this.width=60;this.height=62"/>Graphical display of my activity </p>
                </section>
    		</div>  
   </div>          
 <br/><br/>