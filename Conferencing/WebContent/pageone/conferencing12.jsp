
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>ALL Services in One</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <link rel="author" type="text/html" href="https://plus.google.com/100325991024054712503">
        <meta name="author" content="Pawan">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
       
        <link rel="stylesheet" href="css/style_blue.css" type="text/css" />
        
       
        
        <style>
            audio, video {
                -moz-transition: all 1s ease;
                -ms-transition: all 1s ease;
                
                -o-transition: all 1s ease;
                -webkit-transition: all 1s ease;
                transition: all 1s ease;
                vertical-align: top;
            }

            input {
                border: 1px solid #d9d9d9;
                border-radius: 1px;
              
                margin: .2em;
                width: 20%;
                
            }

            select {
                border: 1px solid #d9d9d9;
                border-radius: 1px;
                height: 50px;
                margin-left: 1em;
                margin-right: -12px;
                padding: 1.1em;
                vertical-align: 6px;
                
            }

            .setup {
                border-bottom-left-radius: 2;
                border-top-left-radius: 2;
                
                height: 47px;
                margin-left: -9px;
                margin-top: 1px;
                position: absolute;
            }

            p { padding: 1em; }

            #chat-output div, #file-progress div {
                border: 1px solid black;
                border-bottom: 0;
                padding: .1em .4em;
            }

            #chat-output, #file-progress {
                margin: 0 0 0 .4em;
                max-height: 12em;
                overflow: auto;
            }

            .data-box input {
                border: 1px solid black;
                font-family: inherit;
                font-size: 1em;
                margin: .1em .3em;
                outline: none;
                padding: .1em .2em;
                width: 97%;
            }
   
        </style>
        <script>
            document.createElement('article');
            document.createElement('footer');
        </script>
        
       
        <script src="https://www.webrtc-experiment.com/RTCMultiConnection-v1.4.js"> </script>
    </head>

    <body>
                
                <section style="margin-top:10px;">
                <h2 style="display: block;text-align:left; font-size: 1em;"><span style="color:#0370ea;">Conferencing Details</span></h2>
              <select id="session" title="Session">
                      <option selected>Select mode of Conferencing</option>
                        
                        <option>audio+video+data</option>						
                       
                   
                        <option >audio+video</option>
                        
                        <option>audio+data</option>
                        <option>video+data</option>
                        <option>audio</option>
                        <option>video</option>
                        <option>data</option>
                        
                    </select>
                    
                    
                    <select id="direction" title="Direction">
                          <option selected>Select way of Conferencing</option>
                        <option>many-to-many</option>
                        <option>one-to-one</option>
                        <option>one-to-many</option>
                        <option>one-way</option>
                        </table>
                    </select>
                    
                    <input type="text" id="session-name" placeholder="Create Conference Room" style="height:45px;text-align:center; margin-left:15px;margin-right:15px;margin-top:-8px;margin-down:47px;">
                    <button id="setup-new-session" class="setup">Click To Start Conferencing</button>
                </section>
                
                <!-- list of all available broadcasting rooms -->
                <table style="width: 100%;" id="rooms-list"></table>
                
                <!-- local/remote videos container -->
                <h2 style="display: block;text-align:left; font-size: 1em;"><span style="color:#0370ea;">Video Conferencing </span></h2>
                <div id="videos-container"></div>
            </section>
			
              <section class="experiment data-box">
                
                 <h2 style="display:block;text-align:left; font-size: 1em;"><span style="color:#0370ea;">Messaging And File Sharing</span></h2>
                <table style="width: 100%;">
                    <tr>
                        <td>
                          <h2 style="display: block; font-size: 1em; text-align:left;"><span style="color:#0370ea;">Text Chat</span></h2>

                            <div id="chat-output"></div>
                            <input type="text" id="chat-input" style="font-size: 1.2em;" placeholder="chat message" disabled>
                        </td>
                        <td>
                            <h2 style="display: block; font-size: 1em; text-align:left;"><span style="color:#0370ea;">Share Files </span></h2>
                            <input type="file" id="file"  disabled>

                            <div id="file-progress"></div>
                        </td>
                    </tr>
                </table>
            </section>
            <section></section>
            <section></section>
        
            <script>
               

                var connection = new RTCMultiConnection();
                connection.session = {
                    audio: true,
                    video: true
                };
                connection.enableSessionReinitiation = false;
                connection.openSignalingChannel = function(config) {
                    var channel = config.channel || this.channel;
                   
                    var sender = Math.round(Math.random() * 999999999) + 999999999;
                    var websocket = new WebSocket('ws:10.1.5.15:8888');
                    websocket.channel = config.channel || this.channel;
                    websocket.onopen = function() {
                        websocket.push(JSON.stringify({
                            open: true,
                            channel: websocket.channel
                        }));
                        if (config.callback) config.callback(websocket);
                    };
                    websocket.onmessage = function(event) {
                        config.onmessage(JSON.parse(event.data));
                    };
                    websocket.push = websocket.send;
                    websocket.send = function(data) {
                        websocket.push(JSON.stringify({
                            data: data,
                            channel: websocket.channel
                        }));
                    };
                

                   

                    
                
                    

                    //socket.on('message', config.onmessage);
                };

                var roomsList = document.getElementById('rooms-list'), sessions = { };
                connection.onNewSession = function(session) {
                    if (sessions[session.sessionid]) return;
                    sessions[session.sessionid] = session;

                    var tr = document.createElement('tr');
                    tr.innerHTML = '<td><strong>' + session.extra['session-name'] + '</strong> is an active session.</td>' +
                        '<td><button class="join">Join</button></td>';
                    roomsList.insertBefore(tr, roomsList.firstChild);

                    tr.querySelector('.join').setAttribute('data-sessionid', session.sessionid);
                    tr.querySelector('.join').onclick = function() {
                        this.disabled = true;

                        session = sessions[this.getAttribute('data-sessionid')];
                        if (!session) alert('No room to join.');

                        connection.join(session);
                    };
                };

                var videosContainer = document.getElementById('videos-container') || document.body;
                connection.onstream = function(e) {
                    videosContainer.insertBefore(e.mediaElement, videosContainer.firstChild);
                    rotateInCircle(e.mediaElement);
                };

                connection.onstreamended = function(e) {
                    if (e.mediaElement.parentNode) {
                        e.mediaElement.parentNode.removeChild(e.mediaElement);
                        scaleVideos();
                    }
                };

                var setupNewSession = document.getElementById('setup-new-session');

                setupNewSession.onclick = function() {
                    setupNewSession.disabled = true;

                    var direction = document.getElementById('direction').value;
                    var _session = document.getElementById('session').value;
                    var splittedSession = _session.split('+');

                    var session = { };
                    for (var i = 0; i < splittedSession.length; i++) {
                        session[splittedSession[i]] = true;
                    }

                    var maxParticipantsAllowed = 256;

                    if (direction == 'one-to-one') maxParticipantsAllowed = 1;
                    if (direction == 'one-to-many') session.broadcast = true;
                    if (direction == 'one-way') session.oneway = true;

                    var sessionName = document.getElementById('session-name').value;
                    connection.extra = {
                        'session-name': sessionName || 'Anonymous'
                    };

                    connection.session = session;
                    connection.maxParticipantsAllowed = maxParticipantsAllowed;
                    connection.open();
                };

                function rotateInCircle(video) {
                    video.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(0deg)';
                    setTimeout(function() {
                        video.style[navigator.mozGetUserMedia ? 'transform' : '-webkit-transform'] = 'rotate(360deg)';
                    }, 1000);
                    scaleVideos();
                }

                function scaleVideos() {
                    var videos = document.querySelectorAll('video'),
                        length = videos.length, video;
						
                    var minus = 130;
                    var windowHeight = 700;
                    var windowWidth = 600;
                    var windowAspectRatio = windowWidth / windowHeight;
                    var videoAspectRatio = 4 / 3;
                    var blockAspectRatio;
                    var tempVideoWidth = 0;
                    var maxVideoWidth = 0;

                    for (var i = length; i > 0; i--) {
                        blockAspectRatio = i * videoAspectRatio / Math.ceil(length / i);
                        if (blockAspectRatio <= windowAspectRatio) {
                            tempVideoWidth = videoAspectRatio * windowHeight / Math.ceil(length / i);
                        } else {
                            tempVideoWidth = windowWidth / i;
                        }
                        if (tempVideoWidth > maxVideoWidth)
                            maxVideoWidth = tempVideoWidth;
                    }
                    for (var i = 0; i < length; i++) {
                        video = videos[i];
                        if (video)
                            video.width = maxVideoWidth - minus;
                    }
                }

                window.onresize = scaleVideos;

                connection.onmessage = function(e) {
                    appendDIV(e.data);

                    console.debug(e.userid, 'posted', e.data);
                    console.log('latency:', e.latency, 'ms');
                };

                // on data connection gets open
                connection.onopen = function() {
                    if (document.getElementById('chat-input')) document.getElementById('chat-input').disabled = false;
                    if (document.getElementById('file')) document.getElementById('file').disabled = false;
                    if (document.getElementById('open-new-session')) document.getElementById('open-new-session').disabled = true;
                };

                // sending/receiving file(s)
                // connection.autoSaveToDisk = false;
                connection.onFileProgress = function(packets, uuid) {
                    appendDIV(uuid + ': ' + packets.remaining + '..', 'file', fileProgress);
                };

                connection.onFileSent = function(file) {
                    appendDIV(file.name + ' sent.', fileProgress);
                };

                connection.onFileReceived = function(fileName) {
                    appendDIV(fileName + ' received.', fileProgress);
                };

                document.getElementById('file').onchange = function() {
                    connection.send(this.files[0]);
                };

                var chatOutput = document.getElementById('chat-output'),
                    fileProgress = document.getElementById('file-progress');

                function appendDIV(data, parent) {
                    var div = document.createElement('div');
                    div.innerHTML = data;

                    if (!parent) chatOutput.insertBefore(div, chatOutput.firstChild);
                    else fileProgress.insertBefore(div, fileProgress.firstChild);

                    div.tabIndex = 0;
                    div.focus();

                    chatInput.focus();
                }

                var chatInput = document.getElementById('chat-input');
                chatInput.onkeypress = function(e) {
                    if (e.keyCode !== 13 || !this.value) return;
                    appendDIV(this.value);

                    // sending text message
                    connection.send(this.value);

                    this.value = '';
                    this.focus();
                };

                connection.connect();
            </script>
            
           
        
           
        
       
   
      
       
    
       
    </body>
</html>

