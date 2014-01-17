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
	alert("Please select an image to upload:");
	temp.focus();
	return false;
	}
else
	{
	formatCheck=checkValidImageFormat(tempVal);
	if(!formatCheck)
		{
		alert("Please select JPG,PNG,or GIF image only");
		temp.focus();
		return false;
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
		alert("Please enter the address:");
		temp.focus();
		return false;
		}
	else return true;
	
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
	alert("Please select an audio-file to upload:");
	temp.focus();
	return false;
	}
else
	{
	formatCheck=checkValidAudioFormat(tempVal);
	if(!formatCheck)
		{
		alert("Please select an mp3 or wav audio-file only");
		temp.focus();
		return false;
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
	alert("Please select a video-file to upload:");
	temp.focus();
	return false;
	}
else
	{
	formatCheck=checkValidVideoFormat(tempVal);
	if(!formatCheck)
		{
		alert("Please select an .mp4 .avi or .mkv video-file only");
		temp.focus();
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
//var contactRegex=/^\d{10}$|^\d{2}\-\d{10}$/;
var contactRegex2=/^[1-9]{1}\d{9}$|^\d{2}\-[1-9]{1}\d{9}$/;
if(!contactRegex2.test(tempVal))
	{
		alert("Invalid contact-number please enter a valid contact-number");
		temp.focus();
		return false;
	}
else
	return true;

}

