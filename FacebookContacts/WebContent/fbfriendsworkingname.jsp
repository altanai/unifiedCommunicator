<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
        <title> 'FbFriends'</title>
        <script src="http://connect.facebook.net/en_US/all.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <!--<link rel="stylesheet" type="text/css" href="styles.css">-->
  </head>
    <body>
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
        htmlcontent='<br/>   <img src='+response[0].pic_square+' />  title='+response[0].name+'  ';

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
        
  </body>
</html>