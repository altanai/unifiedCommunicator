            <!-- --facebook oauth -->

<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
  FB.init({
    appId      : '144771182399738', // App ID
    channelUrl : '//10.1.5.7:8080/WebRTC_presentation/pageone/login.jsp', // Channel File
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });

  //----------------- event is fired for any authentication related change, such as login, logout or session refresh. 
  FB.Event.subscribe('auth.authResponseChange', function(response) {

    if (response.status === 'connected') {
      testAPI();
    } 
    
    else if (response.status === 'not_authorized') {
      FB.login();
    }
    
    else {
      FB.login();
    }
  });
  };

  //--------------------------------------------- Load the SDK asynchronously
  (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
  }(document));

//----------------------------------------fetch info 
  function testAPI() {
    console.log('WebRTC FACEBBOK ..Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Good to see you, ' + response.name + '.');
      alert("logged in with facebook : "+ response.name );
      window.location.href = "http://10.1.5.7:8080/WebRTC_presentation/facebooklogin?userName="+response.name;
    });
  }
</script>

<fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>
<!-- ------end facebook oauth -->