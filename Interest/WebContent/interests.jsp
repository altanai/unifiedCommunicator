<!DOCTYPE html>
<!--[if IE 7 ]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8 oldie"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html> <!--<![endif]-->
    <%@ page import="java.util.*" %> 
    <%@ page import="com.tcs.webrtc.interest.dao.*" %> 
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <meta name="description" content="">
    <meta name="author" content="">

    <title>WebRTC Interests</title>

    <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
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

</head>

<body>



<!-- content-wrap -->
<div class="content-wrap">

    <!-- main -->
    <section id="main">

        <div class="intro-box">
           <h1>Interest.</h1>

           <p class="intro">Filtered out interest from the user information source base .</p>

        
        </div>

        <div class="slider-wrapper">

            <div id="slider" class="nivoSlider">
                <img src="images/slides/slide1.png" width="383" height="198" alt="" />
                <img src="images/slides/slide2.png" width="383" height="198" alt="" />
                <img src="images/slides/slide3.png" width="383" height="198" alt="" title="#htmlcaption"/>
            </div>
      </div>

        <div class="row no-bottom-margin">


<%
InterestDao intdao=new InterestDao();
Map<String, String> map=intdao.getallinterests("sip:akbar@tcs.com");

for (Map.Entry<String, String> entry : map.entrySet())
{
  //  System.out.println(entry.getKey() + "/" + entry.getValue());
  
  %>
   
   Interest Scope : <%=entry.getKey() %>  &nbsp; Value: <%=entry.getValue() %> </br>
   
  
  <%
}
%>

            <section class="col">
                <h2>Personal Interests </h2>

                <p>.....</p>
            </section>
            <section class="col mid">
                <h2>Professional / Academic Interests </h2>

                <p>.....</p>
            </section>

            <section class="col">
                <h2>Circle Inetrests </h2>

                <p>....</p>
            </section>
        </div>

      </section>

    
      <!-- portfolio -->
      <section id="portfolio">

            <h1>Featured works.</h1>

            <ul class="folio-list clearfix">

                <li class="folio-thumb">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/milk.jpg" title="Milk Splashes" ><img src="images/thumbs/milk.jpg" alt="" /> </a>
                    </div>
                    <h3 class="entry-title">Milk Splashes</h3>
                </li>

                <li class="folio-thumb last">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/hexagon.jpg" title="Hexagon Bokeh"><img src="images/thumbs/hexagon.jpg" alt="" /> </a>
                    </div>
                    <h3 class="entry-title">Hexagon Bokeh</h3>
                </li>

                <li class="folio-thumb">
                    <div class="thumb">
                        <a class="lightbox-video" href="http://www.youtube.com/watch?v=EPXwP8D5C5c&feature=player_embedded"><img src="images/thumbs/hillsong-united-aftermath.jpg" alt="" /></a>
                    </div>
                    <h3 class="entry-title">Aftermath (Sample Video)</h3>
                </li>
                <li class="folio-thumb">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/dandelion.jpg" title="Dandelion" ><img src="images/thumbs/dandelion.jpg" alt="" /> </a>
                    </div>
                    <h3 class="entry-title">Dandelion</h3>
                </li>

                <li class="folio-thumb">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/eiffel.jpg" title="Eiffel Tower"><img src="images/thumbs/eiffel.jpg" alt="" /> </a>
                    </div>
                    <h3 class="entry-title">Eiffel Tower</h3>
                </li>

                 <li class="folio-thumb last">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/clouds-and-rainbow.jpg" title="Clouds &amp; Rainbow"><img src="images/thumbs/clouds-and-rainbow.jpg" alt="" /> </a>
                    </div>
                    <h3 class="entry-title">Clouds &amp; Rainbow</h3>
                </li>

                <li class="folio-thumb">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/landscape.jpg" title="Rural Landscape"><img src="images/thumbs/landscape.jpg" alt=""  /> </a>
                    </div>
                    <h3 class="entry-title">Rural Landscape</h3>
                </li>

                <li class="folio-thumb">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/sneakers.jpg" title="Cosmic Sneakers"><img src="images/thumbs/sneakers.jpg" alt="" /> </a>
                    </div>
                    <h3 class="entry-title">Cosmic Sneakers</h3>
                </li>

                 <li class="folio-thumb last">
                    <div class="thumb">
                        <a class="lightbox" href="images/thumbs/big/vector-flower-fullscreen.jpg" title="Abstract Vectors"><img src="images/thumbs/vector-flower-fullscreen.jpg" alt="" /> </a>
                    </div>
                    <h3 class="entry-title">Abstract Vector</h3>
                </li>

            </ul>

         

      </section>

    



</body>
</html>
