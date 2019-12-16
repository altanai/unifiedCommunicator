<!DOCTYPE html>
<html>
  <head>
    <title>Geolocation</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <link href="http://code.google.com//apis/maps/documentation/javascript/examples/default.css" rel="stylesheet" type="text/css">

   
   <!-- code for geolocation -->
  <script>
    function initialize() {
    	
    	var friendlatitude=document.getElementById("friendlatitude").value;
    	var friendlongitude=document.getElementById("friendlongitude").value;
    	
    	alert(" lat "+ friendlatitude+ " long "+friendlongitude); 
		  var myLatlng = new google.maps.LatLng(friendlatitude, friendlongitude);
		     
		  var myOptions = {
		        zoom: 8,
		        center: myLatlng,
		        mapTypeId: google.maps.MapTypeId.ROADMAP
		      }
      var map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
      TestMarker(friendlatitude,friendlongitude);
     
    }

    function loadScript() {
      var script = document.createElement("script");
      script.type = "text/javascript";
      script.src = "http://maps.google.com/maps/api/js?sensor=false&callback=initialize";
      document.body.appendChild(script);
    }

    window.onload = loadScript;
    
    
    // Function for adding a marker to the page.
    function addMarker(location) {
        marker = new google.maps.Marker({
            position: location,
            map: map
        });
    }

    // Testing the addMarker function
    function TestMarker(flatitude,flongitude) {
    	alert(" f lat "+ flatitude+ " f long "+flongitude); 
           CentralPark = new google.maps.LatLng(flatitude,flongitude);
           addMarker(CentralPark);
    }

</script>
    <!-- end geolocation code  -->
       
  </head>
  <body>
  
  <H2 style="color: gray;" align="center">Friends Geolocation</H2>

<table align="center">
<tr>
	<td align="center" ><button id="HangUp" onclick="makeSipCall();endCall()">Location</button></td>
	<td> <input type="text" value=<%=request.getParameter("friendlatitude")%> id="friendlatitude" name="friendlatitude"> </td>
	<td> <input type="text" value=<%=request.getParameter("friendlongitude")%> id="friendlongitude" name="friendlongitude"> </td>
	
</tr>
</table>

    <div id="map-canvas"></div>
  </body>
</html>