<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<!-- head -->
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <!-- <meta charset="utf-8" /> -->
    <title>webrtc</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="Keywords" content="sipML5, VoIP, HTML5, WebRTC, RTCWeb, SIP, IMS, Video chat, VP8, live demo " />
    <meta name="Description" content="HTML5 SIP client using WebRTC framework" />
    <meta name="author" content="TCS Telecom" />

    <script src="SIPml-api.js?svn=179" type="text/javascript"> </script>
	
    <%@include file="style.jsp" %>


</head>
<!-- Javascript code -->
<script type="text/javascript">

	var arr;  //Array Variable declared globally
	var xmlHttpRequest;
	if(window.XMLHttpRequest)
	{
	xmlHttpRequest=new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
	xmlHttpRequest=new ActiveXObject(MICROSOFT.XMLHTTP);
	}
    var sTransferNumber;
    var oRingTone, oRingbackTone;
    var oSipStack, oSipSessionRegister, oSipSessionCall, oSipSessionTransferCall;
    var videoRemote, videoLocal, audioRemote;
    var bFullScreen = false;
    var oNotifICall;
    var oReadyStateTimer;
    var bDisableVideo = false;
    var viewVideoLocal, viewVideoRemote; // <video> (webrtc) or <div> (webrtc4all)
    var oConfigCall;
    var oConfigMsg;
    var oSipSessionMessage;
    var oSipPublish;
    var subscribeSession;
    var oConfigSub;
    var infoArray=new Array(20);
    var r;
   var to=new Array();
  // var to;
    var friendslist = new Array();
    var friends = new Array();
    var chkURI=new Array();
    var xmlHttpRequest;
    
    var msgId=0;
    var extraContent;
    var addInt;
    var finalMsg;
    var mainCont;


    C = 
    {
        divKeyPadWidth: 220
    };

    window.onload = function () {
        if(window.console) {
            window.console.info("location=" + window.location);
        }
        videoLocal = document.getElementById("video_local");
        videoRemote = document.getElementById("video_remote");
        audioRemote = document.getElementById("audio_remote");

        document.onkeyup = onKeyUp;
        document.body.onkeyup = onKeyUp;
        divCallCtrl.onmousemove = onDivCallCtrlMouseMove;

        // set debug level
        SIPml.setDebugLevel((window.localStorage && window.localStorage.getItem('org.doubango.expert.disable_debug') == "true") ? "error" : "info");

        loadCredentials();
        loadCallOptions();

        // Initialize call button
        uiBtnCallSetText("Call");

        oReadyStateTimer = setInterval(function () {
            if (document.readyState === "complete") {
                clearInterval(oReadyStateTimer);
                // initialize SIPML5
                SIPml.init(postInit);
            }
        },
        500);
        dummyRegister();
        
        if (uRIContactPage.value!="null"){
           // alert("changing");
        	txtPhoneNumber.value=uRIContactPage.value;
        	uRIContactPage.value="null";
        	//alert("entering sip call");
        	setTimeout(function(){sipCall("call-audiovideo"); },1000);
        	       }
    };

    window.onbeforeunload = function saveAllData()
    {
        
        sipUnRegister();
        //return true;                      //comment out 'return' to suppress prompt
    }
    
    
    //read server ip from file
   var ip;
   function readip()
   {
   var pathOfFileToRead = "presentation_server_config.txt";

   ip = FileHelper.readStringFromFileAtPath
   	(
   		pathOfFileToRead
   	);
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
   // alert("ip "+ip);
   
   function sendDataToDiv(from,message)
	{
	$(document).ready(function(){
		var text=$('<div class="chat" style="color:gray">'+from+' : '+ message+ '</div>');
		$('.chatbox').append(text);
		$(text).gemoticon();
		});
	}
    
    
    
    //fetch buddy list
    function main()
 {
 	var pathOfFileToRead = "friend.txt";
 	var contentsOfFileAsString = FileHelper.readStringFromFileAtPath(pathOfFileToRead);
 	friendslist=contentsOfFileAsString;
 	//alert("frined list "+ friendslist);
 } 
     
    function FileHelper()
    {}

    {
    	FileHelper.readStringFromFileAtPath = function(pathOfFileToReadFrom)
    	{
    		var request = new XMLHttpRequest();
    		request.open("GET", pathOfFileToReadFrom, false);
    		request.send(null);
    		//var returnValue = request.responseText;
    		friends = request.responseText.split("\n")
    		//return returnValue;
    		return friends;
    	}
    }
    main();
   // alert("friend "+friends);
    
    function postInit() {
        // check webrtc4all version
        if (SIPml.isWebRtc4AllSupported() && SIPml.isWebRtc4AllPluginOutdated()) {            
            if (confirm("Your WebRtc4all extension is outdated ("+SIPml.getWebRtc4AllVersion()+"). A new version with critical bug fix is available. Do you want to install it?\nIMPORTANT: You must restart your browser after the installation.")) {
                window.location = 'http://code.google.com/p/webrtc4all/downloads/list';
                return;
            }
        }

        // check for WebRTC support
        if (!SIPml.isWebRtcSupported()) {
            // is it chrome?
            if (SIPml.getNavigatorFriendlyName() == 'chrome') {
                    if (confirm("You're using an old Chrome version or WebRTC is not enabled.\nDo you want to see how to enable WebRTC?")) {
                        window.location = 'http://www.webrtc.org/running-the-demos';
                    }
                    else {
                        window.location = "index.html";
                    }
                    return;
            }
                
            // for now the plugins (WebRTC4all only works on Windows)
            if (SIPml.getSystemFriendlyName() == 'windows') {
                // Internet explorer
                if (SIPml.getNavigatorFriendlyName() == 'ie') {
                    // Check for IE version 
                    if (parseFloat(SIPml.getNavigatorVersion()) < 9.0) {
                        if (confirm("You are using an old IE version. You need at least version 9. Would you like to update IE?")) {
                            window.location = 'http://windows.microsoft.com/en-us/internet-explorer/products/ie/home';
                        }
                        else {
                            window.location = "index.html";
                        }
                    }

                    // check for WebRTC4all extension
                    if (!SIPml.isWebRtc4AllSupported()) {
                        if (confirm("webrtc4all extension is not installed. Do you want to install it?\nIMPORTANT: You must restart your browser after the installation.")) {
                            window.location = 'http://code.google.com/p/webrtc4all/downloads/list';
                        }
                        else {
                            // Must do nothing: give the user the chance to accept the extension
                            // window.location = "index.html";
                        }
                    }
                    // break page loading ('window.location' won't stop JS execution)
                    if (!SIPml.isWebRtc4AllSupported()) {
                        return;
                    }
                }
                else if (SIPml.getNavigatorFriendlyName() == "safari" || SIPml.getNavigatorFriendlyName() == "firefox" || SIPml.getNavigatorFriendlyName() == "opera") {
                    if (confirm("Your browser don't support WebRTC.\nDo you want to install WebRTC4all extension to enjoy audio/video calls?\nIMPORTANT: You must restart your browser after the installation.")) {
                        window.location = 'http://code.google.com/p/webrtc4all/downloads/list';
                    }
                    else {
                        window.location = "index.html";
                    }
                    return;
                }
            }
            // OSX, Unix, Android, iOS...
            else {
                if (confirm('WebRTC not supported on your browser.\nDo you want to download a WebRTC-capable browser?')) {
                    window.location = 'https://www.google.com/intl/en/chrome/browser/';
                }
                else {
                    window.location = "index.html";
                }
                return;
            }
        }

        // checks for WebSocket support
        if (!SIPml.isWebSocketSupported() && !SIPml.isWebRtc4AllSupported()) {
            if (confirm('Your browser don\'t support WebSockets.\nDo you want to download a WebSocket-capable browser?')) {
                window.location = 'https://www.google.com/intl/en/chrome/browser/';
            }
            else {
                window.location = "index.html";
            }
            return;
        }

        // attachs video displays
        if (SIPml.isWebRtc4AllSupported()) {
            viewVideoLocal = document.getElementById("divVideoLocal");
            viewVideoRemote = document.getElementById("divVideoRemote");
            WebRtc4all_SetDisplays(viewVideoLocal, viewVideoRemote); // FIXME: move to SIPml.* API
        }
        else{
            viewVideoLocal = videoLocal;
            viewVideoRemote = videoRemote;
        }

        if (!SIPml.isWebRtc4AllSupported() && !SIPml.isWebRtcSupported()) {
            if (confirm('Your browser don\'t support WebRTC.\naudio/video calls will be disabled.\nDo you want to download a WebRTC-capable browser?')) {
                window.location = 'https://www.google.com/intl/en/chrome/browser/';
            }
        }
        
        btnRegister.disabled = false;
        document.body.style.cursor = 'default';
        oConfigCall = {
            audio_remote: audioRemote,
            video_local: viewVideoLocal,
            video_remote: viewVideoRemote,
            bandwidth: { audio:undefined, video:undefined },
            video_size: { minWidth:undefined, minHeight:undefined, maxWidth:undefined, maxHeight:undefined },
            events_listener: { events: '*', listener: onSipEventSession },
            sip_caps: [
                            { name: '+g.oma.sip-im' },
                            { name: '+sip.ice' },
                            { name: 'language', value: '\"en,fr\"' }
                        ]
        };
    }


    function loadCallOptions() {
        if (window.localStorage) {
            var s_value;
            if ((s_value = window.localStorage.getItem('org.doubango.call.phone_number'))) txtPhoneNumber.value = s_value;
            bDisableVideo = (window.localStorage.getItem('org.doubango.expert.disable_video') == "true");

            txtCallStatus.innerHTML = '<i>Video ' + (bDisableVideo ? 'disabled' : 'enabled') + '</i>';
        }
    }

    function saveCallOptions() {
        if (window.localStorage) {
            window.localStorage.setItem('org.doubango.call.phone_number', txtPhoneNumber.value);
            window.localStorage.setItem('org.doubango.expert.disable_video', bDisableVideo ? "true" : "false");
        }
    }

    function loadCredentials() {
       /*  if (window.localStorage) {
            // IE retuns 'null' if not defined
            var s_value;
            if ((s_value = window.localStorage.getItem('org.doubango.identity.display_name'))) txtDisplayName.value = s_value;
            if ((s_value = window.localStorage.getItem('org.doubango.identity.impi'))) txtPrivateIdentity.value = s_value;
            if ((s_value = window.localStorage.getItem('org.doubango.identity.impu'))) txtPublicIdentity.value = s_value;
            if ((s_value = window.localStorage.getItem('org.doubango.identity.password'))) txtPassword.value = s_value;
            if ((s_value = window.localStorage.getItem('org.doubango.identity.realm'))) txtRealm.value = s_value;
        }
        else {
            /*txtDisplayName.value = "005";
            txtPrivateIdentity.value = "005";
            txtPublicIdentity.value = "sip:005@192.168.0.28";
            txtPassword.value = "005";
            txtRealm.value = "192.168.0.28";
            txtPhoneNumber.value = "005";
        } */
    };

    function saveCredentials() {
        
    	if (window.localStorage) {
        	
            window.localStorage.setItem('org.doubango.identity.display_name', txtDisplayName.value);
            window.localStorage.setItem('org.doubango.identity.impi', txtPrivateIdentity.value);
            window.localStorage.setItem('org.doubango.identity.impu', txtPublicIdentity.value);
            window.localStorage.setItem('org.doubango.identity.password', txtPassword.value);
            window.localStorage.setItem('org.doubango.identity.realm', txtRealm.value);
            
          //  alert ("save credentails func :"+ txtPublicIdentity.value );
        }
    };

    // sends SIP REGISTER request to login
    function sipRegister() {
        // catch exception for IE (DOM not ready)
       // alert ("sip register func :"+ txtPublicIdentity.value );
        try {
            btnRegister.disabled = true;
            if (!txtRealm.value || !txtPrivateIdentity.value || !txtPublicIdentity.value) {
                txtRegStatus.innerHTML = '<b>Please fill madatory fields (*)</b>';
                btnRegister.disabled = false;
                return;
            }
            var o_impu = tsip_uri.prototype.Parse(txtPublicIdentity.value);
            if (!o_impu || !o_impu.s_user_name || !o_impu.s_host) {
                txtRegStatus.innerHTML = "<b>[" + txtPublicIdentity.value + "] is not a valid Public identity</b>";
                btnRegister.disabled = false;
                return;
            }

            // enable notifications if not already done
            if (window.webkitNotifications && window.webkitNotifications.checkPermission() != 0) {
                window.webkitNotifications.requestPermission();
            }

            // save credentials
            saveCredentials();
            window.localStorage.setItem('com.s.v.bool', "true");
            // update debug level to be sure new values will be used if the user haven't updated the page
            SIPml.setDebugLevel((window.localStorage && window.localStorage.getItem('org.doubango.expert.disable_debug') == "true") ? "error" : "info");

            // create SIP stack
            oSipStack = new SIPml.Stack({
                    realm: txtRealm.value,
                    impi: txtPrivateIdentity.value,
                    impu: txtPublicIdentity.value,
                    password: txtPassword.value,
                    display_name: txtDisplayName.value,
                    websocket_proxy_url: (window.localStorage ? window.localStorage.getItem('org.doubango.expert.websocket_server_url') : null),
                    outbound_proxy_url: (window.localStorage ? window.localStorage.getItem('org.doubango.expert.sip_outboundproxy_url') : null),
                    ice_servers: (window.localStorage ? window.localStorage.getItem('org.doubango.expert.ice_servers') : null),
                    enable_rtcweb_breaker: (window.localStorage ? window.localStorage.getItem('org.doubango.expert.enable_rtcweb_breaker') == "true" : false),
                    events_listener: { events: '*', listener: onSipEventStack },
                    enable_early_ims: (window.localStorage ? window.localStorage.getItem('org.doubango.expert.disable_early_ims') != "true" : true), // Must be true unless you're using a real IMS network
                    enable_media_stream_cache: (window.localStorage ? window.localStorage.getItem('org.doubango.expert.enable_media_caching') == "true" : false),
                    bandwidth: (window.localStorage ? tsk_string_to_object(window.localStorage.getItem('org.doubango.expert.bandwidth')) : null), // could be redefined a session-level
                    video_size: (window.localStorage ? tsk_string_to_object(window.localStorage.getItem('org.doubango.expert.video_size')) : null), // could be redefined a session-level
                    sip_headers: [
                            { name: 'User-Agent', value: 'IM-client/OMA1.0 sipML5-v1.2013.08.10B' },
                            { name: 'Organization', value: 'TCS' }
                    ]
                }
            );
            if (oSipStack.start() != 0) {
                txtRegStatus.innerHTML = '<b>Failed to start the SIP stack</b>';
            }
            else return;
        }
        catch (e) {
            txtRegStatus.innerHTML = "<b>2:" + e + "</b>";
        }
        btnRegister.disabled = false;
    }

    // sends SIP REGISTER (expires=0) to logout
    function sipUnRegister() {
        if (oSipStack) {
            oSipStack.stop(); // shutdown all sessions
        }
    }
    
    function chatValidation(){
    	chatField.innerHTML="";
    	
		var desturi=document.getElementById("uri").value;
		desturi.trim();
		if(desturi===""){
			chatField.innerHTML="URI Cant Be Empty";
			desturi.focus;
			return;
		}
		
 }
    function msgValidation(){
    	chatField.innerHTML="";
    	var content=document.getElementById("msg").value;
		if(content===""){
			chatField.innerHTML="Msg Box Cant Be Empty";
			return;
		}
    }
    
     function enterpressalert(e){
    	 if(e.keyCode===13){
    		 sipIM("message");
    	 }
     }
    
    function sipIM(s_type)
	{
		
	 oConfigMsg = {
            
            events_listener: { events: '*', listener: onSipEventSession },
            sip_caps: [
                            { name: '+g.oma.sip-im' },
                            { name: '+sip.ice' },
                            { name: 'language', value: '\"en,fr\"' }
                        ]
        };
		var uri=document.getElementById("uri").value;
		/* var desturi="sip:"+uri+"@tcs.com"; */
		var desturi=uri;
		var content=document.getElementById("msg").value;
		document.getElementById("msg").value="";
		/* document.getElementById("textArea").value +="me : "+ content+"\n" ;
		document.getElementById("textArea").scrollTop =    document.getElementById("textArea").scrollHeight; */
		
		//call the javadcript function of jqurey
		sendDataToDiv("me",content);
		document.getElementById("sipMsgs").scrollTop =    document.getElementById("sipMsgs").scrollHeight;
		
		       /* if (oSipStack && !oSipSessionMessage && !tsk_string_is_null_or_empty(txtPhoneNumber.value)) { */
		oSipSessionMessage = oSipStack.newSession(s_type,oConfigMsg);
		
		extraContent="[{trxnid}]";
		 addInt=extraContent+msgId;
		 msgId++;
		 finalMsg=content+addInt;
		 
		oSipSessionMessage.send(desturi,finalMsg, 'text/plain;charset=utf8');

	}



    
  //presence
	function sipPublis(s_type) {
				// alert("inside publish");
		oSipPublish = oSipStack.newSession('publish', {
			expires : 200,
			sip_headers : [ {
				name : 'Event',
				value : 'presence'
			} ],
			sip_caps : [ {
				name : '+g.oma.sip-im'
			}, {
				name : '+sip.ice'
			}, {
				name : 'language',
				value : '\"en,fr\"'
			} ],
			events_listener : {
				events : '*',
				listener : onSipEventSession
			}
		});
		var contentType = 'application/pidf+xml';
		var content = '<?xml version="1.0" encoding="UTF-8"?>\n'
				+ '<presence xmlns="urn:ietf:params:xml:ns:pidf">\n' +

				'<tuple id="bob">\n' + '<status>\n' + '<basic>open</basic>\n'
				+ '<contact>sip:bob@tcs.com</contact>\n'
				+ '<note>online</note></status>\n' + '</tuple>\n'
				+ '</presence>';
		oSipPublish.publish(content, contentType);
	//alert("dhin ta ta22222");

	}
	
	
	//presence ends
	main();

	
	//subscribe
	function sipSubscribe() {

     for(i=0;i<friendslist.length;i++)
	 {
		oConfigSub = {
			expires : 200,
			events_listener : {
				events : '*',
				listener : onSipEventSession
			},
			sip_headers : [ {
				name : 'Event',
				value : 'presence'
			}, // only notify for 'presence' events
			{
				name : 'Accept',
				value : 'application/pidf+xml'
			} // supported content types (COMMA-sparated)
			],
			sip_caps : [ {
				name : '+g.oma.sip-im'
			}, {
				name : '+sip.ice'
			}, {
				name : 'language',
				value : '\"en,fr\"'
			} ]

		};

		subscribeSession = oSipStack.newSession("subscribe", oConfigSub);

		// start watching for entity's presence status (You may track event type 'connected' to be sure that the request has been accepted by the server)

			to[i]=friendslist[i];
			subscribeSession.subscribe(to[i]);
							
			}
	}	
	//subscribe ends
    
	
	
	
    // makes a call (SIP INVITE)
    function sipCall(s_type) {
		arr=new Array(); 
		arr[arr.length]=document.getElementById("txtPublicIdentity").value;
		arr[arr.length]=document.getElementById("txtPhoneNumber").value;
		var startTime=new Date();
		arr[arr.length]=startTime.getTime();
        if (oSipStack && !oSipSessionCall && !tsk_string_is_null_or_empty(txtPhoneNumber.value)) {
            if(s_type == 'call-screenshare') {
                if(!SIPml.isScreenShareSupported()) {
                 //   alert('Screen sharing not supported. Are you using chrome 26+?'); 
                    return;
                }
               //changed from https to http 
                if (!location.protocol.match('http')){
                    if (confirm("Screen sharing requires https://. Do you want to be redirected?")) {
                        sipUnRegister();
                        window.location = 'https://ns313841.ovh.net/call.htm';
                    }
                    return;
                }
                
            }
            btnCall.disabled = true;
            btnHangUp.disabled = false;

            if(window.localStorage) {
                oConfigCall.bandwidth = tsk_string_to_object(window.localStorage.getItem('org.doubango.expert.bandwidth')); // already defined at stack-level but redifined to use latest values
                oConfigCall.video_size = tsk_string_to_object(window.localStorage.getItem('org.doubango.expert.video_size')); // already defined at stack-level but redifined to use latest values
            }
            
            // create call session
            oSipSessionCall = oSipStack.newSession(s_type, oConfigCall);
            // make call
            if (oSipSessionCall.call(txtPhoneNumber.value) != 0) {
                oSipSessionCall = null;
                txtCallStatus.value = 'Failed to make call';
                btnCall.disabled = false;
                btnHangUp.disabled = true;
                return;
            }
            saveCallOptions();
        }
        else if (oSipSessionCall) {
            txtCallStatus.innerHTML = '<i>Connecting...</i>';
            oSipSessionCall.accept(oConfigCall);
        }
    }

    // transfers the call
    function sipTransfer() {
        if (oSipSessionCall) {
            var s_destination = prompt('Enter destination number', '');
            if (!tsk_string_is_null_or_empty(s_destination)) {
                btnTransfer.disabled = true;
                if (oSipSessionCall.transfer(s_destination) != 0) {
                    txtCallStatus.innerHTML = '<i>Call transfer failed</i>';
                    btnTransfer.disabled = false;
                    return;
                }
                txtCallStatus.innerHTML = '<i>Transfering the call...</i>';
            }
        }
    }
    
    // holds or resumes the call
    function sipToggleHoldResume() {
        if (oSipSessionCall) {
            var i_ret;
            btnHoldResume.disabled = true;
            txtCallStatus.innerHTML = oSipSessionCall.bHeld ? '<i>Resuming the call...</i>' : '<i>Holding the call...</i>';
            i_ret = oSipSessionCall.bHeld ? oSipSessionCall.resume() : oSipSessionCall.hold();
            if (i_ret != 0) {
                txtCallStatus.innerHTML = '<i>Hold / Resume failed</i>';
                btnHoldResume.disabled = false;
                return;
            }
        }
    }

    // terminates the call (SIP BYE or CANCEL)
    function sipHangUp() {
    	var endTime=new Date();
    	arr[arr.length]=endTime.getTime();
    	sendDataToUpload();
    	if (oSipSessionCall) {
            txtCallStatus.innerHTML = '<i>Terminating the call...</i>';
            oSipSessionCall.hangup({events_listener: { events: '*', listener: onSipEventSession }});
         
        }
        
    }

    function sipSendDTMF(c){
        if(oSipSessionCall && c){
            if(oSipSessionCall.dtmf(c) == 0){
                try { dtmfTone.play(); } catch(e){ }
            }
        }
    }

    function startRingTone() {
        try { ringtone.play(); }
        catch (e) { }
    }

    function stopRingTone() {
        try { ringtone.pause(); }
        catch (e) { }
    }

    function startRingbackTone() {
        try { ringbacktone.play(); }
        catch (e) { }
    }

    function stopRingbackTone() {
        try { ringbacktone.pause(); }
        catch (e) { }
    }

    function toggleFullScreen() {
        if (videoRemote.webkitSupportsFullscreen) {
            fullScreen(!videoRemote.webkitDisplayingFullscreen);
        }
        else {
            fullScreen(!bFullScreen);
        }
    }

    function openKeyPad(){
        divKeyPad.style.visibility = 'visible';
        divKeyPad.style.left = ((document.body.clientWidth - C.divKeyPadWidth) >> 1) + 'px';
        divKeyPad.style.top = '70px';
        divGlassPanel.style.visibility = 'visible';
    }

    function closeKeyPad(){
        divKeyPad.style.left = '0px';
        divKeyPad.style.top = '0px';
        divKeyPad.style.visibility = 'hidden';
        divGlassPanel.style.visibility = 'hidden';
    }

    function fullScreen(b_fs) {
        bFullScreen = b_fs;
        if (tsk_utils_have_webrtc4native() && bFullScreen && videoRemote.webkitSupportsFullscreen) {
            if (bFullScreen) {
                videoRemote.webkitEnterFullScreen();
            }
            else {
                videoRemote.webkitExitFullscreen();
            }
        }
        else {
            if (tsk_utils_have_webrtc4npapi()) {
                try { if(window.__o_display_remote) window.__o_display_remote.setFullScreen(b_fs); }
                catch (e) { divVideo.setAttribute("class", b_fs ? "full-screen" : "normal-screen"); }
            }
            else {
                divVideo.setAttribute("class", b_fs ? "full-screen" : "normal-screen");
            }
        }
    }

    function showNotifICall(s_number) {
        // permission already asked when we registered
        if (window.webkitNotifications && window.webkitNotifications.checkPermission() == 0) {
            if (oNotifICall) {
                oNotifICall.cancel();
            }
            oNotifICall = window.webkitNotifications.createNotification('Call Notification', 'Incoming call from ' + s_number);
            oNotifICall.onclose = function () { oNotifICall = null; };
            oNotifICall.show();
        }
    }

    function onKeyUp(evt) {
        evt = (evt || window.event);
        if (evt.keyCode == 27) {
            fullScreen(false);
        }
        else if (evt.ctrlKey && evt.shiftKey) { // CTRL + SHIFT
            if (evt.keyCode == 65 || evt.keyCode == 86) { // A (65) or V (86)
                bDisableVideo = (evt.keyCode == 65);
                txtCallStatus.innerHTML = '<i>Video ' + (bDisableVideo ? 'disabled' : 'enabled') + '</i>';
                window.localStorage.setItem('org.doubango.expert.disable_video', bDisableVideo);
            }
        }
    }

    function onDivCallCtrlMouseMove(evt) {
        try { // IE: DOM not ready
            if (tsk_utils_have_stream()) {
                btnCall.disabled = (!tsk_utils_have_stream() || !oSipSessionRegister || !oSipSessionRegister.is_connected());
                document.getElementById("divCallCtrl").onmousemove = null; // unsubscribe
            }
        }
        catch (e) { }
    }

    function uiOnConnectionEvent(b_connected, b_connecting) { // should be enum: connecting, connected, terminating, terminated
        btnRegister.disabled = b_connected || b_connecting;
        btnUnRegister.disabled = !b_connected && !b_connecting;
        btnCall.disabled = !(b_connected && tsk_utils_have_webrtc() && tsk_utils_have_stream());
        btnHangUp.disabled = !oSipSessionCall;
    }

    function uiVideoDisplayEvent(b_local, b_added) {
        var o_elt_video = b_local ? videoLocal : videoRemote;

        if (b_added) {
            if (SIPml.isWebRtc4AllSupported()) {
                if (b_local){ if(window.__o_display_local) window.__o_display_local.style.visibility = "visible"; }
                else { if(window.__o_display_remote) window.__o_display_remote.style.visibility = "visible"; }
                   
            }
            else {
                o_elt_video.style.opacity = 1;
            }
            uiVideoDisplayShowHide(true);
        }
        else {
            if (SIPml.isWebRtc4AllSupported()) {
                if (b_local){ if(window.__o_display_local) window.__o_display_local.style.visibility = "hidden"; }
                else { if(window.__o_display_remote) window.__o_display_remote.style.visibility = "hidden"; }
            }
            else{
                o_elt_video.style.opacity = 0;
            }
            fullScreen(false);
        }
    }

    function uiVideoDisplayShowHide(b_show) {
        if (b_show) {
            tdVideo.style.height = '340px';
            divVideo.style.height = navigator.appName == 'Microsoft Internet Explorer' ? '100%' : '340px';
        }
        else {
            tdVideo.style.height = '0px';
            divVideo.style.height = '0px';
        }
        btnFullScreen.disabled = !b_show;
    }

    function uiDisableCallOptions() {
        if(window.localStorage) {
            window.localStorage.setItem('org.doubango.expert.disable_callbtn_options', 'true');
            uiBtnCallSetText('Call');
            alert('Use expert view to enable the options again (/!\\requires re-loading the page)');
        }
    }

    function uiBtnCallSetText(s_text) {
        switch(s_text) {
            case "Call":
                {
                    var bDisableCallBtnOptions = (window.localStorage && window.localStorage.getItem('org.doubango.expert.disable_callbtn_options') == "true");
                    btnCall.value = btnCall.innerHTML = bDisableCallBtnOptions ? 'Call' : 'Call <span id="spanCaret" class="caret">';
                    btnCall.setAttribute("class", bDisableCallBtnOptions ? "btn btn-primary" : "btn btn-primary dropdown-toggle");
                    btnCall.onclick = bDisableCallBtnOptions ? function(){ sipCall(bDisableVideo ? 'call-audio' : 'call-audiovideo'); } : null;
                    ulCallOptions.style.visibility = bDisableCallBtnOptions ? "hidden" : "visible";
                    if(!bDisableCallBtnOptions && ulCallOptions.parentNode != divBtnCallGroup){
                        divBtnCallGroup.appendChild(ulCallOptions);
                    }
                    else if(bDisableCallBtnOptions && ulCallOptions.parentNode == divBtnCallGroup) {
                        document.body.appendChild(ulCallOptions);
                    }
                    
                    break;
                }
            default:
                {
                    btnCall.value = btnCall.innerHTML = s_text;
                    btnCall.setAttribute("class", "btn btn-primary");
                    btnCall.onclick = function(){ sipCall(bDisableVideo ? 'call-audio' : 'call-audiovideo'); };
                    ulCallOptions.style.visibility = "hidden";
                    if(ulCallOptions.parentNode == divBtnCallGroup){
                        document.body.appendChild(ulCallOptions);
                    }
                    break;
                }
        }
    }

    function uiCallTerminated(s_description){
    	
        uiBtnCallSetText("Call");
        btnHangUp.value = 'HangUp';
        btnHoldResume.value = 'hold';
        btnCall.disabled = false;
        btnHangUp.disabled = true;
        oSipSessionCall = null;
        stopRingbackTone();
        stopRingTone();
        txtCallStatus.innerHTML = "<i>" + s_description + "</i>";
        uiVideoDisplayShowHide(false);
        divCallOptions.style.opacity = 0;

        if (oNotifICall) {
            oNotifICall.cancel();
            oNotifICall = null;
        }
        uiVideoDisplayEvent(true, false);
        uiVideoDisplayEvent(false, false);
        setTimeout(function () { if (!oSipSessionCall) txtCallStatus.innerHTML = ''; }, 2500);
        
    }
    
    function sendDataToUpload() //This function makes use of AJAX To Call the Servlet
    {
    	//alert("http://localhost:8080/WebRTCCallLogs/SipCallLogServlet?caller="+arr[0]+"&callee="+arr[1]+"&startTime="+arr[2]+"&endTime="+arr[3]);
    	xmlHttpRequest.open("POST", "http://"+ip+":8080/EnhancedWebRTCCallLogs/SipCallLogServlet?caller="+arr[0]+"&callee="+arr[1]+"&startTime="+arr[2]+"&endTime="+arr[3], true);
    	xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
    	xmlHttpRequest.send();
    }
    
    function receiveMessageFromServer()
    {
    	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
    		{
    	//	alert(xmlHttpRequest.responseText);
    		/* document.getElementById("serverReply").innerHTML=xmlHttpRequest.responseText;
    		document.getElementById("HangUp").disabled=true;
    		document.getElementById("CALL").disabled=false; */
    		}
    }
    
    //send data
    
if(window.XMLHttpRequest)
	{
	xmlHttpRequest=new XMLHttpRequest();
	}
else if(window.ActiveXObject)
	{
	xmlHttpRequest=new ActiveXObject(MICROSOFT.XMLHTTP);
	}
	

function eraseResponseMessage()
{
	document.getElementById("serverReply").innerHTML="";
}
function receiveMessageFromServer()
{
	if(xmlHttpRequest.readyState==4&&xmlHttpRequest.status==200)
		{
		document.getElementById("serverReply").innerHTML=xmlHttpRequest.responseText;
		}
}
    
    
    //send data end

    // Callback function for SIP Stacks
    function onSipEventStack(e /*SIPml.Stack.Event*/) {
        tsk_utils_log_info('==stack event = ' + e.type);
        switch (e.type) {
            case 'started':
                {
                    // catch exception for IE (DOM not ready)
                    try {
                        // LogIn (REGISTER) as soon as the stack finish starting
                        oSipSessionRegister = this.newSession('register', {
                            expires: 200,
                            events_listener: { events: '*', listener: onSipEventSession },
                            sip_caps: [
                                        { name: '+g.oma.sip-im', value: null },
                                        { name: '+audio', value: null },
                                        { name: 'language', value: '\"en,fr\"' }
                                ]
                        });
                        oSipSessionRegister.register();
                    }
                    catch (e) {
                        txtRegStatus.value = txtRegStatus.innerHTML = "<b>1:" + e + "</b>";
                        btnRegister.disabled = false;
                    }
                    break;
                }
            case 'stopping': case 'stopped': case 'failed_to_start': case 'failed_to_stop':
                {
                    var bFailure = (e.type == 'failed_to_start') || (e.type == 'failed_to_stop');
                    oSipStack = null;
                    oSipSessionRegister = null;
                    oSipSessionCall = null;

                    uiOnConnectionEvent(false, false);

                    stopRingbackTone();
                    stopRingTone();

                    uiVideoDisplayShowHide(false);
                    divCallOptions.style.opacity = 0;

                    txtCallStatus.innerHTML = '';
                    txtRegStatus.innerHTML = bFailure ? "<i>Disconnected: <b>" + e.description + "</b></i>" : "<i>Disconnected</i>";
                    break;
                }
                
            case 'i_new_message':
			{
            	if(oSipSessionMessage){
            		/*alert("session established");*/
            		oSipSessionMessage=e.newSession;
            		
            			oSipSessionMessage.accept();
            			var si=oSipSessionMessage.getRemoteUri();
            			/*alert("remote uri is"+si);*/
    					oSipSessionMessage.setConfiguration(oConfigMsg);
    					var str = oSipSessionMessage.getRemoteFriendlyName();
    					/*alert("new user is"+str);*/
    					var i=0;

    					 /* var sRemoteUri=str.slice(1,25); */
    					 var firstString=str.replace("<","");
    					 var sRemoteUri=firstString.replace(">","");
    					 
    					
    					 var doc=e.getContentString();
    				/*changes*/
    					mainCont=doc.split("[");
    					 var string2=str+doc;
    					/* alert("www"+string2);
    					 alert("uri is"+chkURI);*/
    					 for(k=0;k<chkURI.length;k++){
    						/* alert("inside new array");*/
    						 if(chkURI[k]===string2){
    							// alert("duplicate");
    							 return;
    						 }
    					 }
    					/* for(i=0;i<10;i++){
    						
    							 alert("inside if");
    							 if(chkURI[i]===string2){
    							 alert("duplicate");
    							 return;
    						 }
    					 }*/
    						
    								 /*alert("inside else");*/
    								 if(chkURI.length<10){
    									 //added
    									
    								 chkURI.push(string2);
    								 var b="sip:";
    		    						 var c =b.concat(sRemoteUri);
    								 var a="@";
    								 var d=a.concat(document.getElementById("txtRealm"));
    		    						<%--  var d="@"<%=request.getParameter("realm")%>; --%>
    		    						/*  var d="@tcs.com"; */
    		    						 var f=c.concat(d);
    		    						   	                       
    		    							/*document.getElementById("msg").value=doc;*/
    		    							 /*document.getElementById("textArea").value += str+" : "+mainCont[0]+ "\n" ;
    		    							document.getElementById("textArea").scrollTop =    document.getElementById("textArea").scrollHeight;*/
    		    							
    		    							//Code to call jqurey function here 
    		    							sendDataToDiv(str,mainCont[0]);
    		    							document.getElementById("sipMsgs").scrollTop =    document.getElementById("sipMsgs").scrollHeight;
    		                            document.getElementById("uri").value =str;
    								 }
    								 else
    									 {
    									 /*alert("inside splice");*/
    									 chkURI.splice(0,1);
    								
    									 chkURI.push(string2);
        								 var b="sip:";
        		    						 var c =b.concat(sRemoteUri);
        								 var a="@";
        								 var d=a.concat(document.getElementById("txtRealm"));
        		    						<%--  var d="@"<%=request.getParameter("realm")%>; --%>
        		    						/*  var d="@tcs.com"; */
        		    						 var f=c.concat(d);
        		    						   	                       
        		    						
        		    							sendDataToDiv(str,mainCont[0]);
        		    							document.getElementById("sipMsgs").scrollTop =    document.getElementById("sipMsgs").scrollHeight;
        		    							
        		                            document.getElementById("uri").value =str;
    									 }
    					 
    					 
    				}
            		else{
            		
            		
						oSipSessionMessage=e.newSession;
						oSipSessionMessage.accept();
					oSipSessionMessage.setConfiguration(oConfigMsg);
					 var str = (oSipSessionMessage.getRemoteFriendlyName() || 'unknown');
					
					
					 var firstString=str.replace("<","");
					 var sRemoteUri=firstString.replace(">","");
					 var doc=e.getContentString();
					 var fstring=str+doc;
					 chkURI.push(fstring);
					 var cont=doc.split("[");
					//alert("trxn cont is"+cont[0]);
					 /* chkMSG.push(doc); */
					
						 var b="sip:";
						 var c =b.concat(sRemoteUri);
						 var a="@";
						 var d=a.concat(document.getElementById("txtRealm"));
						 
						 /* var d="@tcs.com"; */
						 var f=c.concat(d);
							/*document.getElementById("msg").value=doc;*/
							//code for jqurey
							sendDataToDiv(str,cont[0]);
							document.getElementById("sipMsgs").scrollTop =    document.getElementById("sipMsgs").scrollHeight;
							/* document.getElementById("textArea").value += str+" : "+cont[0]+ "\n" ; */
                        document.getElementById("uri").value =str;
						/*document.getElementById("msg").value=doc;*/	
			  }
            		break;
			}


            case 'i_new_call':
                {
                    if (oSipSessionCall) {
                        // do not accept the incoming call if we're already 'in call'
                       // e.newSession.hangup(); // comment this line for multi-line support
                    }
                    else {
                        oSipSessionCall = e.newSession;
                        // start listening for events
                        oSipSessionCall.setConfiguration(oConfigCall);

                        uiBtnCallSetText('Answer');
                        btnHangUp.value = 'Reject';
                        btnCall.disabled = false;
                        btnHangUp.disabled = false;

                        startRingTone();

                        var sRemoteNumber = (oSipSessionCall.getRemoteFriendlyName() || 'unknown');
                        txtCallStatus.innerHTML = "<i>Incoming call from [<b>" + sRemoteNumber + "</b>]</i>";
                        showNotifICall(sRemoteNumber);
                    }
                    break;
                }

            case 'm_permission_requested':
                {
                    divGlassPanel.style.visibility = 'visible';
                    break;
                }
            case 'm_permission_accepted':
            case 'm_permission_refused':
                {
                    divGlassPanel.style.visibility = 'hidden';
                    if(e.type == 'm_permission_refused'){
                        uiCallTerminated('Media stream permission denied');
                    }
                    break;
                }

            case 'starting': default: break;
        }
    };

    function dummyUnregister(){
    	  window.localStorage.setItem('com.s.v.bool', "false");
    	  sipUnRegister();
    }
      function dummyRegister(){
      	if (window.localStorage.getItem('com.s.v.bool')=="true")
      		
      	{
      		setTimeout(function(){sipRegister();},700);
      		
      	}
      	
      }


    
    // Callback function for SIP sessions (INVITE, REGISTER, MESSAGE...)
    function onSipEventSession(e /* SIPml.Session.Event */) {
        tsk_utils_log_info('==session event = ' + e.type);

        switch (e.type) {
            case 'connecting': case 'connected':
                {
                    var bConnected = (e.type == 'connected');
                    
                    if (e.session == oSipSessionRegister) {
                        uiOnConnectionEvent(bConnected, !bConnected);
                        txtRegStatus.innerHTML = "<i>" + e.description + "</i>";
                    }
                    
                    else if (e.session == oSipSessionCall) {
                        btnHangUp.value = 'HangUp';
                        btnCall.disabled = true;
                        btnHangUp.disabled = false;
                        btnTransfer.disabled = false;

                        if (bConnected) {
                            stopRingbackTone();
                            stopRingTone();

                            if (oNotifICall) {
                                oNotifICall.cancel();
                                oNotifICall = null;
                            }
                        }

                        txtCallStatus.innerHTML = "<i>" + e.description + "</i>";
                        divCallOptions.style.opacity = bConnected ? 1 : 0;

                        if (SIPml.isWebRtc4AllSupported()) { // IE don't provide stream callback
                            uiVideoDisplayEvent(true, true);
                            uiVideoDisplayEvent(false, true);
                        }
                    }
                    break;
                } // 'connecting' | 'connected'
            case 'terminating': case 'terminated':
                {
                    if (e.session == oSipSessionRegister) {
                        uiOnConnectionEvent(false, false);

                        oSipSessionCall = null;
                        oSipSessionRegister = null;

                        txtRegStatus.innerHTML = "<i>" + e.description + "</i>";
                    }
                    else if (e.session == oSipSessionCall) {
                        uiCallTerminated(e.description);
                    }
                    break;
                } // 'terminating' | 'terminated'

            case 'i_notify': {
				// alert("inside notify"+e.getContentString());
	console.info('NOTIFY content = ' + e.getContentString());
	console.info('NOTIFY content-type = ' + e.getContentType());
	
	if (e.getContentType() == 'application/pidf+xml') {
		// alert("inside notifywww"); 
		if (window.DOMParser) {
			var parser = new DOMParser();
			var xmlDoc = parser ? parser.parseFromString(e
					.getContentString(), "text/xml") : null;

			var presenceNode = xmlDoc ? xmlDoc
					.getElementsByTagName("presence")[0] : null;
					/* alert("inside presence"+presenceNode); */
			if (presenceNode) {
				var entityUri = presenceNode.getAttribute("entity");

				/* alert("entity uri is" + entityUri); */
				var tupleNode = presenceNode
						.getElementsByTagName("tuple")[0];
					
				var statusNode = tupleNode
						.getElementsByTagName("status")[0];

				if (tupleNode) {
					var statusNode = tupleNode
							.getElementsByTagName("status")[0];
		
					var noteNode = tupleNode
							.getElementsByTagName("note")[0];

					      var check = noteNode.textContent;
					     // alert("check is"+check);
					
						    // check ip of currenty serer from file 
						 	//var pathOfFileToRead = "/home/altanai/altanaiwkspace/presentation_server_config.txt";
						    
							//alert (" server ip" + serverip );
						 //-----------
					//alert("check is"+check);
					if (check ==="") {

						var i=0;
							infoArray[i]=new Array();
							infoArray[i][0]=entityUri;
							infoArray[i][1]="offline";
							
							// alert("value of users is"+infoArray[i][0]);
							//alert("value of status"+infoArray[i][1]); 
							//alert("server ip "+ipcontentsOfFileAsString);
							xmlHttpRequest.open("POST", "http://"+ip+":8080/WebRTC_presentation/PresenceServlet?friend1="+infoArray[i][0]+"&friend1status="+infoArray[i][1], true);
							xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
							xmlHttpRequest.send();
							i++;

					} 
					else {
						//alert("inside online"); 
					
						infoArray=new Array(20);
						for(i=0;i<infoArray.length;i++)
							{
							infoArray[i]=new Array(20);
							infoArray[i][0]=entityUri;
							infoArray[i][1]="online";
							
							xmlHttpRequest.open("POST", "http://"+ip+":8080/WebRTC_presentation/PresenceServlet?friend1="+infoArray[i][0]+"&friend1status="+infoArray[i][1], true);
							xmlHttpRequest.onreadystatechange=receiveMessageFromServer;
							xmlHttpRequest.send();
							}
						// alert("status is"+infoArray[0][1]);
						//alert("entity is"+infoArray[0][1]); 
					}
					
					
					if (statusNode) {
						var basicNode = statusNode
								.getElementsByTagName("basic")[0];

						if (basicNode) {

							console
									.info('Presence notification: Uri = '
											+ entityUri
											+ ' status = '
											+ basicNode.textContent);
						}
					}
				}
			}
		}
	}
	break;
}
  
            case 'm_stream_video_local_added':
                {
                    if (e.session == oSipSessionCall) {
                        uiVideoDisplayEvent(true, true);
                    }
                    break;
                }
            case 'm_stream_video_local_removed':
                {
                    if (e.session == oSipSessionCall) {
                        uiVideoDisplayEvent(true, false);
                    }
                    break;
                }
            case 'm_stream_video_remote_added':
                {
                    if (e.session == oSipSessionCall) {
                        uiVideoDisplayEvent(false, true);
                    }
                    break;
                }
            case 'm_stream_video_remote_removed':
                {
                    if (e.session == oSipSessionCall) {
                        uiVideoDisplayEvent(false, false);
                    }
                    break;
                }

            case 'm_stream_audio_local_added':
            case 'm_stream_audio_local_removed':
            case 'm_stream_audio_remote_added':
            case 'm_stream_audio_remote_removed':
                {
                    break;
                }

            case 'i_ect_new_call':
                {
                    oSipSessionTransferCall = e.session;
                    break;
                }

            case 'i_ao_request':
                {
                    if(e.session == oSipSessionCall){
                        var iSipResponseCode = e.getSipResponseCode();
                        if (iSipResponseCode == 180 || iSipResponseCode == 183) {
                            startRingbackTone();
                            txtCallStatus.innerHTML = '<i>Remote ringing...</i>';
                        }
                    }
                    break;
                }

            case 'm_early_media':
                {
                    if(e.session == oSipSessionCall){
                        stopRingbackTone();
                        stopRingTone();
                        txtCallStatus.innerHTML = '<i>Early media started</i>';
                    }
                    break;
                }

            case 'm_local_hold_ok':
                {
                    if(e.session == oSipSessionCall){
                        if (oSipSessionCall.bTransfering) {
                            oSipSessionCall.bTransfering = false;
                            // this.AVSession.TransferCall(this.transferUri);
                        }
                        btnHoldResume.value = 'Resume';
                        btnHoldResume.disabled = false;
                        txtCallStatus.innerHTML = '<i>Call placed on hold</i>';
                        oSipSessionCall.bHeld = true;
                    }
                    break;
                }
            case 'm_local_hold_nok':
                {
                    if(e.session == oSipSessionCall){
                        oSipSessionCall.bTransfering = false;
                        btnHoldResume.value = 'Hold';
                        btnHoldResume.disabled = false;
                        txtCallStatus.innerHTML = '<i>Failed to place remote party on hold</i>';
                    }
                    break;
                }
            case 'm_local_resume_ok':
                {
                    if(e.session == oSipSessionCall){
                        oSipSessionCall.bTransfering = false;
                        btnHoldResume.value = 'Hold';
                        btnHoldResume.disabled = false;
                        txtCallStatus.innerHTML = '<i>Call taken off hold</i>';
                        oSipSessionCall.bHeld = false;

                        if (SIPml.isWebRtc4AllSupported()) { // IE don't provide stream callback yet
                            uiVideoDisplayEvent(true, true);
                            uiVideoDisplayEvent(false, true);
                        }
                    }
                    break;
                }
            case 'm_local_resume_nok':
                {
                    if(e.session == oSipSessionCall){
                        oSipSessionCall.bTransfering = false;
                        btnHoldResume.disabled = false;
                        txtCallStatus.innerHTML = '<i>Failed to unhold call</i>';
                    }
                    break;
                }
            case 'm_remote_hold':
                {
                    if(e.session == oSipSessionCall){
                        txtCallStatus.innerHTML = '<i>Placed on hold by remote party</i>';
                    }
                    break;
                }
            case 'm_remote_resume':
                {
                    if(e.session == oSipSessionCall){
                        txtCallStatus.innerHTML = '<i>Taken off hold by remote party</i>';
                    }
                    break;
                }

            case 'o_ect_trying':
                {
                    if(e.session == oSipSessionCall){
                        txtCallStatus.innerHTML = '<i>Call transfer in progress...</i>';
                    }
                    break;
                }
            case 'o_ect_accepted':
                {
                    if(e.session == oSipSessionCall){
                        txtCallStatus.innerHTML = '<i>Call transfer accepted</i>';
                    }
                    break;
                }
            case 'o_ect_completed':
            case 'i_ect_completed':
                {
                    if(e.session == oSipSessionCall){
                        txtCallStatus.innerHTML = '<i>Call transfer completed</i>';
                        btnTransfer.disabled = false;
                        if (oSipSessionTransferCall) {
                            oSipSessionCall = oSipSessionTransferCall;
                        }
                        oSipSessionTransferCall = null;
                    }
                    break;
                }
            case 'o_ect_failed':
            case 'i_ect_failed':
                {
                    if(e.session == oSipSessionCall){
                        txtCallStatus.innerHTML = '<i>Call transfer failed</i>';
                        btnTransfer.disabled = false;
                    }
                    break;
                }
            case 'o_ect_notify':
            case 'i_ect_notify':
                {
                    if(e.session == oSipSessionCall){
                        txtCallStatus.innerHTML = "<i>Call Transfer: <b>" + e.getSipResponseCode() + " " + e.description + "</b></i>";
                        if (e.getSipResponseCode() >= 300) {
                            if (oSipSessionCall.bHeld) {
                                oSipSessionCall.resume();
                            }
                            btnTransfer.disabled = false;
                        }
                    }
                    break;
                }
            case 'i_ect_requested':
                {
                    if(e.session == oSipSessionCall){                        
                        var s_message = "Do you accept call transfer to [" + e.getTransferDestinationFriendlyName() + "]?";//FIXME
                        if (confirm(s_message)) {
                            txtCallStatus.innerHTML = "<i>Call transfer in progress...</i>";
                            oSipSessionCall.acceptTransfer();
                            break;
                        }
                        oSipSessionCall.rejectTransfer();
                    }
                    break;
                }
        }
    }

</script>
<body style="cursor:wait" >
    <div class="navbar navbar-fixed-top" >
        <div id="divNavbarInner" class="navbar-inner">
            <div class="container">
<!--                 <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </a> -->
                
                  <input type="button" class="btn btn-success" id="btnRegister" value="Enable Calls " disabled onclick='sipRegister();' />
                            &nbsp;
                  
                   <input type="button" class="btn btn-danger" id="btnUnRegister" value="Go in Offline Mode " disabled onclick='dummyUnregister();' />
          		            &nbsp;
           <!--         <input type="button" class="btn btn-primary" value="Settings" onclick="parent.location='expert.htm'" />
          		            &nbsp; -->
          		            
          		   <button type="button" class="btn btn-primary" onclick='sipPublis("publish")' />Publish My Status
							</button>&nbsp;
							
					<button type="button" class="btn btn-primary" onclick='sipSubscribe()' />Check Status
							</button>&nbsp;
                                                     
                <div class="nav-collapse">
                    <ul class="nav">
                        <li class="active"><a href="index.html?svn=179"></a></li>
                    </ul>
                </div>
               
            </div>
        </div>
    </div> 
    <div class="container">
        <div class="row-fluid">
           
                <br />
                 <div style="display: none;">
                <!-- <div >  togge between dis and above -->
               <table style='width: 100%' type="hidden">
                    <tr>
 
                        <td>
                            <input type="text" style="width: 100%; height: 100%" id="txtDisplayName" 
                            value= <%=request.getParameter("name")%> type="hidden"  autocomplete='off'/>
                        </td>
                    </tr>
<%--                     <tr>

                        <td>
                            <input type="text" style="width: 100%; height: 100%" id="txtPrivateIdentity" 
                            value=<%=request.getParameter("name")%>   type="hidden"   autocomplete='off'/>
                        </td>
                    </tr>
                    <tr>

                        <td>
                            <input type="text" style="width: 100%; height: 100%" id="txtPublicIdentity" 
                            value=<%=request.getParameter("privateIdentity")%>   type="hidden"  autocomplete='off' />
                       </td>
                    </tr> 
--%>
                    
                    
                    <tr>
                        <td>
                            <input type="text" style="width: 100%; height: 100%" id="txtPrivateIdentity" 
                            value=<%=request.getParameter("publicIdentity")%>   type="hidden"   autocomplete='off'/>
                        </td>
                    </tr>
                    <tr>

                        <td>
                            <input type="text" style="width: 100%; height: 100%" id="txtPublicIdentity" 
                            value=<%=request.getParameter("privateIdentity")%>   type="hidden"  autocomplete='off' />
                       </td>
                    </tr> 
                    
                    
                    <tr>
                        <td>
                            <input type="password" style="width: 100%; height: 100%" id="txtPassword" 
                            value=<%=request.getParameter("password")%>  type="hidden"  autocomplete='off'/>
                        </td>
                    </tr>
                    <tr>

                        <td>
                            <input type="text" style="width: 100%; height: 100%" id="txtRealm" 
                            value=<%=request.getParameter("realm")%>  type="hidden"  autocomplete='off'/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right"></td>
                    </tr>
  
                </table>
            </div>
           
            <div id="maindiv" style="width:100%">
            <div id="calldiv" style="width:48%; float:left;">
            
            <!-- placwe for call div -->
               <div id="divCallCtrl" class="well"  > 
                
                <h3>
                    Call Control Box
                </h3>
                <br />
                
                <!-- user profile  image  -->
                
                <img src="<%=request.getContextPath() %>/CreateUserServlet1?id=<%=request.getParameter("privateIdentity")%>&action=getProfilePic" width="60" height="60" >
                           
                <!-- -------------- -->
                
                <%=request.getParameter("name")%> 
                <label id="txtRegStatus"></label>
                <label style="width:100%;" align="center" id="txtCallStatus"> </label>
                <table style="width:100%;">
                <div id="divCallCtrl"  >
                    <tr>
                     
                        <td style="white-space:nowrap;">
                       <input type="text" style="width: 100%; height:100%" id="txtPhoneNumber" value=""  />                           
                      
					   
		  
					  	                       
                        </td>
                         
                    </tr>
               
                    <tr>
                        <td colspan="1" align="right">
                        
                            <div class="btn-toolbar" style="margin: 0; vertical-align:middle">
                                <div id="divBtnCallGroup" class="btn-group">
                                    <button id="btnCall" disabled class="btn btn-primary" data-toggle="dropdown">Call</button>
                                </div>&nbsp;&nbsp;
                                <div class="btn-group">
                                    <input type="button" id="btnHangUp" style="margin: 0; vertical-align:middle; height: 100%;" class="btn btn-primary" value="HangUp" onclick='sipHangUp();' disabled />
                                </div>&nbsp;&nbsp;
                             </div>  
                         </td>               
						</tr>
				        <tr>
                        <td id="tdVideo" class='tab-video'>
                            <div id="divVideo" class='div-video'>
                                <div id="divVideoRemote" style='border:1px solid #000; height:100%; width:100%'>
                                    <video class="video" width="100%" height="100%" id="video_remote" autoplay="autoplay" style="opacity: 0; 
                                        background-color: #000000; -webkit-transition-property: opacity; -webkit-transition-duration: 2s;">
                                    </video>
                                </div>
                                <div id="divVideoLocal" style='border:0px solid #000'>
                                    <video class="video" width="88px" height="72px" id="video_local" autoplay="autoplay" muted="true" style="opacity: 0;
                                        margin-top: -80px; margin-left: 5px; background-color: #000000; -webkit-transition-property: opacity;
                                        -webkit-transition-duration: 2s;">
                                    </video>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                       <td align='center'>
                            <div id='divCallOptions' class='call-options' style='opacity: 0; margin-top: 3px'>
                                <input type="button" class="btn" style="" id="btnFullScreen" value="FullScreen" disabled onclick='toggleFullScreen();' /> &nbsp;
                                <input type="button" class="btn" style="" id="btnHoldResume" value="Hold" onclick='sipToggleHoldResume();' /> &nbsp;
                                <input type="button" class="btn" style="" id="btnTransfer" value="Transfer" onclick='sipTransfer();' /> &nbsp;
                                <input type="button" class="btn" style="" id="btnKeyPad" value="KeyPad" onclick='openKeyPad();' />
                            </div>
                        </td>
                    </tr>
                    	 </div>
                </table> 
       </div>
            
            
            </div>
            
           
            
            <div id="msgdiv" style="width:50%; float:right;">
            
               <!-- placwe for msg div -->
            
            <div id="divCallCtrl" class="well" style="display:table-cell; float:right;">
		                <h3>
		                 <left>   Message Control Box</left>
		                </h3>
			    <table border ="0">
				<tr><td width="50px">To:</td><td><input type="text" id="uri" placeholder="Enter username eg: John" onblur="chatValidation();" /></td></tr>
				<tr><td width="50px"></td><td><div class="chatbox" id="sipMsgs" style="width: 220px;height: 104px;overflow: auto;border: 1px solid gray;background-color: white;"></div></td></tr>		
				<tr><td width="50px">Chat:</td><td><input type="text" id="msg" placeholder="Press enter to submit" onKeyPress="enterpressalert(event)"/></td>
				<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				</table>
			</div>
            </div>
            
            
            </div>
            	
         
        </div>
        <!-- message portion -->
        
        <input type="hidden" id ="uRIContactPage" value="<%=request.getParameter("ToCallName")%>"> 
            
			
        
        
        <!--  Message  -->
        <!--  <table border ="0">
					<tr>   <td>To      : <input type="text" id="uri"/> <td> </tr>

					<tr>    <td>Window : <textarea id="textArea" disabled="disabled"  rows="8" cols="50"></textarea>	</td> </tr>	
						
					<tr>	<td>Message: <input type="text" id="msg"/>

							<button type="button" class="btn btn-primary" onclick='sipIM("message")'/>chat</button> </td>
					</tr>
		</table>-->
		
<!-- 		 Publish  Subscribe
		<table>
			<tr>
				<td><button type="button" class="btn btn-primary" onclick='sipPublis("publish")' />Publish My Status
							</button>
				</td>
			
		
					<td>
						<button type="button" class="btn btn-primary" onclick='sipSubscribe()' />Check Status
							</button>
					</td>
	        </tr>
		</table> -->
		<h3 align="center" id="serverReply"></h3>	
				
        <br />
        <footer>
       
            <!-- Creates all ATL/COM objects right now 
                Will open confirmation dialogs if not already done
            -->
            <object id="fakeVideoDisplay" classid="clsid:5C2C407B-09D9-449B-BB83-C39B7802A684" style="visibility:hidden;"> </object>
            <object id="fakeLooper" classid="clsid:7082C446-54A8-4280-A18D-54143846211A" style="visibility:hidden;"> </object>
            <object id="fakeSessionDescription" classid="clsid:DBA9F8E2-F9FB-47CF-8797-986A69A1CA9C" style="visibility:hidden;"> </object>
            <object id="fakeNetTransport" classid="clsid:5A7D84EC-382C-4844-AB3A-9825DBE30DAE" style="visibility:hidden;"> </object>
            <object id="fakePeerConnection" classid="clsid:56D10AD3-8F52-4AA4-854B-41F4D6F9CEA3" style="visibility:hidden;"> </object>
            <!-- 
        try {
                NPAPI  browsers: Safari, Opera and Firefox
            -->
            <!--embed id="WebRtc4npapi" type="application/w4a" width='1' height='1' style='visibility:hidden;' /-->
        </footer>
    </div>
    <!-- /container -->

    <!-- Glass Panel -->
    <div id='divGlassPanel' class='glass-panel' style='visibility:hidden'></div>
    <!-- KeyPad Div -->
    <div id='divKeyPad' class='span2 well div-keypad' style="left:0px; top:0px; width:250; height:240; visibility:hidden">
        <table style="width: 100%; height: 100%">
            <tr><td><input type="button" style="width: 33%" class="btn" value="1" onclick="sipSendDTMF('1');"/><input type="button" style="width: 33%" class="btn" value="2" onclick="sipSendDTMF('2');"/><input type="button" style="width: 33%" class="btn" value="3" onclick="sipSendDTMF('3');"/></td></tr>
            <tr><td><input type="button" style="width: 33%" class="btn" value="4" onclick="sipSendDTMF('4');"/><input type="button" style="width: 33%" class="btn" value="5" onclick="sipSendDTMF('5');"/><input type="button" style="width: 33%" class="btn" value="6" onclick="sipSendDTMF('6');"/></td></tr>
            <tr><td><input type="button" style="width: 33%" class="btn" value="7" onclick="sipSendDTMF('7');"/><input type="button" style="width: 33%" class="btn" value="8" onclick="sipSendDTMF('8');"/><input type="button" style="width: 33%" class="btn" value="9" onclick="sipSendDTMF('9');"/></td></tr>
            <tr><td><input type="button" style="width: 33%" class="btn" value="*" onclick="sipSendDTMF('*');"/><input type="button" style="width: 33%" class="btn" value="0" onclick="sipSendDTMF('0');"/><input type="button" style="width: 33%" class="btn" value="#" onclick="sipSendDTMF('#');"/></td></tr>
            <tr><td colspan=3><input type="button" style="width: 100%" class="btn btn-medium btn-danger" value="close" onclick="closeKeyPad();" /></td></tr>
        </table>
    </div>
    <!-- Call button options -->
    <ul id="ulCallOptions" class="dropdown-menu" style="visibility:hidden">
        <li><a href="#" onclick='sipCall("call-audio");'>Audio</a></li>
        <li><a href="#" onclick='sipCall("call-audiovideo");'>Video</a></li>
<!--         <li id='liScreenShare' ><a href="#" onclick='sipCall("call-screenshare");'>Screen Share</a></li>
        <li class="divider"></li>
        <li><a href="#" onclick='uiDisableCallOptions();'><b>Disable these options</b></a></li> -->
    </ul>

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="./assets/js/jquery.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-transition.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-alert.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-modal.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-dropdown.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-scrollspy.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-tab.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-tooltip.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-popover.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-button.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-collapse.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-carousel.js"></script>
    <script type="text/javascript" src="./assets/js/bootstrap-typeahead.js"></script>
    <script type="text/javascript" src="./assets/js/jquery.min.js"></script>
	<script type="text/javascript" src="./assets/js/jquery.gemoticons.js"></script>

    <!-- Audios -->
    <audio id="audio_remote" autoplay="autoplay" />
    <audio id="ringtone" loop src="sounds/ringtone.wav" />
    <audio id="ringbacktone" loop src="sounds/ringbacktone.wav" />
    <audio id="dtmfTone" src="sounds/dtmf.wav" />




</body>
</html>