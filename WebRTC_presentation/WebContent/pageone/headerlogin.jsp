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
    
<%@ include file="google/oauthgooglehead.jsp" %>

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