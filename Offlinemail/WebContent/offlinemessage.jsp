<%@include file="headerservice.jsp"%>

<section id="main">
<form method="post" action="messageServlet">
<div>

		<div  style="float:left">To : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
	
		<div><input type="text" name="sipurireceiver" id="sipurireceiver" value="<%=session.getAttribute("toAddress")%>"/> </div>
		
	</div>

		<div  style="float:left">Message : </div>
		<div> <textarea id="message" name="message" rows="6" cols="30" style="background-color:white;"></textarea></div>

	

	

<br/>


Send Message via Gmail : <input type="submit" name="submit" value="Send_to_gmail">
<img src="socialmediaimages/1382540053_Android-Gmail.png" width="40" height="40"></input>
<br/>
Send Message via Facebook : <input type="submit" name="submit" value="Send_to_facebook">
<img src="socialmediaimages/1382539943_facebook_02.png" width="40" height="40"></input> 
<br/>
Send Message via Yahoo : <input type="submit" name="submit" value="Send_to_yahoo">
<img src="socialmediaimages/1382540139_picons14.png" width="40" height="40"></input> 
<br/>
<!-- Send Message via Twitter : <input type="submit" name="submit" value="Send_to_twitter">
<img src="socialmediaimages/1382539984_social_8.png" width="40" height="40"></input>  -->


</form>


</section>
</body>
</html>
<div id="footer-wrap"></div>
