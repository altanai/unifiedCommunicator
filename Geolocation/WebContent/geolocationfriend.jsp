<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Simple markers</title>
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
function initialize() {
	
	var friendlatitude=document.getElementById("friendlatitude").value;
	var friendlongitude=document.getElementById("friendlongitude").value;
	
	//alert(" lat "+ friendlatitude+ " long "+friendlongitude); 
	
  //var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
   var myLatlng = new google.maps.LatLng(friendlatitude, friendlongitude);
   
  var mapOptions = {
    zoom: 4,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: 'My Location!'
  });
  
  var myLatlng2 = new google.maps.LatLng(-25.363882,131.044922);
  var marker2 = new google.maps.Marker({
      position: myLatlng2,
      map: map,
      title: 'Friend Location!'
  });
  
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
    <H2 style="color: gray;" align="center">Friends Geolocation</H2>

<table align="center">
<tr>
<!-- 	<td align="center" ><button id="HangUp" onclick="makeSipCall();endCall()">Location</button></td> -->
	<td> <input type="text" value=<%=request.getParameter("friendName")%> id="friendName" name="friendName"></td>
	<td> <input type="text" value=<%=request.getParameter("friendlatitude")%> id="friendlatitude" name="friendlatitude"> </td>
	<td> <input type="text" value=<%=request.getParameter("friendlongitude")%> id="friendlongitude" name="friendlongitude"> </td>
	
</tr>
</table>
    <div id="map-canvas"></div>
  </body>
</html>