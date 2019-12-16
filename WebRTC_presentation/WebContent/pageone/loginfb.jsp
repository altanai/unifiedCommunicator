<!DOCTYPE html>
<%@page import="com.tcs.css.ThemeSelector"%>
<!--[if IE 7 ]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8 oldie"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html> <!--<![endif]-->

<head>

<!-- themes selecetor code  -->
<%session.setAttribute("themename", "blue");
ThemeSelector ts=new ThemeSelector();
String theme=ts.getTheme(session.getAttribute("themename").toString());%>
<!--  end themes selecetor code  -->

<script type="text/javascript" src="../Validations/JS/newregistration.js" ></script>
<script type="text/javascript" src="../Validations/JS/login.js" ></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <meta name="description" content="">
    <meta name="author" content="">

    <title>WebRTC client </title>
 <link rel="stylesheet" href="css/<%=theme %>" type="text/css" media="screen" />
<!--     <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" /> -->

    <link rel="stylesheet" href="css/nivo-slider.css" type="text/css" />
    <link rel="stylesheet" href="css/jquery.fancybox-1.3.4.css" type="text/css" />

    <!--[if lt IE 9]>
	    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-1.6.1.min.js"><\/script>')</script>

    <script src="js/jquery.smoothscroll.js"></script>
    <script src="js/jquery.nivo.slider.pack.js"></script>
    <script src="js/jquery.easing-1.3.pack.js"></script>
    <script src="js/jquery.fancybox-1.3.4.pack.js"></script>
    <script src="js/init.js"></script>
    
<%-- <%@ include file="google/oauthgooglehead.jsp" %> --%>

</head>

<body>

<!-- header-wrap -->
<div id="header-wrap">
    <header>
<div><img src="images/tcs_logo.png"</div>
        <nav>
            <!--  <ul>
              <li><a href="#main"></a></li>
                <li><a href="#services"></a></li>
                <li><a href="#portfolio"></a></li>
                <li><a href="#about-us"></a></li>
                <li><a href="#styles"></a></li>
                <li><a href="contact.jsp">Contact Us</a></li>
            </ul>-->
            
            <form method="post"  id="loginform" onsubmit="return validateLogin(this);" action="../loginServlet">
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
            
        </nav>

    </header>
</div>

<!-- content-wrap -->
<div class="content-wrap">

    <!-- main -->
    <section id="main" class="clearfix">

<table>
	<tr>
	<td>
	    	 <!-- -----Sign in using fb  -->
		                 <!-- --facebook oauth -->

<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
  FB.init({
    appId      : '144771182399738', // App ID
    channelUrl : '//10.1.5.7:8080/WebRTC_presentation/pageone/login.jsp', // Channel File
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });

  //----------------- event is fired for any authentication related change, such as login, logout or session refresh. 
  FB.Event.subscribe('auth.authResponseChange', function(response) {

    if (response.status === 'connected') {
      testAPI();
    } 
    
    else if (response.status === 'not_authorized') {
      FB.login();
    }
    
    else {
      FB.login();
    }
  });
  };

  //--------------------------------------------- Load the SDK asynchronously
  (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
  }(document));

//----------------------------------------fetch info 
  function testAPI() {
    console.log('WebRTC FACEBBOK ..Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Good to see you, ' + response.name + '.');
      alert("logged in with facebook"+ response.name );
      window.location.href = "http://10.1.5.7:8080/WebRTC_presentation/facebooklogin?userName="response.name;
    });
  }
</script>

<fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>
<!-- ------end facebook oauth --><BR/>
			<!-- end signin -->       
	</td>
	</tr>
	
	<tr>
	<td>
	    	 <!-- -----Sign in using google mid part -->
		   <%--   <%@ include file="google/oauthgooglemid.jsp" %> <BR/> --%>
			<!-- end signin -->       
	</td>
	</tr>
</table>


<table border=1>
  <col width="1000">
  <col width="1000">

	<tr>
		<td>
		<img src="images/slides/images.jpg">
		</td>
		
		<td>          
					<!-- ------Register new user  -->
					<%@ include file="../newaccountforms/registernewuser.jsp" %>
					<!-- end registration --> 
		  
		</td>
	</tr>
</table>      
      

<!-- footer -->
<div id="footer-wrap"></div>

<%-- <%@ include file="footerlogin.jsp" %> --%>
 <!-- -----Sign in using google  -->
<%--  <%@ include file="google/oauthgooglebottom.jsp" %> --%>
<!-- end signin -->  