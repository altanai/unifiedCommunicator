<!-- ------google oauth  -->
 <form>
 <div id="gConnect">

<!--     <button class="g-signin"
        data-scope="https://www.googleapis.com/auth/plus.login"
        data-requestvisibleactions="http://schemas.google.com/AddActivity"
        data-clientId="573069363965-n7isi7nlupu7h1p5um4405475urmund7.apps.googleusercontent.com"
        data-callback="onSignInCallback"
        data-theme="dark"
        data-cookiepolicy="single_host_origin">
    </button> -->
    
      <button class="g-signin"
        data-scope="https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email"
        data-requestvisibleactions="http://schemas.google.com/AddActivity"
        data-clientId="573069363965-n7isi7nlupu7h1p5um4405475urmund7.apps.googleusercontent.com"
        data-callback="onSignInCallback"
        data-theme="dark"
        data-cookiepolicy="single_host_origin">
    </button>
    
  </div>
  
  <div id="authOps" style="display:none">
    <h4>User is now signed in to the app using Google+</h4>
    <button id="disconnect" >Disconnect your Google account from this app</button>
    <div id="profile"> profile :</div>
    <div id="visiblePeople"> visible people :</div>   
  </div>
  
  <div id="loaderror">
    This section will be hidden by JQuery. If you can see this message, you
    may be viewing the file rather than running a web server.<br />
    The sample must be run from http or https. See instructions at
    <a href="https://developers.google.com/+/quickstart/javascript">
    https://developers.google.com/+/quickstart/javascript</a>.
  </div>
  </form>
  
 </form>
 <!-- -end google oauth -->    