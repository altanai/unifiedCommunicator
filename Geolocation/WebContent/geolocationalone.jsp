<!DOCTYPE html>
<html>
  <head>
    <title>Geolocation</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <link href="http://code.google.com//apis/maps/documentation/javascript/examples/default.css" rel="stylesheet" type="text/css">

   
   <!-- code for geolocation -->
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true"></script>

    <script>
    var arr;
    var latitude;
    var longitude;
    var map;
    var serverip;
    var user;

function initialize() {
	
	//alert("maps initialised 2 ");
	
  var mapOptions = {
    zoom: 6,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  // Try HTML5 geolocation
  if(navigator.geolocation) {
    
	  navigator.geolocation.getCurrentPosition(function(position) {
      
		//  alert(" lat:  "+position.coords.latitude+" long: "+ position.coords.longitude);
		  
      
		  latitude=position.coords.latitude;
		  longitude=position.coords.longitude;
		  
		  var pos = new google.maps.LatLng(position.coords.latitude,
                                       position.coords.longitude);
      

      var infowindow = new google.maps.InfoWindow({
        map: map,
        position: pos,
        content: 'current location'
      });

      map.setCenter(pos);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleNoGeolocation(false);
  }
  
  
}

function handleNoGeolocation(errorFlag) {
  if (errorFlag) {
    var content = 'Error: The Geolocation service failed.';
  } else {
    var content = 'Error: Your browser doesn\'t support geolocation.';
  }

  var options = {
    map: map,
    position: new google.maps.LatLng(60, 105),
    content: content
  };

  var infowindow = new google.maps.InfoWindow(options);
  map.setCenter(options.position);
}

google.maps.event.addDomListener(window, 'load', initialize);




    </script>   
    <!-- end geolocation code  -->
    
    
  </head>
  <body>


    <div id="map-canvas"></div>
  </body>
</html>