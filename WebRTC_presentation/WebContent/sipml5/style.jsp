    <!-- Styles -->
    <link href="./assets/css/bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        body{
            padding-top: 80px;
            padding-bottom: 40px;
            background : url(../pageone/images/bg_blue.png) left top repeat ;
        }
        .navbar-inner-red {
        /*    background-color: #600000; 
          background-image: url('../pageone/images/bg_blue.png') repeat-x;
          background-repeat: no-repeat; */
          
          filter: none;
        }
        .full-screen{
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .normal-screen{
            position: relative;
        }
        .call-options {
          padding: 5px;
          background-color: #f0f0f0;
          border: 1px solid #eee;
          border: 1px solid rgba(0, 0, 0, 0.08);
          -webkit-border-radius: 4px;
          -moz-border-radius: 4px;
          border-radius: 4px;
          -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
          -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
          -webkit-transition-property: opacity;
          -moz-transition-property: opacity; 
          -o-transition-property: opacity; 
          -webkit-transition-duration: 2s;
          -moz-transition-duration: 2s;
          -o-transition-duration: 2s;
        }
        .tab-video,
        .div-video{
            width: 100%; 
            height: 0px; 
            -webkit-transition-property: height;
            -moz-transition-property: height;
            -o-transition-property: height;
            -webkit-transition-duration: 2s;
            -moz-transition-duration: 2s;
            -o-transition-duration: 2s;
        }
        .label-align {
            display: block;
            padding-left: 15px;
            text-indent: -15px;
        }
        .input-align {
            width: 13px;
            height: 13px;
            padding: 0;
            margin:0;
            vertical-align: bottom;
            position: relative;
            top: -1px;
            *overflow: hidden;
        }
        .glass-panel{
            z-index: 99;
            position: fixed;
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            top: 0;
            left: 0;
            opacity: 0.8;
            background-color: Gray;
        }
        .div-keypad {
            z-index: 100;
            position: fixed;
            -moz-transition-property: left top;
            -o-transition-property: left top;
            -webkit-transition-duration: 2s;
            -moz-transition-duration: 2s;
            -o-transition-duration: 2s;
        }
        
    </style>
    <link href="./assets/css/bootstrap-responsive.css" rel="stylesheet" />
    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="./assets/ico/favicon.ico" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="./assets/ico/apple-touch-icon-114-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="./assets/ico/apple-touch-icon-72-precomposed.png" />
    <link rel="apple-touch-icon-precomposed" href="./assets/ico/apple-touch-icon-57-precomposed.png" />
    <link href="./assets/style/gemoticons.css" type="text/css" rel="stylesheet" />