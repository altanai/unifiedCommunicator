
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
<head>
<meta charset=utf-8 />
<meta name="description" content="SpeakPipe allows your customers, podcast listeners, blog readers and fans to send you voice messages (voicemail) right from a browser without any phone calls.">
<meta name="google-site-verification" content="AYmekjdreagdIBXM-_VTvuDNj_8ZIWJ9_br3_i3rRA8" />

<meta property="og:image" content="http://www.speakpipe.com/static/img/speakpipe-logo.png"/>


<link href="http://www.speakpipe.com/static/css/styles.css?337" rel="stylesheet" type="text/css" />    
<script type="text/javascript" src="http://www.speakpipe.com/static/js/assets/jquery1.6.min.js"></script>

<script>
function readCookie(name) {
    //http://www.quirksmode.org/js/cookies.html
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}
    
function saveReferer() {
    var r = document.referrer;
    if (r) {
        var existingVal = readCookie('src_referer');
        if (!existingVal) {
            var host = r.split('/')[2];
            if (host) {
                host = host.toLowerCase();
                if (!host.match('speakpipe.com$')) {
                    document.cookie = 'src_referer=' + r + '; expires=31 Dec 2020 20:47:11 UTC; path=/';                    
                }
            }
        }
    }
}

$(document).ready(function(){
    saveReferer();
});

</script>




<script type="text/javascript" src="http://www.speakpipe.com/static/js/assets/jquery.jplayer.min.js"></script>

<script type="text/javascript">

