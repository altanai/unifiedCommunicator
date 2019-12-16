var arr;
function validateMoreDetails()
{
arr=new Array();	
checkForAddressV("Address");
checkContactNumberV("Contact");
checkUploadedPicV("picture");
checkUploadedAudioV("audio");
checkUploadedVideoV("video");
if(arr.length>0)
	{
	showErrors();
	return false;
	}
else return true;
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

function checkUploadedPicV(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
tempVal.trim();
var nullCheck;
var formatCheck;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	arr[arr.length]="Please select an image to upload:";
	return false;
	}
else
	{
	formatCheck=checkValidImageFormat(tempVal);
	if(!formatCheck)
		{
		arr[arr.length]="Please select JPG,PNG,or GIF image only";
		return false;
		}
	}
}

function checkForAddressV(elementId)
{
	var temp=document.getElementById(elementId);
	var tempVal=temp.value;
	tempVal.trim();
	var nullCheck;
	nullCheck=checkForEmpty(tempVal);
	if(nullCheck)
		{
		arr[arr.length]="Please enter the address:";
		return false;
		}
	else return true;
	
}

function checkUploadedAudioV(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
tempVal.trim();
var nullCheck;
var formatCheck;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	arr[arr.length]="Please select an audio-file to upload:";
	return false;
	}
else
	{
	formatCheck=checkValidAudioFormat(tempVal);
	if(!formatCheck)
		{
		arr[arr.length]="Please select an mp3 or wav audio-file only";
		return false;
		}
	}
}

function checkUploadedVideoV(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
tempVal.trim();
var nullCheck;
var formatCheck;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	arr[arr.length]="Please select a video-file to upload:";
	return false;
	}
else
	{
	formatCheck=checkValidVideoFormat(tempVal);
	if(!formatCheck)
		{
		arr[arr.length]="Please select an .mp4 .avi or .mkv video-file only";
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

function checkContactNumberV(elementId)
{
var temp=document.getElementById(elementId);
var tempVal=temp.value;
var contactRegex2=/^[1-9]{1}\d{9}$|^\d{2}\-[1-9]{1}\d{9}$/;
tempVal.trim();
var nullCheck;
nullCheck=checkForEmpty(tempVal);
if(nullCheck)
	{
	arr[arr.length]="Please enter a contact-number:";
	return false;
	}
else
{
if(!contactRegex2.test(tempVal))
	{
	arr[arr.length]="Invalid contact-number please enter a valid contact-number";
		return false;
	}
else
	return true;
}
}

