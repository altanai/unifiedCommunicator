var isAWhiteUser;
var isABlackUser;
var isDNDTime;
var calllerUri;


function checkForWhiteUser(callerName)
{	
	 calllerUri=callerNmae.replace("<","");
	callerUri=callerUri.replace(">","");
	xmlHttpRequest.open("GET","http://"+serverip+":8080/AjaxScreenerServlet?caller="+callerUri+"&action=chkWhiteUsers",true);
	xmlHttpRequest.onReadyStateChage=responseForwhiteUser;
	xmlHttpRequest.send();
}

function responseForwhiteUser()
{
	if(xmlHttpRequest.readyState==4 && xmlHttpRequest.status==200)
		isAWhiteUser=(xmlHttpRequest.getResponseText);
} 


function checkForBlackUser(callerName)
{	
	 calllerUri=callerNmae.replace("<","");
	callerUri=callerUri.replace(">","");
	xmlHttpRequest.open("GET","http://"+serverip+":8080/AjaxScreenerServlet?&caller="+callerUri+"&action=chkBlackUsers",true);
	xmlHttpRequest.onReadyStateChage=responseForBlackUser;
	xmlHttpRequest.send();
}

function responseForBlackUser()
{
	if(xmlHttpRequest.readyState==4 && xmlHttpRequest.status==200)
		isABlackUser=(xmlHttpRequest.getResponseText);
}

function checkDNDTime()
{	
	xmlHttpRequest.open("GET","http://"+serverip+":8080/AjaxScreenerServlet?action=chkDndValues",true);
	xmlHttpRequest.onReadyStateChage=responseForDNDTime;
	xmlHttpRequest.send();
}

function responseForDNDTime()
{
	if(xmlHttpRequest.readyState==4 && xmlHttpRequest.status==200)
		isDNDTime=(xmlHttpRequest.getResponseText);
}