var _spPlaylist = function(){    
    var _msgList;    
    var _jp;
    var _currentMsgId;
    var _isPlaying = false;
    var _isSent = true;
    
    function markListened(msgId){
        var msgBox = $('#box-' + msgId);
        var msgBoxAttr = msgBox.attr('class');
        var newMsgFlag = 'new-msg';
        if(!_isSent && msgBoxAttr.indexOf(newMsgFlag) != -1){                        
            var _url = '/messages/mark_listened';
            var msg = _msgList[msgId];
            if(msg){                
                var siteId = msg.siteId;
                var intMsgId = msgId.substring(3);                                    
                $.post(_url, {'site_id': siteId, 'msg_id': intMsgId, 'msg_key': msg.nameKey },
                        function(data){
                            //alert('set new');
                            var newAttr = msgBoxAttr.replace(newMsgFlag, '');
                            msgBox.attr('class', newAttr);                        
                        },
                        'json');
            }
        }
    }
    
    function onPlay(){        
        setButtonState('Pause');
        _isPlaying = true;
        markListened(_currentMsgId);
    }
    
    function onPause(){
        setButtonState('Play');
        _isPlaying = false;
    }
    
    function onEnded(){
        _isPlaying = false;        
        setButtonState('Play');        
        if(getAutoplayNextMsg()){
            onNextMsgClick();
        }
    }
    
    function setButtonState(state){        
        if(_currentMsgId){
            var bt = $('#' + _currentMsgId);
            if(state === 'Pause'){
                bt.attr('class', 'pause-voice-msg');
            }
            else{
                bt.attr('class', 'play-voice-msg');
            }            
        }
    }
    
    function getDirectAudioUrl(audioUrl){
        var result = audioUrl;
        //$.get(audioUrl, { 'use_ajax': 1},
        //        function(data){
        //            result = data;
        //            alert(result);
        //        });
        
        $.ajax({
            url: audioUrl,
            data: 'use_ajax=1',
            success: function(r) {
                result = r;
                //alert(r);
            },
            async: false
        });        
        
        return result;
    }
    
    function setCurrentMsg(msgId, readyCallback){
        if(msgId){
            var msg = _msgList[msgId];
            
            setAudioFormat(msg.format, function(){                
                var audioUrl = msg.url;
                _currentMsgId = msgId;
                var p = {};
                p[msg.format] = getDirectAudioUrl(audioUrl);
                _jp.jPlayer("setMedia", p);
                
                var msgIdSel = '.msg_id';
                var creationDateSel = '.msg_creation_date';
                var msgInfoBox = $('#player_msg_info');
                var msgBox = $('#box-' + msgId);
                msgInfoBox.find(msgIdSel).text(msgBox.find(msgIdSel).text());
                msgInfoBox.find(creationDateSel).text(msgBox.find(creationDateSel).text());
                if(readyCallback){
                    readyCallback();
                }
            });            
        }
    }
    
    function selectMsg(msgId){
        
        function _playMsg(mId){
            setCurrentMsg(mId, function(){
                _jp.jPlayer("play");
            });            
        }
        
        if(_isPlaying){
            _jp.jPlayer("pause");
            setButtonState('Play');
            if(msgId != _currentMsgId){
                _playMsg(msgId);
            }            
        }
        else{
            _playMsg(msgId);
        }        
    }
    
    function onMsgClick(e){
        e.preventDefault();
        var msgId = $(this).attr("id");
        selectMsg(msgId);
    }
            
    function onNextMsgClick(e){
        selectMsg(getMsg(_currentMsgId));
    }
    
    function onPrevMsgClick(e){
        selectMsg(getMsg(_currentMsgId, true));
    }
    
    function getMsg(currentMsgId, prev){
        var msgId;
        var returnNext = !currentMsgId;
        var prevMsgId;
        $.each(_msgList, function(key, value) {                        
            if(returnNext){
                msgId = key;            
                return false;
            }
            else{
                if(key === currentMsgId){
                    if(prev){
                        if(prevMsgId){
                            msgId = prevMsgId;
                        }
                        else{
                            msgId = key;
                        }
                        return false;
                    }
                    else{
                        returnNext = true;
                    }
                }
            }
            prevMsgId = key;
        });
        return msgId;
    }
    
    
    
    function deleteMsg(){
        var delMsgId = $(this).attr("id");
        var dlgId = "#delete-msg-dialog";
        var dialog = $(dlgId);
        //http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen
        //dialog.css("top", (($(window).height() - dialog.outerHeight()) / 2) + $(window).scrollTop() + "px");
        //dialog.css("left", (($(window).width() - dialog.outerWidth()) / 2) + $(window).scrollLeft() + "px");
        var msgId = delMsgId.replace('delete-msg', '');
        var msg = _msgList['msg' + msgId];
        if(msg){
            dialog.find('.msg_id').val(msgId);
            dialog.find('.site_id').val(msg.siteId);
            //dialog.show();
            showDialog(dlgId);
        }
        return false;
    }
    
    function setAutoplayNextMsg(value){
        //alert(value);
    }
    
    function getAutoplayNextMsg(){
        return false;
    }
    
    function init(msgList){        
        _msgList = msgList;
        setCurrentMsg(getMsg());
        
        $('.play-voice-msg').click(onMsgClick);
        $('.jp-next').click(onNextMsgClick);
        $('.jp-previous').click(onPrevMsgClick);
        
        $('.delete-voice-msg').click(deleteMsg);
        
        var dialog = $("#delete-msg-dialog");
        dialog.find('.bt-cancel').click(function(){
            dialog.hide(); });        
        dialog.find('.bt-delete').click(function(){
             });
        
        $('#autoplay-next-msg').change(function() {
            if ($(this).is(':checked')) {
                setAutoplayNextMsg(true);
            }
            else{
                setAutoplayNextMsg(false);
            }
        });
        
        $('.set-bookmark-btn').click(function(){
            var el = $(this);
            var msgId = el.attr('data-msg-id');            
            var msg = _msgList['msg' + msgId];
            var p = { site_id: msg.siteId, audio_id: msgId, name_key: msg.nameKey };
            isBookmarked = el.hasClass('bookmarked');
            p['is_bookmarked'] = isBookmarked;
            //alert($(this).hasClass('bookmarked'));
            $.post('/messages/set-bookmark', p,
                function(result){
                    if(result.success){
                        if(result.bookmarked){
                            el.text('unbookmark');
                            el.addClass('bookmarked');
                        }
                        else{
                            el.text('bookmark');
                            el.removeClass('bookmarked');
                        }
                        //alert('success');
                    }
                }, 'json')
            //alert(msg.siteId);
            return false;
        });            
        
    }
    
    var _currentAudioFormat = null;
    
    function setAudioFormat(audioFormat, readyCallback){
        function __ready(){
            if(readyCallback){                
                readyCallback();
            }            
        }
                
        if(_currentAudioFormat != audioFormat){
            if(_currentAudioFormat){
                $("#jquery_jplayer_1").jPlayer("destroy");
            }            
            //re-initialize jPlayer with new audioFormat
            $("#jquery_jplayer_1").jPlayer({
                ready: function(){                    
                    _jp = $("#jquery_jplayer_1");
                    _jp.bind($.jPlayer.event.play, onPlay);
                    _jp.bind($.jPlayer.event.pause, onPause);
                    _jp.bind($.jPlayer.event.ended, onEnded);
                    __ready();
                    
                },
                cssSelectorAncestor: '#speakpipe-player',
                swfPath: "/static/flash",
                supplied: audioFormat,
                wmode: "window",                
                errorAlerts: false
            });
            _currentAudioFormat = audioFormat;
        }
        else{
            //jPlayer already initialized, just call callback
            __ready();
        }
    }
    
    function setIsSent(isSent){
        _isSent = isSent;
    }
    
    return {
        init: init,
        setIsSent: setIsSent
    }    
}();

