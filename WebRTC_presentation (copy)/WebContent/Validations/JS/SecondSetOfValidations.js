function validateRegistration(form)
{
arr=new Array();
checkDisplayNameV("displayName");
checkPublicIdentityV("publicIdentity");
checkPrivateIdentityV("privateIdentity");
checkPasswordV("password");
checkRealmV("realm");
secretQuestionV("secretQuestion");
checkForSecretAnswerV("secretAnswer");
if(arr.length>0)
	{
	showErrors();
	return false;
	}
return true;
}

function showErrors()
{
var message="THE FOLLOWING ERRORS WERE REPORTED:\n";
for(var i=0;i<arr.length;i++)
	{
	var numError = i + 1;
	message+= "\n" + numError + ". " +arr[i];
	}
alert(message);
}

function checkDisplayNameV(elementId)
{
var temp=document.getElementById(elementId).value;
var result;
temp.trim();
result=checkForEmpty(temp);
var displayNameRegex=/^([a-zA-Z ])+(\_\w{1,})*$/;
if(result)
	{
	arr[arr.length]="Please Enter some Text for UserName:";
	temp.focus;
	return false;
	}
else
	{
	if(!displayNameRegex.test(temp))
		{
		arr[arr.length]="Invalid format for username:";
		temp.focus;
		return false;
		}
	}
}
function checkPublicIdentityV(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var publicIdentityRegex=/^([a-zA-Z0-9])+(\_\w{1,})*$/;
	if(result)
		{
		arr[arr.length]="Please enter some Text for PublicIndentity:";
		temp.focus;
		return false;
		}
	else
		{
		if(!publicIdentityRegex.test(temp))
			{
			arr[arr.length]="Invalid format for PublicIdentity:";
			temp.focus;
			return false;
			}
		}
}

function checkPrivateIdentityV(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var privateIdentityRegex=/^(SIP|sip)\:\w{1,}\@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
	if(result)
		{
		arr[arr.length]="Please enter some Text for PrivateIndentity:";
		temp.focus;
		return false;
		}
	else
		{
		if(!privateIdentityRegex.test(temp))
			{
			arr[arr.length]="Invalid format for SIP URI:";
			temp.focus;
			return false;
			}
		}
	
}

function checkPasswordV(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	if(result)
		{
		arr[arr.length]="Please enter some Text for Password:";
		temp.focus;
		return false;
		}
}

function checkRealmV(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	var realmRegex=/^([a-zA-Z])+(\.[a-zA-Z]{2,3}){1,2}$/;
	if(result)
		{
		arr[arr.length]="Please enter some Text for Realm:";
		temp.focus;
		return false;
		}
	else
	{
	if(!realmRegex.test(temp))
		{
		arr[arr.length]="Invalid format for Realm:";
		temp.focus;
		return false;
		}
	}
}

function secretQuestionV(elementId)
{
	var temp=document.getElementById(elementId).value;
	if(temp.match("Select"))
		{
		arr[arr.length]="Please select an appropriate Security Question:";
		return false;
		}
}

function checkForSecretAnswerV(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	if(result)
	{
		arr[arr.length]="Please enter some text for Secret Answer:";	
	temp.focus;
	return false;
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