function checkDisplayName(elementId)
{
var input=document.getElementById(elementId);
var temp=document.getElementById(elementId).value;
var result;
temp.trim();
result=checkForEmpty(temp);
var displayNameRegex=/^([a-zA-Z0-9 ])+(\_\w{1,})*$/;
if(result)
	{
	alert("Please enter some Text for UserName:");
	input.focus();
	return false;
	}
else
	{
	if(!displayNameRegex.test(temp))
		{
		alert("Invalid format for username:");
		input.focus();
		return false;
		}
	}
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
function checkPublicIdentity(elementId)
{
	var input=document.getElementById(elementId);
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var publicIdentityRegex=/^([a-zA-Z0-9])+(\_\w{1,})*$/;
	if(result)
		{
		alert("Please enter some text for PublicIdentity:");
		input.focus();
		return false;
		}
	else
		{
		if(!publicIdentityRegex.test(temp))
			{
			alert("Invalid format for PublicIdentity:");
			input.focus();
			return false;
			}
		}
}

function checkPrivateIdentity(elementId)
{
	var input=document.getElementById(elementId);
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var privateIdentityRegex=/^(SIP|sip)\:\w{1,}\@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
	if(result)
		{
		alert("Please enter some text for PrivateIdentity:");
		input.focus();
		return false;
		}
	else
		{
		if(!privateIdentityRegex.test(temp))
			{
			alert("Invalid format for SIP URI:");
			input.focus();
			return false;
			}
		}
	
}

function checkPassword(elementId)
{
	var input=document.getElementById(elementId);
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	if(result)
		{
		alert("Please enter some text for Password");
		input.focus();
		return false;
		}
}

function checkRealm(elementId)
{
	var input=document.getElementById(elementId);
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var realmRegex=/^([a-zA-Z])+(\.[a-zA-Z]{2,3}){1,2}$/;
	if(result)
		{
		alert("Please enter some text for Realm:");
		input.focus();
		return false;
		}
	else
	{
	if(!realmRegex.test(temp))
		{
		alert("Invalid format for Realm:");
		input.focus();
		return false;
		}
	}
}

function secretQuestion(elementId)
{
	var temp=document.getElementById(elementId).value;
	if(temp.match("Select"))
		{
		alert("Please select an appropriate Security Question:");
		return false;
		}
}

function checkForSecretAnswer(elementId)
{
	var input=document.getElementById(elementId);
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	if(result)
	{
	alert("Please enter some text for Secret Answer:");	
	input.focus();
	return false;
	}
}
