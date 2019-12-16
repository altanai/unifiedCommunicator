<!DOCTYPE html>
<%@page import="com.tcs.css.ThemeSelector"%>
<!--[if IE 7 ]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8 oldie"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html>
<!--<![endif]-->

<head>

<!-- themes selecetor code  -->
<%
	session.setAttribute("themename", "blue");
	ThemeSelector ts = new ThemeSelector();
	String theme = ts.getTheme(session.getAttribute("themename")
			.toString());
%>
<!--  end themes selecetor code  -->

<script type="text/javascript"
	src="../Validations/JS/newregistration.js"></script>
<script type="text/javascript" src="../Validations/JS/login.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="description" content="">
<meta name="author" content="">

<title>WebRTC client</title>
<link rel="stylesheet" href="css/<%=theme%>" type="text/css"
	media="screen" />
<!--     <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" /> -->

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

	<!-- header-wrap -->
	<div id="header-wrap">
		<header>
			<div>
				<img src="images/tcs_logo.png"
			</div>
			<nav>
				<%-- <ul>
            <li><a href="home.jsp#main">Home</a></li>
            <li><a href="home.jsp#services">Services</a></li>
              <li><a href="../sipml5/expert.htm" target=newtab>Settings</a></li>  
<!--             <li><a href="mbook.jsp">Message Book</a></li> -->
<!--              <li><a href="#portfolio"></a></li> -->
<!--              <li><a href="#about-us"></a></li> -->
<!--              <li><a href="home.jsp#styles">Offline Messages</a></li>
                <li><a href="home.jsp#contact">Contact Us</a></li> -->
            <li><a href="../logoutServlet">Logout</a></li>

            </ul>--%>

				<%-- <form method="post" action="../loginServlet" id="loginform"
					onsubmit="return validateLogin(this);">
					<table align="right">

						<tr style="height: 0.5;">
							<td style="color: white;">User Name : <input
								name="userName" style="valign: bottom;" type="text"
								id="userName" />&nbsp;&nbsp;&nbsp;
								<!--  <p id="nameError1" style="color: white; font-size: 12px"></p>-->
							</td>
							<td style="color: white">Password : <input name="password"
								type="password" id="password1" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<!--<p id="passwordError1" style="color: white; font-size: 12px"></p>-->
							</td>
							<td align="right"><input type="submit" value="Login"
								class="button"> <!-- <input type="reset" value="Reset" class="button"> -->

							</td>
						</tr>
						<tr>
							<td></td>
							<td valign="top" align="center"><a style="color: black; font-size: 12px"
								href="forgotPassword.jsp">Forgot Your Password</a></td>
							<!--  <td><a href="../sipml5/expert.htm" target=newtab> Settings </a><br/></td> -->
						</tr>
					</table>

				</form>--%>

			</nav>

		</header>
	</div>

	<!-- content-wrap -->
	<div class="content-wrap">