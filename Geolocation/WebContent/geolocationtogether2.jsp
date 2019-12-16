<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.tcs.geolocation.bean.geolocation"%>

  
<%
ArrayList<geolocation> glocationdata=(ArrayList<geolocation>)request.getAttribute("glocationdata");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
         <br/>
         <br/>          
					



			              	
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script> 
<script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script> 
<script type="text/javascript"> 
    $(document).ready(function() { initialize(); });

    function initialize() {
        var map_options = {
            center: new google.maps.LatLng(33.84659,-84.35686),
            zoom: 14,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var google_map = new google.maps.Map(document.getElementById("map_canvas"), map_options);

        var info_window = new google.maps.InfoWindow({
            content: 'loading'
        });

        var t = [];
        var x = [];
        var y = [];
        var h = [];

   </script>



<form action="GeolocationfriendmapServlet">
						<table>
						<tr>
						<th>Name</th>
						<th>Sip URI</th>
						<th>Latitude</th>
						<th>Longitude</th>
						<th>Date</th>
						<th>Time</th>
						
						</tr>
						
						<%
						for (int i = 0; i < glocationdata.size(); i++) {

					    %>
						<tr>
						<td>
								<input type="text" id= "friendName<%=glocationdata.get(i).getFriendName().toString()%>" name="friendName<%=glocationdata.get(i).getFriendName().toString()%>" value=<%=glocationdata.get(i).getFriendName().toString()%>>&nbsp;	
							</td>
							<td>
								<input type="text" id="sipuri<%=glocationdata.get(i).getFriendName().toString()%>" name="sipuri<%=glocationdata.get(i).getFriendName().toString()%>" value=<%=glocationdata.get(i).getSipuri().toString()%>>&nbsp;	
							</td>
					
							<td>
								<input type="text" id="latitude" name="latitude<%=glocationdata.get(i).getFriendName().toString()%>" value=<%=glocationdata.get(i).getLatitude().toString()%>>&nbsp;
							</td>
			          
							<td>
								<input type="text" id="longitude" name="longitude<%=glocationdata.get(i).getFriendName().toString()%>" value=<%=glocationdata.get(i).getLongitude().toString()%>>&nbsp;	
							</td>
					
							<td>
								<input type="text" id="date" name="date" value=<%=glocationdata.get(i).getDate().toString()%>>&nbsp;	
							</td>
				
							<td>
								<input type="text" id="time" name="time" value=<%=glocationdata.get(i).getTime().toString()%>>&nbsp;	
							</td>
							
							<td>
								<input type="submit" name="submit"value="Submit">	
							</td>
						</tr>
						

					
					   <script>     
					        t.push('Location Name 1');
					        x.push(document.getElementById("latitude"));
					        y.push(document.getElementById("longitude"));
					        h.push('<p><strong>Location Name 1</strong><br/>Address 1</p>');	
					
					        
					<%-- 		<%
							for (int i = 0; i < glocationdata.size(); i++) { %>
						        t.push('Location Name 1');
						        x.push(document.getElementById("latitude"));
						        y.push(document.getElementById("longitude<%=glocationdata.get(i).getFriendName().toString()%>"));
						        h.push('<p><strong>Location Name 1</strong><br/>Address 1</p>');	
								
						    <%	}
						    %> --%>
					
					
					/*         t.push('Location Name 2');
					        x.push(33.846253);
					        y.push(-84.362125);
					        h.push('<p><strong>Location Name 2</strong><br/>Address 2</p>'); */
					
					        var i = 0;
					        for ( item in t ) {
					            var m = new google.maps.Marker({
					                map:       google_map,
					                animation: google.maps.Animation.DROP,
					                title:     t[i],
					                position:  new google.maps.LatLng(x[i],y[i]),
					                html:      h[i]
					            });
					
					            google.maps.event.addListener(m, 'click', function() {
					                info_window.setContent(this.html);
					                info_window.open(google_map, this);
					            });
					            i++;
					        }
					    }
					</script> 

					<% } %>
			              </table>
			       </form>
			              	






<div id="map_canvas" style="width:400px;height:400px;">Google Map</div> 
			              	
			         
</body>
</html>