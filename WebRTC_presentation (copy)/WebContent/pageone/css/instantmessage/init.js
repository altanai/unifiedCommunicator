$(document).ready(function(){

  // Global variables.
  PageTitle = "WebRTC";
  document.title = PageTitle;

  register_checkbox = $("#phone > .status #register");
  phone_dialed_number_screen = $("#phone > .controls  input.destination");
  phone_call_button = $("#phone > .controls > .dialbox > .dial-buttons > .call");
  phone_chat_button = $("#phone > .controls > .dialbox > .dial-buttons > .chat");
  phone_dialpad_button = $("#phone > .controls > .dialpad .button");
  soundPlayer = document.createElement("audio");
  soundPlayer.volume = 1;


  // Local variables.

  var sip_uri = null;
  var sip_password = null;
  var ws_servers = null;

  var ws_was_connected = false;

  var login_form = $("#login-form");
  var login_inputs = $("#login-form input");
  var login_sip_uri = $("#login-form input#sip_uri");
  var login_sip_password = $("#login-form input#sip_password");
  var login_ws_servers = $("#login-form input#ws_servers");
  var login_Y_U_NO = $("#Y_U_NO");
  var login_Y_U_NO_text = $("#Y_U_NO p");
  var login_advanced_settings_link = $("#advanced-settings-link a");
  var login_advanced_settings = $("#advanced-settings");
  var login_advanced_settings_close = $("#advanced-settings .close");
  var login_advanced_settings_form = $("#advanced-settings-form");

  var theme01 = $("#themes > div.theme01");
  var theme02 = $("#themes > div.theme02");
  var theme03 = $("#themes > div.theme03");
  var theme04 = $("#themes > div.theme04");


  // Initialization.
  $("#login-page").height($(window).height());
  $("#login-page").width($(window).width());
  login_sip_uri.focus();

  $(window).resize(function(event) {
    $("#login-page").height($(window).height());
    $("#login-page").width($(window).width());
  });

  login_advanced_settings_link.click(function() {
    login_advanced_settings.fadeIn(300);
  });

  login_advanced_settings_close.click(function() {
    login_advanced_settings.fadeOut(300);
  });

  login_form.submit(function() {
    login_advanced_settings.hide();
    try {
      phone_init();
    } catch(err) {
      console.warn(err.toString());
      alert(err.toString());
    }
    return false;
  });

  login_advanced_settings_form.submit(function() {
    login_advanced_settings.hide();
    try {
      phone_init();
    } catch(err) {
      console.warn(err.toString());
      alert(err.toString());
    }
    return false;
  });

  theme01.click(function(event) {
    $("body").removeClass();
    $("body").addClass("bg01");
  });

  theme02.click(function(event) {
    $("body").removeClass();
    $("body").addClass("bg02");
  });

  theme03.click(function(event) {
    $("body").removeClass();
    $("body").addClass("bg03");
  });

  theme04.click(function(event) {
    $("body").removeClass();
    $("body").addClass("bg04");
  });


  register_checkbox.change(function(event) {
    if ($(this).is(":checked")) {
      console.warn("register_checkbox has been checked");
      // Don't change current status for now. Registration callbacks will do it.
      register_checkbox.attr("checked", false);
      // Avoid new change until the registration action ends.
      register_checkbox.attr("disabled", true);
      MyPhone.register();
    }
    else {
      console.warn("register_checkbox has been unchecked");
      // Don't change current status for now. Registration callbacks will do it.
      register_checkbox.attr("checked", true);
      // Avoid new change until the registration action ends.
      register_checkbox.attr("disabled", true);
      MyPhone.unregister();
    }
  });

  // NOTE: Para hacer unregister_all (esquina arriba-dcha un cuadro
  // transparente de 20 x 20 px).
  $("#unregister_all").click(function() {
    MyPhone.unregister({'all': true});
  });

  // NOTE: Para desconectarse/conectarse al WebSocket.
  $("#ws_reconnect").click(function() {
    if (MyPhone.transport.connected)
      MyPhone.transport.disconnect();
    else
      MyPhone.transport.connect();
  });

  phone_call_button.click(function(event) {
    GUI.phoneCallButtonPressed();
  });

  phone_chat_button.click(function(event) {
    GUI.phoneChatButtonPressed();
  });

  phone_dialpad_button.click(function() {
    if ($(this).hasClass("digit-asterisk"))
      sound_file = "asterisk";
    else if ($(this).hasClass("digit-pound"))
      sound_file = "pound";
    else
      sound_file = $(this).text();
    soundPlayer.setAttribute("src", "sounds/dialpad/" + sound_file + ".ogg");
    soundPlayer.play();

    phone_dialed_number_screen.val(phone_dialed_number_screen.val() + $(this).text());
    //phone_dialed_number_screen.focus();
  });

  phone_dialed_number_screen.keypress(function(e) {
     // Enter pressed? so Dial.
    if (e.which == 13)
      GUI.phoneCallButtonPressed();
  });


  function Y_U_NO(text, timeout) {
    timeout = timeout || 2000;

    login_Y_U_NO_text.text(text);
    login_Y_U_NO.show();
    login_Y_U_NO.fadeOut(timeout, function() {
      $(this).hide();
    });

    login_inputs.prop('disabled', true);
    window.setTimeout(function() {
        login_inputs.prop('disabled', false);
        login_Y_U_NO.hide();
      },
      timeout
    );
  }


  function phone_init() {
    if (login_sip_uri.val() != "")
      sip_uri = login_sip_uri.val();
    if (login_sip_password.val() != "")
      sip_password = login_sip_password.val();
    if (login_ws_servers.val() != "") {
      ws_servers = login_ws_servers.val();
      // To JSON (in case of a simple string we must enclose between ").
      if (ws_servers) {
        if (ws_servers.charAt(0) != "[")
          ws_servers = '"' + ws_servers + '"'
        ws_servers = window.JSON.parse(ws_servers);
      }
    }

    if (! sip_uri) {
      Y_U_NO("Y U NO SIP URI ?");
      return false;
    }
    else if (! ws_servers) {
      Y_U_NO("Y U NO WS URI ?");
      return false;
    }

    // Advanced Settings.

    var display_name = $("#advanced-settings-form input[name$='display_name']").val();

    var authorization_user = $("#advanced-settings-form input[name$='authorization_user']").val();

    var register = $("#advanced-settings-form input[name$='register']").is(':checked');

    var register_expires = window.parseInt($("#advanced-settings-form input[name$='register_expires']").val());

    var no_answer_timeout = window.parseInt($("#advanced-settings-form input[name$='no_answer_timeout']").val());

    var trace_sip = $("#advanced-settings-form input[name$='trace_sip']").is(':checked');

    var stun_servers = $("#advanced-settings-form input[name$='stun_servers']").val();
    // To JSON (in case of a simple string we must enclose between ").
    if (stun_servers) {
      if (stun_servers.charAt(0) != "[")
        stun_servers = '"' + stun_servers + '"'
      stun_servers = window.JSON.parse(stun_servers);
    }

    var turn_servers = $("#advanced-settings-form input[name$='turn_servers']").val();
    // To JSON (in case of a simple string we must enclose between ").
    if (turn_servers) {
      if (turn_servers.charAt(0) != "[")
        turn_servers = '"' + turn_servers + '"'
      turn_servers = window.JSON.parse(turn_servers);
    }

    var use_preloaded_route = $("#advanced-settings-form input[name$='use_preloaded_route']").is(':checked');

    var connection_recovery_min_interval = window.parseInt($("#advanced-settings-form input[name$='connection_recovery_min_interval']").val());

    var connection_recovery_max_interval = window.parseInt($("#advanced-settings-form input[name$='connection_recovery_max_interval']").val());

    var hack_via_tcp = $("#advanced-settings-form input[name$='hack_via_tcp']").is(':checked');

    var hack_ip_in_contact = $("#advanced-settings-form input[name$='hack_ip_in_contact']").is(':checked');

    var configuration  = {
      uri: sip_uri,
      password:  sip_password,
      ws_servers:  ws_servers,
      display_name: display_name,
      authorization_user: authorization_user,
      register: register,
      register_expires: register_expires,
      no_answer_timeout: no_answer_timeout,
      trace_sip: trace_sip,
      stun_servers: stun_servers,
      turn_servers: turn_servers,
      use_preloaded_route: use_preloaded_route,
      connection_recovery_min_interval: connection_recovery_min_interval,
      connection_recovery_max_interval: connection_recovery_max_interval,
      hack_via_tcp: hack_via_tcp,
      hack_ip_in_contact: hack_ip_in_contact
    };

    try {
      MyPhone = new JsSIP.UA(configuration);
    } catch(e) {
      console.log(e.toString());
      Y_U_NO(e.message, 4000);
      return;
    }

    $("#phone > .status .user").text(sip_uri);
    phone_dialed_number_screen.focus();

    // Transport connection/disconnection callbacks
    MyPhone.on('connected', function(e) {
      document.title = PageTitle;
      GUI.setStatus("connected");
      // Habilitar el phone.
      $("#phone .controls .ws-disconnected").hide();

      ws_was_connected = true;
    });

    MyPhone.on('disconnected', function(e) {
      document.title = PageTitle;
      GUI.setStatus("disconnected");
      // Deshabilitar el phone.
      $("#phone .controls .ws-disconnected").show();
      // Eliminar todas las sessiones existentes.
      $("#sessions > .session").each(function(i, session) {
        GUI.removeSession(session, 500);
      });

      if (! ws_was_connected) {
        alert("WS connection error:\n\n- WS close code: " + e.data.code + "\n- WS close reason: " + e.data.reason);
        window.location.reload(false);
      }
    });

    // Call/Message reception callbacks
    MyPhone.on('newSession', function(e) {
      GUI.new_session(e)
    });

    MyPhone.on('newMessage', function(e) {
      GUI.new_message(e)
    });

    // Registration/Deregistration callbacks
    MyPhone.on('registered', function(e){
      console.info('Registered');
      GUI.setStatus("registered");
    });

    MyPhone.on('unregistered', function(e){
      console.info('Deregistered');
      GUI.setStatus("connected");
    });

    MyPhone.on('registrationFailed', function(e) {
      console.info('Registration failure');
      GUI.setStatus("connected");

      if (! e.data.response) {
        alert("SIP registration error:\n" + e.data.cause);
      }
      else {
        alert("SIP registration error:\n" + e.data.response.status_code.toString() + " " + e.data.response.reason_phrase)
      }
      window.location.reload(false);
    });

    // Start
    MyPhone.start();

    // Remove login page.
    $("#login-page").fadeOut(1000, function() {
      $(this).remove();
    });

    // Piwik stuff
    try {
      var piwikTracker = Piwik.getTracker("http://www.aliax.net/piwik/piwik.php", 6);
      // http://piwik.org/docs/custom-variables/
      piwikTracker.setCustomVariable(1, "sip_uri", sip_uri, "page");
      piwikTracker.setCustomVariable(2, "ws_servers", ws_servers, "page");
      // end
      piwikTracker.trackPageView();
      piwikTracker.enableLinkTracking();
    } catch( err ) {}
  }

});
