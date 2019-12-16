
    <%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
        <title> 'FbFriends'</title>
        <script src="http://connect.facebook.net/en_US/all.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<script type="text/javascript">
var arr;  //Array Variable declared globally
var xmlHttpRequest;
if(window.XMLHttpRequest)
	{
	xmlHttpRequest=new XMLHttpRequest();
	}
else if(window.ActiveXObject)
	{
	xmlHttpRequest=new ActiveXObject(MICROSOFT.XMLHTTP);
	}
function makeSipCall()	//ADD These to the original call javascript
{	
	arr=new Array(); 
	arr[arr.length]=document.getElementById("caller").value;
	arr[arr.length]=document.getElementById("callee").value;
	var startTime=new Date();
	arr[arr.length]=startTime.getTime();
	document.getElementById("HangUp").disabled=false;
	document.getElementById("CALL").disabled=true;
}
function eraseResponseMessage()
{
	document.getElementById("serverReply").innerHTML="";
	}
	
function endCall()//ADD These to the original hangup javascript
{
	var endTime=new Date();
	arr[arr.length]=endTime.getTime();
	document.getElementById("caller").value="";
	document.getElementById("callee").value="";
	sendDataToUpload();
}

function sendDataToUpload() //This function makes use of AJAX To Call the Servlet
{
	xmlHttpRequest.open("POST", "SipCallLogServlet?caller="+arr[0]+"&callee="+arr[1]+"&startTime="+arr[2]+"&endTime="+arr[3], true);
	xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
	xmlHttpRequest.send();
}
function receiveMessageFromServer()
{
	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
		{
		document.getElementById("serverReply").innerHTML=xmlHttpRequest.responseText;
		document.getElementById("HangUp").disabled=true;
		document.getElementById("CALL").disabled=false; 
		}
}
function validateCaller(elementId)
{
	var temp=document.getElementById(elementId);
	var tempVal=temp.value;
	tempVal.trim();
	if(tempVal==null||tempVal=="")
		{
			alert("Please enter the name of the caller");
			temp.focus();
			return false;
		}
	else return true;
}
function validateCallee(elementId)
{
	var temp=document.getElementById(elementId);
	var tempVal=temp.value;
	tempVal.trim();
	if(tempVal==null||tempVal=="")
		{
			alert("Please enter the name of the callee");
			temp.focus();
			return false;
		}
	else return true;
}
</script>

</head>

<body>
<H2 style="color: gray;" align="center">Finding Facebook Friends</H2>
<br/><br/>
	
	
	     <div id="fb-root"></div>
   <script src="http://connect.facebook.net/en_US/all.js#appId=229823833732087&amp;xfbml=1"></script>
<fb:login-button autologoutlink="true" scope="email,publish_stream,offline_access,friends_birthday,friends_location,friends_photos,friends_about_me,read_friendlists,read_friendlists,friends_hometown,user_location,user_hometown,user_website,user_birthday,user_groups,friends_groups,user_online_presence" size="large"></fb:login-button>
 <script>
  
        FB.init({
        
        appId  : '144771182399738',
         status : true, // check login status
        cookie : true, // enable cookies to allow the server to access the session
        xfbml  : true  // parse XFBML
        
        });
        
        FB.getLoginStatus(function(response) {
        if (response.authResponse) {
        //getting current logged in user's id from session object
        var globaluserid=response.authResponse.userID;
        
        //fetching friends uids from 'friend' table. We are using FB.api syntax
        
        FB.api(
        
        {
        method: 'fql.query',
        query: 'SELECT uid2 FROM friend WHERE uid1='+globaluserid
        },
        
        function(response) {
        //once we get the response of above select query we are going to parse them
        for(i=0;i<response.length;i++)
        {
        //fetching name and square profile photo of each friends
        FB.api(
        {
        method: 'fql.query',
        query: 'SELECT name,pic_square FROM user WHERE uid='+response[i].uid2
        },
        function(response) {
        //creating img tag with src from response and title as friend's name
        htmlcontent='<br/>   <img src='+response[0].pic_square+' />  '+response[0].name+'  ';

        //appending to div based on id. for this line we included jquery
         $("#friendslist").append(htmlcontent);
   
         }
        
        );
        
        }
        
        }
        
        );
        
        } 
        
        });
        
        </script>
       <div id="fb-root"> </div>
       
        <table width="100%" border="0">
          <tr>
             <td align="left">
                 <div id="friendslist"> Invite Friends from Facebook to WebRTC </div>
             </td>
          </tr>
        </table>
        
	
	
	<table align="center">
	<tr><td></td><td></td></tr>
	<tr><td>Sender:</td><td><input type="text" name="caller" id="caller" onfocus="eraseResponseMessage()"></td></tr>
	<tr><td>Receiver:</td><td><input type="text" name="callee" id="callee"></td></tr>
	<tr><td><br/></td><td><br/></td></tr>
	<tr><td align="center"><button id="CALL" onclick="makeSipCall()">CALL</button></td><td><button id="HangUp" disabled="disabled" onclick="endCall()">HANGUP</button></td></tr>
	</table>
<h3 align="center" id="serverReply"></h3>
</body>
</html>