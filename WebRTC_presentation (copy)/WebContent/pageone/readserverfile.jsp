<html>
<body>
<script type='text/javascript'>
var contentsOfFileAsString;
function readip()
{
//	var pathOfFileToRead = 'file://////home//altanai//altanaiwkspace2//presentation_server_config.txt';
var pathOfFileToRead = "presentation_server_config.txt";

contentsOfFileAsString = FileHelper.readStringFromFileAtPath
	(
		pathOfFileToRead
	);

//	document.body.innerHTML = contentsOfFileAsString;
}

function FileHelper()
{}
{
	FileHelper.readStringFromFileAtPath = function(pathOfFileToReadFrom)
	{
		var request = new XMLHttpRequest();
		request.open("GET", pathOfFileToReadFrom, false);
		request.send(null);
		var returnValue = request.responseText;

		return returnValue;
	}
}
readip();

alert(" ip "+contentsOfFileAsString)

</script>


</body>
</html>