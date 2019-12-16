<%@include file="header.jsp" %>


<jsp:include page="/phonebookLineServlet" />
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="presence.beanclass.presence"%>
<%@page import="phonebook.webrtc.UserProfile"%>
<%@page import="userprofile.beanclass.friend"%>
<%

%>
<%
    ArrayList<presence> list = new ArrayList<presence>();
    
	list = (ArrayList) request.getAttribute("registrationDetails");

%>
<%
ArrayList<UserProfile> users=(ArrayList<UserProfile>)request.getAttribute("List");
%>

 <!--<link rel="stylesheet" href="css/style.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="css/nivo-slider.css" type="text/css" />
<link rel="stylesheet" href="css/jquery.fancybox-1.3.4.css"
	type="text/css" /> -->
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
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script language="javascript" type="text/javascript">
<!--
function popitup(url) {
	newwindow=window.open(url,'name','height=700,width=700');
	if (window.focus) {newwindow.focus()}
	return false;
}
function callUser(sipname){
	//alert("func called");
	
	var i = document.getElementById("myIframe");
	var str = i.src.toString();
	//alert("before value "+str);
	if(str.indexOf("&ToCallName=")!=-1){
		var n = str.indexOf("&ToCallName=");
		//alert(n);
		str = str.replace(str.substring(n,str.length),"");
		//alert("after value "+str);	
				
	}
	
	//alert("after if value "+str);	
	i.src = str+"&ToCallName="+sipname; 
}
// -->

//function to refresh the page on interval of 10 sec 
 $( document ).ready(function() 
		{ 
	 compressCode();
	var timer = setInterval(compressCode, 90000); 
	}); 

//function to refresj phonebook 
function compressCode(){
	//alert("methodBeingCalled");
	$('#myDiv').load('friendbook.jsp');
}

	//read ip from file 
//	 var ip="10.1.5.3";
 	var ip;
	   function readip()
	   {
	   var pathOfFileToRead = "presentation_server_config.txt";

	   ip = FileHelper.readStringFromFileAtPath
	   	(
	   		pathOfFileToRead
	   	);
	   }

	   function FileHelper()
	   {}
	   {
	   	FileHelper.readStringFromFileAtPath = function(pathOfFileToReadFrom)
	   	{
	   		var request = new XMLHttpRequest();
	   		request.open("GET", pathOfFileToReadFrom, false);
	   		request.send(null);
	   		var returnValue = request.responseText;
	   		return returnValue;
	   	}
	   }
	   readip();  
	 
	  //reda server ip from file end      
	    
function dofriendadd(element) 
{ 

    var xmlHttp = new XMLHttpRequest(); 
    var frinedtobeadded = document.getElementById(element).value;
   // alert("frind to be added "+ frinedtobeadded+ " ip "+ ip);
    xmlHttp.open("GET","http://<%=session.getAttribute("serverip")%>:8080/WebRTC_presentation/FriendListController?action=findFriendURI&friendName="+frinedtobeadded, true);     
    xmlHttp.send(); 
    setTimeout(function(){compressCode();},700);
    
}

function dofriendremove(element) 
{ 
    var xmlHttp = new XMLHttpRequest(); 
    var frinedtoberemoved = document.getElementById(element).innerHTML;
    //var frinedtoberemoved = document.getElementById('friendsipuri').innerHTML;
   // alert("frind to be removed : "+frinedtoberemoved );
    xmlHttp.open("GET","http://<%=session.getAttribute("serverip")%>:8080/WebRTC_presentation/FriendListController?action=removefriend&friendName="+frinedtoberemoved, true);     
    xmlHttp.send(); 
    setTimeout(function(){compressCode();},700);
}
</script>
<div style="width:1000px">
 <!----------------------------------------------------- main ---------------------------->
    <section id="main">
    
			<div style="width:75%; float:left; ">			
		        <table>
		        <tr>
		        <td><iframe src="../sipml5/callim.jsp?
		        ip=<%=session.getAttribute("serverip")%>
		        &name=<%=session.getAttribute("name")%>
		        &privateIdentity=<%=session.getAttribute("privateIdentity")%>
		        &publicIdentity=<%=session.getAttribute("publicIdentity")%>
		        &password=<%=session.getAttribute("password")%>
		        &realm=<%=session.getAttribute("releam")%>" 
		        id="myIframe" frameborder="0" width="700" height="700" align="left" scrolling="no"></iframe>           
		        </td>
		        </tr>
		       </table>
		      </div>



			<!-- adding new frnds   --> 
			 <%-- <form name="myForm" action="<%=request.getContextPath()%>/FriendListController?action=findFriendURI"  method="post"> --%>
			 <form name="addfriendform">      
			        <table>
			         <tr>  
				        <td>
				          <input type="text" name="friendName" id="friendName" placeholder="sip:abc@tcs.com">&nbsp;&nbsp;&nbsp;
				          </td>
				          <td>
				        <input type="button" name="submit" value=" + " onclick="dofriendadd('friendName')">
				        </td>
				        <td>
				        <button onclick='compressCode();'>R<img src="images/iconcycle.png" style="width:5%;height:5%"></button>
				        </td>
			        </tr>
			        </table>
			</form> 
			 <!--  end add new frnd    -->           
 			
 			
 			<div id="myDiv" style="width:25%; float:right; overflow:auto; height:675px;"> 
 
             <!--  div to show the frinds  -->
                     
            </div> 
            
            
        </td>
        <td>
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        
	         <iframe src="http://<%=session.getAttribute("serverip")%>:8080/WebRTCNotifications/Notifier.jsp?user=<%=session.getAttribute("user")%>"  height="100" width="400"  frameborder="0" scrolling="yes"></iframe>       
	        
       
	     <!--    <button><img src="images/iconstar.png"></button>
	        <button><img src="images/icongroup.png"></button> -->
        </td>
        </tr>
        
      </section>
</div>
      <!------------------------------------------ services -------------------------------------------->

 <section id="services" >
 
	<%@include file="services.jsp" %> 
	
   </section>


<div id ="footer-wrap"></div>