function showDialog(id){
    var dialog = $(id);
    //http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen
    dialog.css("top", (($(window).height() - dialog.outerHeight()) / 2) + $(window).scrollTop() + "px");
    dialog.css("left", (($(window).width() - dialog.outerWidth()) / 2) + $(window).scrollLeft() + "px");
    dialog.show();
}

function showSendMsgToEmailDialog(sitePublicToken){
    if(_speakpipe_open_to_email_dialog){
        _speakpipe_open_to_email_dialog(sitePublicToken);
    }
}

function replyToMsg(sitePublicToken, parentAudioKey, parentAudioId, userId){
    if(_speakpipe_open_reply_dialog){
        _speakpipe_open_reply_dialog(sitePublicToken, parentAudioKey, parentAudioId, userId);
    }
}

$(document).ready(function(){
        _spPlaylist.setIsSent(false);
    
    
    _spPlaylist.init({
            
        'msg6': { url: 'http://www.speakpipe.com/msg/lwwfji689aar4vgu/vmpft32qarjnhab4', format: 'mp3', siteId: 37343, nameKey: 'vmpft32qarjnhab4' },            
     
    });    
    
});

//http://groups.google.com/group/jplayer/browse_thread/thread/114a2fa0ded5b238?pli=1

</script>


</head>
<body>
    
<div class="wrapper">
    
    <div class="main_header">
    <div class="page_container">        
                <div class="menu_block">

                    <a style="text-decoration: none; font-weight: bold; color: #FF6600;" href="/account/subscription"></a>
                    -
                    <a class="user_email" href="/messages">tcscns@gmail.com</a>
                    -
                    <a href="/messages">Inbox</a>
                    -                    
                    <a href="/account/settings/widget">Settings</a>
                    -
                    <a href="/signout">Logout</a>
                </div>

    </div>
    </div>


    
<div class="page_container">
    
