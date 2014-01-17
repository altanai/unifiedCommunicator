<%@page import="com.tcs.webrtc.bean.AnalyticsBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Call Logs Chart</title>
<script src="scripts/Chart.js"></script>
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
<script src="<%=request.getContextPath()%>/scripts/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="<%=request.getContextPath()%>/scripts/jquery.jtable.js"></script>
<script src="<%=request.getContextPath()%>/scripts/select2.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/metro/blue/jtable.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery-smoothness-theme/jquery-ui-1.10.3.custom.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/select2.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/start/jquery-ui-1.10.3.custom.css"/>
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
	  changeYear: true,
	  inline: true
    });
  $( "#monthlyDatepicker" ).datepicker({
	  dateFormat: "M, yy",
	  changeMonth: true,
	  inline: true
    });
  });
  </script>
  </head>
<body>
	<div id="filterContoller" style="padding-left: 20px; padding-right: 20px; padding-top: 50px">
		<form action="<%=request.getContextPath() %>/AnalyticsServlet" method="post">
		<label style="font-size: 20px;font-style: normal;font-weight: bold;margin-right: 10px">View Graph By:</label>
			<select id="columnName" name="columnName" onchange="processFilterRequest();" style="width: 140px">
				<option value="SELECT">Select</option>
				<option value="MONTH">MONTH</option>
				<option value="YEAR">YEAR</option>
			</select> 
			<select id="filterByMonth" style="width: 120px;display: none">
				<option value="">Select-Month</option>
				<option value="Jan">JANUARY</option>
				<option value="Oct">OCTOBER</option>
			</select>
			 <select id="filterByYear" style="width: 120px;display: none">
				<option>Select-Year</option>
				<option value="Jan">2013</option>
			</select>
			<input type="text" name="month" id="monthlyDatepicker" placeholder="Example Jan" title="Please enter the month" style="width: 100px; height:24px;display: none;padding-left: 20px"/> 
			<input type="text" name="year" id="yearlyDatepicker" placeholder="Example 2013" title="Please enter the year" style="width: 100px; height:24px;display: none;padding-left: 20px"/> 
			<input type="submit" id="sbmitBtn" value="Submit" title="Click here to submit" style="height: 28px;display: none"/>
			<input type="hidden" value="<%=request.getAttribute("sipUri") %>" name="sipUri">
		</form>

		<div id="dialog" title="Graph Details">
			<p>
				This chart displays the outgoing calls and incoming calls for a
				particular user for each day of the month.<br /> 1.Outgoing call are
				shown in faded blue color<br />2.Incoming calls are shown in grey
				color.
			</p>
		</div>

	</div>

	<div id="graphContainer" style="padding-left: 20px;padding-right: 20px;padding-top: 50px">
		<canvas id="canvas" height="450" width="500"></canvas>
		<br/><br/>
    
	<% 
    	AnalyticsBean analyticsBean=(AnalyticsBean)request.getAttribute("analyticsBean");
    
    %>
	
	<script type="text/javascript">
	
		
	 var arr1 = new Array(<%String[] arr=new String[analyticsBean.getMonthlyIncomingCalls().size()];
	    			arr=analyticsBean.getMonthlyIncomingCalls().toArray(arr);
				    for(int i = 0; i < arr.length; i++) {
				      out.print("\""+arr[i]+"\"");  
				      if(i+1 < arr.length) {  
				        out.print(",");  
				      }  
				    }  %>);
	 var arr2 = new Array(<%String[] arr1=new String[analyticsBean.getMonthlyOutgoingCalls().size()];
		arr1=analyticsBean.getMonthlyOutgoingCalls().toArray(arr1);
	    for(int i = 0; i < arr1.length; i++) { 
	      out.print("\""+arr1[i]+"\"");  
	      if(i+1 < arr1.length) {  
	        out.print(",");  
	      }  
	    }  %>);
	 
	 var arrLabel = new Array(<%String[] arrLabel=new String[analyticsBean.getLabels().size()];
		arrLabel=analyticsBean.getLabels().toArray(arrLabel);
	    for(int i = 0; i < arrLabel.length; i++) {  
	      out.print("\""+arrLabel[i]+"\"");  
	      if(i+1 < arrLabel.length) {  
	        out.print(",");  
	      }  
	    }  %>);
	
		
		var lineChartData = {
				labels :arrLabel,
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
	<input type="submit"  value="" style="background-color:#87AFC7;"> : Outgoing Calls
    <input type="submit"  value="" style="background-color:#D1D0CE;"> : Incoming Calls
</div>
</body>
</html>