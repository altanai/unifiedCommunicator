var xmlHttpRequest;
if (window.XMLHttpRequest) {
	xmlHttpRequest = new XMLHttpRequest();
} else if (window.ActiveXObject) {
	xmlHttpRequest = new ActiveXObject(MICROSOFT.XMLHTTP);
}
(function() {
	 
    var constraints = { video: true, audio: true },
        recorder = new RecordRTC({
            enable: constraints,
            videoElem: document.getElementById("client-audio"),
            video_width: 300,
            video_height: 240,
            canvas_width: 300,
            canvas_height: 240
        });

    
    // get user media
    recorder.getMedia(recorder.setMedia, function() {
        console.log("get user media failed!");
    });

    recorder.onVideoReady(function(blob) {
        attachLink(blob, "video");
    });

    recorder.onAudioReady(function(blob) {
        attachLink(blob, "audio");
    });

    document.getElementById("start-record").addEventListener("click", function() {
    	
        var toUser=document.getElementById("to").value;
        toUser=toUser.trim();
        if("".match(toUser)){
        	alert("Please select a recipient from the list.");
        }
        else{
        	document.getElementById("recording").style.display="";
        	document.getElementById("stop-record").style.display="inline";
            document.getElementById("start-record").style.display="none";
            document.getElementById("play").style.display="none";
            document.getElementById("discardAudio").style.display="none";
            document.getElementById("saveVideo").style.display="none";
            recorder.start();
        }
    });

    document.getElementById("stop-record").addEventListener("click", function() {
    	document.getElementById("recording").style.display="none";
    	document.getElementById("upload").style.display="";
    	document.getElementById("stop-record").style.display="none";
        document.getElementById("start-record").style.display="inline";
    	recorder.stop();
    });
    

    function attachLink(blob, str) {
            var reader = new FileReader();
            reader.onloadend = function(e) {
        	xmlHttpRequest.open("POST", "VoiceMailServlet?action=recordVoiceMail&from="+document.getElementById("from").value+"&to="+document.getElementById("to").value+"&type="+str,true);
        	xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
        	xmlHttpRequest.upload.onprogress = function(e) { console.log("uploading..."); };
        	xmlHttpRequest.setRequestHeader("Content-Type", "audio/wav");
        	xmlHttpRequest.send(blob);
            };
        reader.readAsDataURL(blob);
        var link=URL.createObjectURL(blob);
        document.getElementById("instantPlayback").value=link;
      }
        function receiveMessageFromServer()
        {
    	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
    		{
    		$("#upload").css("display","none");
    		alert("Server says "+xmlHttpRequest.responseText);
    		$("#saveVideo").css("display","");
			$("#play").css("display","");
			$("#discardAudio").css("display","");
			
			
    		}
        }

})();