<div class="inbox-content">
    <div class="fixed-sidebar">


        
            <a class="flat-button" href="#" onclick="showSendMsgToEmailDialog('nokuo3egp3ms222n6ng52aib0jb2pm6p'); return false;">
                Send a voice message to email
            </a>
        
        <div id="speakpipe-player" class="sp-player">
            <div id="player_msg_info">
                <div class="msg_id">*</div>
                <div class="msg_creation_date">.</div>
                
            </div>
            <ul>
                <li><a class="jp-previous" href="javascript:;">Prev</a></li>
                <li><a class="jp-play" href="javascript:;">Play</a></li>
                <li><a class="jp-pause" href="javascript:;">Pause</a></li>
                <li><a class="jp-next" href="javascript:;">Next</a></li>
                <li><a class="jp-stop" href="javascript:;">Stop</a></li>
                <li class="volume">
                    <div class="jp-volume-bar">
                        <div class="jp-volume-bar-value"></div>
                    </div>
                </li>
            </ul>
            <div class="clear"></div>
            <div class="jp-progress">
                <div class="jp-seek-bar">
                    <div class="jp-play-bar">
                    </div>                
                </div>
            </div>
            <div class="jp-time-holder">
                <div class="jp-current-time"></div>
                <div class="jp-duration"></div>
                <div class="clear"></div>
            </div>
        </div>
 
        
    </div>

    <div id="jquery_jplayer_1" class="jp-jplayer"></div>
    
    <div class="voice-messages">
                <div class="go-sent-msgs">
                    <a href="http://www.speakpipe.com/messages/bookmarks">Bookmarks</a> - <a href="/messages/sent">Sent messages</a>
                </div>                    
                <h1>Received messages <a href="/messages">refresh</a></h1>
            
            <div style="display: none">
                Your browser doesn't support playing audio. You need to update your browser or use the latest version of Firefox or Google Chrome.
            </div>
            
                    
    <div id="box-msg6"
            class="voice-msg new-msg">
        
        <div class="msg-action">
            
                <a href="#" class="set-bookmark-btn " data-msg-id="6">
                        bookmark
                </a>                
            <div>
                <a href="http://www.speakpipe.com/msg/lwwfji689aar4vgu/vmpft32qarjnhab4">download</a>
            </div>
                <div>
                    <a id="delete-msg6" class="delete-voice-msg" href="#">delete</a>
                </div> 

        </div>
        
        <a id="msg6" class="play-voice-msg" href="#">Play</a>
        <div class="voice-msg-info">
            <div>
                    Anonymous
            </div>
            
            <div style="font-size: 14px; color: #444; margin: 2px 0;">
                <!--
                <span class="msg_id">
                    Message #6</span>                
                -
                Sent from SpeakPipe app for iPad
                -->
                <!--Duration:-->
                <span class="msg_duration">00:01</span>                            
                -
                <span class="msg_creation_date">36 seconds ago</span>
                - <span>#6</span>                
            </div>
                                    
            <div class="voice-msg-referer">
                            <b>Site:</b> <a href="https://www.speakpipe.com/tcscns">https://www.speakpipe.com/tcscns</a>
                <div>
                <!--Sent from SpeakPipe app for iPad-->
                </div>
            </div>
        </div>
        <div class="clear"></div>
        
        
    </div>  
                

    </div>
    
    <div id="delete-msg-dialog" class="dialog">
        <div class="dialog-title">
            Delete the voice message
        </div>        
        <div class="dialog-content">
            Are you sure you want to delete the selected message?
            There is no way to restore deleted messages.
            <form method="post" action="/messages/delete_msg">
                <input class="msg_id" type="hidden" name="msg_id" value="" />
                <input class="site_id" type="hidden" name="site_id" value="" />
                <div class="dialog-buttons">
                    <input class="bt-delete" type="submit" value="Delete"/>
                    <input class="bt-cancel" type="button" value="Cancel"/>
                </div>
            </form>
        </div>        
    </div>    
</div> 



</div>

    
    <div class="push"></div>
</div>




        
        <script type="text/javascript">
        
          var _gaq = _gaq || [];
          _gaq.push(['_setAccount', 'UA-28595697-1']);
          _gaq.push(['_trackPageview']);
        
          (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
          })();
        
        </script>


    <!-- Begin SpeakPipe code -->
    <script type="text/javascript">
    
    function speakpipeButtonLoaded(b){
        var i = document.getElementById('try_me_img');
        if(i){
            //i.style.visibility = 'visible';
        }        
    }
    
    (function(d){
    _speakpipeTabInitialized = speakpipeButtonLoaded;
    var app = d.createElement('script'); app.type = 'text/javascript'; app.async = true;    
    app.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'www.speakpipe.com/loader/zxs2hooq52lb908p2ylrbkjfps8sk7nj.js';
    var s = d.getElementsByTagName('script')[0]; s.parentNode.insertBefore(app, s);
    })(document);    
    </script>
    <!-- End SpeakPipe code -->
   
</body>    
</html>