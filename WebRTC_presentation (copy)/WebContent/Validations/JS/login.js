var arr;
function validateLogin(form)
{
var check=false;
arr=new Array();
arr[arr.length]=checkUserName1("userName");
arr[arr.length]=checkPassword1("password1");
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


function checkUserName1(elementId)
{
var temp=document.getElementById(elementId).value;
var result;
temp.trim();
result=checkForEmpty(temp);
if(result)
	{
	document.getElementById("nameError1").innerHTML="Enter Username";
	temp.focus;
	return false;
	}
else
	{
	document.getElementById("nameError1").innerHTML="";	
	}
}

function checkPassword1(elementId)
{
	var temp=document.getElementById(elementId).value;
	var result;
	temp.trim();
	result=checkForEmpty(temp);
	if(result)
		{
		document.getElementById("passwordError1").innerHTML="Enter Password";
		temp.focus;
		return false;
		}
	else document.getElementById("passwordError1").innerHTML="";	
		
}
