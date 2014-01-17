var arr;
function validateRegistration(form)
{
var check=false;
arr=new Array();
arr[arr.length]=checkDisplayName("displayName");
arr[arr.length]=checkPublicIdentity("publicIdentity");
arr[arr.length]=checkPrivateIdentity("privateIdentity");
arr[arr.length]=checkPassword("password");
arr[arr.length]=checkRealm("realm");
arr[arr.length]=secretQuestion("secretQuestion");
arr[arr.length]=checkForSecretAnswer("secretAnswer");
for(var i=0;i<arr.length;i++)
{
	if(check==arr[i])
		{
		return false;
		}
	}
return true;
}

function checkForEmpty(stringVal)
{
	if(stringVal==null||stringVal=="")
		{
		return true;
		}
	else 
		return false;
}

function checkDisplayName(elementId)
{
var temp=document.getElementById(elementId).value;
var result;
temp.trim();
result=checkForEmpty(temp);
var displayNameRegex=/^([a-zA-Z ])+(\_\w{1,})*$/;
if(result)
	{
	document.getElementById("nameError").innerHTML="Please enter some text for UserName:";
	temp.focus;
	return false;
	}
else
	{
	if(!displayNameRegex.test(temp))
		{
		document.getElementById("nameError").innerHTML="Invalid format for username:";
		temp.focus;
		return false;
		}
	else document.getElementById("nameError").innerHTML="";	
	}
}
function checkPublicIdentity(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var publicIdentityRegex=/^([a-zA-Z0-9])+(\_\w{1,})*$/;
	if(result)
		{
		document.getElementById("publicIdenError").innerHTML="Please enter some text for PublicIdentity:";
		temp.focus;
		return false;
		}
	else
		{
		if(!publicIdentityRegex.test(temp))
			{
			document.getElementById("publicIdenError").innerHTML="Invalid format for PublicIdentity:";
			temp.focus;
			return false;
			}
		else document.getElementById("publicIdenError").innerHTML="";
		}
}

function checkPrivateIdentity(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var privateIdentityRegex=/^(SIP|sip)\:\w{1,}\@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
	if(result)
		{
		document.getElementById("privateIdenError").innerHTML="Please enter some text for PrivateIdentity:";
		temp.focus;
		return false;
		}
	else
		{
		if(!privateIdentityRegex.test(temp))
			{
			document.getElementById("privateIdenError").innerHTML="Invalid format for SIP URI:";
			temp.focus;
			return false;
			}
		else document.getElementById("privateIdenError").innerHTML="";
		}
	
}

function checkPassword(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	if(result)
		{
		document.getElementById("passwordError").innerHTML="Please enter some text for Password";
		temp.focus;
		return false;
		}
	else document.getElementById("passwordError").innerHTML="";	
		
}

function checkRealm(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var realmRegex=/^([a-zA-Z])+(\.[a-zA-Z]{2,3}){1,2}$/;
	if(result)
		{
		document.getElementById("realmError").innerHTML="Please enter some text for Realm:";
		temp.focus;
		return false;
		}
	else
	{
	if(!realmRegex.test(temp))
		{
		document.getElementById("realmError").innerHTML="Invalid format for Realm:";
		temp.focus;
		return false;
		}
	else
		{
		document.getElementById("realmError").innerHTML="";
		}
	}
}

function secretQuestion(elementId)
{
	var temp=document.getElementById(elementId).value;
	if(temp.match("Select"))
		{
		document.getElementById("quesError").innerHTML="Please select an appropriate Security Question:";
		return false;
		}
	else document.getElementById("quesError").innerHTML="";
}

function checkForSecretAnswer(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	if(result)
	{
	document.getElementById("answerError").innerHTML="Please enter some text for Secret Answer:";	
	temp.focus;
	return false;
	}
	else
		document.getElementById("answerError").innerHTML="";
}
