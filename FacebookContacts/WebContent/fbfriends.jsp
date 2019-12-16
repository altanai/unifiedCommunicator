
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



</head>

<body>
<H2 style="color: gray;" align="center">Finding Facebook Friends</H2>
<br/><br/>
	
	
	     <div id="fb-root"></div>
   <script src="http://connect.facebook.net/en_US/all.js#appId=229823833732087&amp;xfbml=1"></script>
<fb:login-button autologoutlink="true" scope="email,publish_stream,offline_access,friends_birthday,friends_location,friends_photos,friends_about_me,
read_friendlists,read_friendlists,friends_hometown,user_location,user_hometown,user_website,user_birthday,user_groups,friends_groups,user_online_presence" size="large"></fb:login-button>
 <script>
  
 var arr= new Array(); //Array Variable declared globally
 var xmlHttpRequest;   
 var i=0;
 
 
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
        	//alert( "rspone.name" + response[0].name);
        	//arr[arr.length] = response[0].name;
        	//alert(" myarray "+ arr[arr.length]);
        //creating img tag with src from response and title as friend's name
       // htmlcontent='<br/>   <img src='+response[0].pic_square+' id="link" title='+response[0].name+'/>  '+response[0].name+' ';
        document.write(' </br><img src='+response[0].pic_square+' id="link" title='+response[0].name+'/>  '+response[0].name+' ');
       
       // sendDataToUpload(response[0].name);
      sendDataToUpload(response[0].name);
        
        //appending to div based on id. for this line we included jquery
        // $("#friendslist").append(htmlcontent); 
        
        
/*          htmlcontenet2=' <input type='text' name='name' id='name' value='+response[0].name+' /> '; 
         $("#friendslist").append(htmlcontent2); */
         
         }
        
        );
        
        }
        
        }
        
        );
        
        } 
        
        });
        

        

        if(window.XMLHttpRequest)
        	{
        	xmlHttpRequest=new XMLHttpRequest();
        	}
        else if(window.ActiveXObject)
        	{
        	xmlHttpRequest=new ActiveXObject(MICROSOFT.XMLHTTP);
        	}

        function eraseResponseMessage()
        {
        	document.getElementById("serverReply").innerHTML="";
        	}
        	
/*         function endCall()//ADD These to the original hangup javascript
        {
        	arr=new Array(); 
        	arr[arr.length]=document.getElementById("friendlist").innerHTML;
        	sendDataToUpload();
        } */

        function sendDataToUpload(name) //This function makes use of AJAX To Call the Servlet
        {
        	xmlHttpRequest.open("GET", "facebookcontacts?fbfriendname="+name, true);
        	xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
        	xmlHttpRequest.send();
        }

        function receiveMessageFromServer()
        {
        	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
        		{
        		
	        		if(xmlHttpRequest.responseText.match('sip:') ){
	        			//document.write('<input type="text" readonly="true" value="'+xmlHttpRequest.responseText+'" id="check" name="check">');
	        			document.write('<p style="color:blue"> '+xmlHttpRequest.responseText+'</p>');
	        			document.write('<input type="button" onlcick="dofriendadd('+xmlHttpRequest.responseText+');" value ="Add the friend to Friendlist">');

	        		}
	        		else{
	        	//	document.getElementById("serverReply").innerHTML=xmlHttpRequest.responseText;
	        		//   document.write('<input type="text" readonly="true" value="'+xmlHttpRequest.responseText+'" id="check" name="check">');
	        		//	document.write('<p style="color:orange"> '+xmlHttpRequest.responseText+'</p>');
	        			document.write(' -- '+xmlHttpRequest.responseText+' --');
	        		}
        		}
        }

        function dofriendadd(element) 
        { 
            var ip=<%=session.getAttribute("serverip")%>;
            var xmlHttp = new XMLHttpRequest(); 
            var frinedtobeadded = element;
            alert("frind to be added "+ frinedtobeadded+ " ip "+ ip);
            
            alert("ip= "+ip +" : rinedtobeadded= "+ rinedtobeadded);
            xmlHttp.open("GET","http://"+ip+":8080/WebRTC_presentation/FriendListController?action=findFriendURI&friendName="+frinedtobeadded, true);     
            xmlHttp.send(); 
           // setTimeout(function(){compressCode();},700);
            
        }
        
        
        
        </script>
       
        <h4>Click on Show button to find out which friends have already an account on WebRTC</h4> 
       <div id="fb-root"> </div>
       
    <!--    <button id="HangUp"  onclick="endCall()">Show who all are on WebRTC</button> -->
       
        <table width="100%" border="0">
          <tr>
            <td align="left">
                  
                      <!--   <div id="friendslist"> Invite Friends from Facebook to WebRTC </div> -->
                      <!-- <input type="text" value="" id="name" name="name"> -->
                 
             </td> 
             <td>
                        <!-- <h3 align="center" id="serverReply"></h3> -->
             </td>

             <td>
                 
             </td>
          </tr>
        </table>
        
	

     

<h3 align="center" id="serverReply"></h3>
</body>
</html>