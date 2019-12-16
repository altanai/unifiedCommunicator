var error;
function validateMoreDetails()
{
	error=new Array();
	var check=false;
	error[error.length]=checkForAddress("Address");
	error[error.length]=checkContactNumber("Contact");
	error[error.length]=checkUploadedPic("picture");
	error[error.length]=checkUploadedAudio("audio");
	error[error.length]=checkUploadedVideo("video");
	for(var i=0;i<error.length;i++)
	{
		if(check==error[i])
			{
			return false;
			}
	}
	return true;
}

function checkUploadedPic(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
tempVal.trim();
var nullCheck;
var formatCheck;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	document.getElementById("imageError").innerHTML="Please select an image to upload:";
	return false;
	}
else
	{
	formatCheck=checkValidImageFormat(tempVal);
	if(!formatCheck)
		{
		document.getElementById("imageError").innerHTML="Please select JPG,PNG,or GIF image only";
		return false;
		}
	else 
		{
		document.getElementById("imageError").innerHTML="";
		return true;
		}
	}
}

function checkForAddress(elementId)
{
	var temp=document.getElementById(elementId);
	var tempVal=temp.value;
	tempVal.trim();
	var nullCheck;
	nullCheck=checkForEmpty(tempVal);
	if(nullCheck)
		{
		document.getElementById("addressError").innerHTML="Please enter the address:";
		return false;
		}
	else 
		{
		document.getElementById("addressError").innerHTML="";
		return true;
		}
	
}

function checkUploadedAudio(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
tempVal.trim();
var nullCheck;
var formatCheck;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	document.getElementById("audioError").innerHTML="Please select an audio-file to upload:";
	temp.focus();
	return false;
	}
else
	{
	formatCheck=checkValidAudioFormat(tempVal);
	if(!formatCheck)
		{
		document.getElementById("audioError").innerHTML="Please select an mp3 or wav audio-file only";
		return false;
		}
	else
		{
		document.getElementById("audioError").innerHTML="";
		return true;
		}
	}
}

function checkUploadedVideo(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
tempVal.trim();
var nullCheck;
var formatCheck;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	document.getElementById("videoError").innerHTML="Please select a video-file to upload:";
	return false;
	}
else
	{
	formatCheck=checkValidVideoFormat(tempVal);
	if(!formatCheck)
		{
		document.getElementById("videoError").innerHTML="Please select an .mp4 .avi or .mkv video-file only";
		return false;
		}
	else 
		{
		document.getElementById("videoError").innerHTML="";
		return true;
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

function checkValidImageFormat(stringVal)
{
	var ext = stringVal.substring(stringVal.lastIndexOf('.') + 1);
	if(ext == "gif" || ext == "GIF" || ext == "JPEG" || ext == "jpeg" || ext == "jpg" || ext == "JPG" || ext == "PNG" || ext== "png")
	{
	return true;
	} 
	else
		return false;
	
}

function checkValidAudioFormat(stringVal)
{
	var ext = stringVal.substring(stringVal.lastIndexOf('.') + 1);
	if(ext == "mp3" || ext == "MP3" || ext == "wav" || ext == "WAV")
	{
	return true;
	} 
	else
		return false;
	
}
function checkValidVideoFormat(stringVal)
{
	var ext = stringVal.substring(stringVal.lastIndexOf('.') + 1);
	if(ext == "mp4" || ext == "MP4" || ext== "avi" || ext== "AVI" || ext== "mkv" || ext== "MKV")
	{
	return true;
	} 
	else
		return false;
}

function checkContactNumber(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
tempVal.trim();
var nullCheck;
var contactRegex2=/^[1-9]{1}\d{9}$|^\d{2}\-[1-9]{1}\d{9}$/;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	document.getElementById("contactError").innerHTML="Please enter a contact-number:";
	return false;
	}
else
{
if(!contactRegex2.test(tempVal))
	{
	document.getElementById("contactError").innerHTML="Invalid contact-number please enter a valid contact-number";
		temp.focus();
		return false;
	}
else
	{
	document.getElementById("contactError").innerHTML="";
	return true;
	}
}

}

