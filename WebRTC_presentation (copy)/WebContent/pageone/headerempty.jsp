<!DOCTYPE html>
<%@page import="com.tcs.css.ThemeSelector"%>
<head>
<!-- themes selecetor code  -->
<%session.setAttribute("themename", "blue");
ThemeSelector ts=new ThemeSelector();
String theme=ts.getTheme(session.getAttribute("themename").toString());%>
<!--  end themes selecetor code  -->

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


<script>
var name=session.getAttribute("name");
var privateIdentity=<%=session.getAttribute("privateIdentity")%>;
var realm=<%=session.getAttribute("releam")%>;

</script>

<script>
<%
	if(session.getAttribute("name")==null)
		response.sendRedirect("login.html");	
%>
</script>

<script type="text/javascript">
    function noBack() { window.history.forward(); }
    noBack();
    window.onload = noBack;
    window.onpageshow = function (evt) { if (evt.persisted) noBack(); }
    window.onunload = function () { void (0); }
    
</script>

</head>

<body>

<!-- header-wrap -->
<div id="header-wrap">
    <header>
     
		 
		   
<div><img src="images/tcs_logo.png"</div>

        <nav>
            <ul>
<!--             <li><a href="home.jsp#main">Home</a></li>
            <li><a href="home.jsp#services">Services</a></li>
              <li><a href="../sipml5/expert.htm" target=newtab>Settings</a></li>  
            <li><a href="mbook.jsp">Message Book</a></li>
             <li><a href="#portfolio"></a></li>
             <li><a href="#about-us"></a></li>
             <li><a href="home.jsp#styles">Offline Messages</a></li>
                <li><a href="home.jsp#contact">Contact Us</a></li>
            <li><a href="../logoutServlet">Logout</a></li> -->

            </ul>
        </nav>

    </header>
</div>
<%-- <!-- <div>

//<%
//	if(session.getAttribute("name")==null)
//		response.sendRedirect("login.html");	
//%>
</div>
--> --%>



<!-- content-wrap -->
<div class="content-wrap">

