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


var arr2;
var arr;//Array Variable declared globally


var xmlHttpRequest;
if(window.XMLHttpRequest)
	{
	xmlHttpRequest=new XMLHttpRequest();
	}
else if(window.ActiveXObject)
	{
	xmlHttpRequest=new ActiveXObject(MICROSOFT.XMLHTTP);
	}
	
	
 function makeSipCall()	//ADD These to the original call javascript
{
	
} 
 
function eraseResponseMessage()
{
	document.getElementById("serverReply").innerHTML="";
	}
	
function endCall()//ADD These to the original hangup javascript
{
	user = document.getElementById("user").value;
	//alert( "user "+user );
	arr=new Array();
	arr[arr.length]=user;
    arr[arr.length]=latitude;
	arr[arr.length]=longitude;
	
	var DateTime=new Date();
	arr[arr.length]=DateTime.getDate();
	arr[arr.length]=DateTime.getTime();

	sendDataToUpload();
}

function sendDataToUpload() //This function makes use of AJAX To Call the Servlet
{
	serverip=document.getElementById("serverip").value;
	//alert( "server ip "+ serverip );
	xmlHttpRequest.open("POST", "http://"+serverip+":8080/Geolocation/GeolocationstoreServlet?sipuri="+arr[0]+"&latitude="+arr[1]+"&longitude="+arr[2]+"&date="+arr[3]+"&time="+arr[4], true);
	xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
	xmlHttpRequest.send();
	
}
function receiveMessageFromServer()
{
	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
		{
		document.getElementById("serverReply").innerHTML=xmlHttpRequest.responseText;
		document.getElementById("HangUp").disabled=true;
		document.getElementById("CALL").disabled=false;
		}
}


    </script>   
    <!-- end geolocation code  -->
    
    
  </head>
  <body>
  
  <H2 style="color: gray;" align="center">Geolocation service</H2>

<table align="center">
<!-- <tr><td></td><td></td></tr>
<tr><td>Sender:</td><td><input type="text" name="caller" id="caller" onfocus="eraseResponseMessage()"></td></tr>
<tr><td>Receiver:</td><td><input type="text" name="callee" id="callee"></td></tr>
<tr><td><br/></td><td><br/></td></tr> -->
<tr>

	<td align="center" ><button id="HangUp" onclick="makeSipCall();endCall()">Share My Location</button></td>
	<td> <input type="text" value=<%=session.getAttribute("user")%> id="user" name="user"> </td>
	<td> <input type="text" value=<%=session.getAttribute("serverip")%> id="serverip" name="serverip" style="display:none"> </td>
	<td> <a href="ViewServlet">View Location of Others </a></td>
</tr>
</table>

<h3 align="center" id="serverReply"></h3>

    <div id="map-canvas"></div>
  </body>
</html>