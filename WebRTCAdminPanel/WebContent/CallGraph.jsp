<%@page import="com.tcs.webrtc.adminpanel.bean.AnalyticsBean"%>
<!-- -----------------------Header Section--------------------- -->

<%@include file="headder.jsp" %>
<title>Call Logs Chart</title>
<script src="<%=request.getContextPath()%>/scripts/Chart.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.jtable.js"></script>
<script src="<%=request.getContextPath()%>/scripts/select2.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/metro/blue/jtable.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/select2.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/start/jquery-ui-1.10.3.custom.css"/>
<script type="text/javascript">
function processFilterRequest()
{
	var temp=document.getElementById("columnName");
	var tempVal=temp.value;
	tempVal.trim();
	if(tempVal.match("MONTH"))
	{
	document.getElementById("yearlyDatepicker").style.display="none";
	document.getElementById("monthlyDatepicker").style.display="inline";
	document.getElementById("sbmitBtn").style.display = "inline";
	}
	if(tempVal.match("YEAR"))
	{
	document.getElementById("yearlyDatepicker").style.display="inline";
	document.getElementById("monthlyDatepicker").style.display="none";
	document.getElementById("sbmitBtn").style.display = "inline";
	}
	if(tempVal.match("SELECT"))
	{			
	document.getElementById("yearlyDatepicker").style.display = "none";
	document.getElementById("monthlyDatepicker").style.display = "none";
	document.getElementById("sbmitBtn").style.display = "none";
	}
}
</script>
</head>
<script>
  $(function() {
    $( "#dialog" ).dialog({
      autoOpen: false,
      show: {
        duration: 1000
      },
      hide: {
        effect: "explode",
        duration: 1000
      }
    });
 
    $( "#canvas" ).click(function() {
      $( "#dialog" ).dialog( "open" );
    });
  
    $( document ).tooltip(); 
  $("#columnName").select2();
  $( "#yearlyDatepicker" ).datepicker({
	  dateFormat: "yy",
	  inline: true,
      changeYear: true
    });
  $( "#monthlyDatepicker" ).datepicker({
	  dateFormat: "M, yy",
	  changeMonth: true,	
	  inline: true
    });
  });
  </script>

<!-- -----------------------Sidemenu Section--------------------- -->

<div style="margin-top: 100px;">

<div style="display:block;margin-left:10px; float: left; height: 900px; margin-right: 20px;">
<jsp:include page="sidemenu.jsp" />
</div>

<%-- <div id="filterContoller" style="padding-left: 200px; padding-right: 200px; padding-top: 50px">
		<form action="AnalyticsServlet" method="post">
		<label style="font-size: 20px;font-style: normal;font-weight: bold;margin-right: 10px">View Graph By:</label>
			<select id="columnName" onchange="processFilterRequest();" style="width: 140px">
				<option value="SELECT">Select</option>
				<option value="MONTH">MONTH</option>
				<option value="YEAR">YEAR</option>
			</select>
			<input type="text" name="month" id="monthlyDatepicker" style="width: 120px; height:26px;display: none;padding-left: 20px" placeholder="Example Jan" title="Please enter the month"/> 
			<input type="text" name="year" id="yearlyDatepicker"   style="width: 120px; height:26px;display: none;padding-left: 20px" placeholder="Example 2013" title="Please enter the year" /> 
			<input type="submit" id="sbmitBtn" value="Submit" title="Click here to submit" style="height: 28px;display: none"/>
			<input type="hidden" value="<%=/* request.getAttribute("sipURI") */"sip:bob@tcs.com" %>" name="sipUri">
		</form>
--%>
<div id="dialog" title="Graph Details">
  <p>This chart displays the total call traffic that WebRTC handels for each month of the current year.<br/>
 
</div>
</div> 
<h2 align="center">Usage Details</h2>


<div id="graphContainer" style="padding-left: 500px;padding-right: 200px;padding-top: 10px">
<canvas id="canvas" height="450" width="500"></canvas>
		<br/><br/>
	 <% 
    	AnalyticsBean analyticsBean=(AnalyticsBean)request.getAttribute("analyticsBean");
   	 %>  
	<script type="text/javascript">
	
		
	 var arr1 = new Array(<%int[] arr=new int[12];
	    			arr=analyticsBean.getIncomingCall();
				    for(int i = 0; i < arr.length; i++) {  
				      out.print("\""+arr[i]+"\"");  
				      if(i+1 < arr.length) {  
				        out.print(",");  
				      }  
				    }  %>);
	 var arr2 = new Array(<%int[] arr1=new int[12];
		arr1=analyticsBean.getOutgoingCall();
	    for(int i = 0; i < arr1.length; i++) {  
	      out.print("\""+arr1[i]+"\"");  
	      if(i+1 < arr1.length) {  
	        out.print(",");  
	      }  
	    }  %>); 

		var lineChartData = {
				labels : ["January","February","March","April","May","June","July","August","September","October","November","December"],
				datasets : [
					{
						fillColor : "rgba(220,220,220,0.5)",
						strokeColor : "rgba(220,220,220,1)",
						pointColor : "rgba(220,220,220,1)",
						pointStrokeColor : "#fff",
						data :arr1
					},
					{
						fillColor : "rgba(151,187,205,0.5)",
						strokeColor : "rgba(151,187,205,1)",
						pointColor : "rgba(151,187,205,1)",
						pointStrokeColor : "#fff",
						data :arr2
					}
				]

			};
		var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Line(lineChartData);
	</script>
	
    <input type="submit" name="submit" value="" style="background-color:#87AFC7;"> : WebRTC Usage
</div>
</div>
