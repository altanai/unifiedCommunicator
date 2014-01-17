
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
            audio, video {
                -moz-transition: all 1s ease;
                -ms-transition: all 1s ease;
                
                -o-transition: all 1s ease;
                -webkit-transition: all 1s ease;
                transition: all 1s ease;
                vertical-align: top;
            }

           /*  input {
                border: 1px solid #d9d9d9;
                border-radius: 1px;
              
                margin: .2em;
                width: 20%;
                
            } */

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
            .tab1{
            border: 0px;
            width: 670px;
            }
   
        </style>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <link rel="author" type="text/html" href="https://plus.google.com/100325991024054712503">
        <meta name="author" content="Pawan">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <link rel="stylesheet" href="css/style2.css" type="text/css" />
		<title>Insert title here</title>
</head>
<body>

<div style="margin-top:10px;">
                <h2 style="display: block;text-align:left; font-size: 1em;"><span style="color:#0370ea;">Conferencing Details</span></h2>
              	<select id="session" name="conferenceType" title="Session">
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
                        </select>
                    <input type="text" id="session-name" name="conferenceRoom" placeholder="Create Conference Room" style="height:45px;text-align:center; margin-left:15px;margin-right:15px;margin-top:-8px;margin-down:47px;">
				</div>
				<form action="" method="post">
				  <div style="background-color: gray;height: 400px;width: 450px">
                  <table>
                  <tr><td>User:</td><td><input type="text" id="Users" name="member" placeholder="Add Uses" style="height:45px;width:220px;text-align:center"></td></tr>
                  <tr><td>Password:</td><td><input type="password" name="confPwd" id="confPwd" placeholder="Type Password" style="height:45px;width:150px;text-align:center"></td></tr>
                  <tr><td>Date</td><td><input type="text" id="confDate" name="confDate" placeholder="Add Date" style="height:45px;width:150px;text-align:center"></td></tr>
                  <tr><td>Time</td><td><select id="confTime" name="confTime" style="height:45px;width:150px"><option value="12:00:00 AM">12:00 AM</option><option value="12:30:00 AM">12:30 AM</option><option value="1:00:00 AM">01:00 AM</option><option value="1:30:00 AM">01:30 AM</option><option value="2:00:00 AM">02:00 AM</option><option value="2:30:00 AM">02:30 AM</option><option value="3:00:00 AM">03:00 AM</option><option value="3:30:00 AM">03:30 AM</option><option value="4:00:00 AM">04:00 AM</option><option value="4:30:00 AM">04:30 AM</option><option value="5:00:00 AM">05:00 AM</option><option value="5:30:00 AM">05:30 AM</option><option value="6:00:00 AM">06:00 AM</option><option value="6:30:00 AM">06:30 AM</option><option value="7:00:00 AM">07:00 AM</option><option value="7:30:00 AM">07:30 AM</option><option value="8:00:00 AM">08:00 AM</option><option value="8:30:00 AM">08:30 AM</option><option value="9:00:00 AM">09:00 AM</option><option value="9:30:00 AM">09:30 AM</option><option value="10:00:00 AM">10:00 AM</option><option value="10:30:00 AM">10:30 AM</option><option value="11:00:00 AM">11:00 AM</option><option value="11:30:00 AM">11:30 AM</option><option value="12:30:00 PM">12:30 PM</option><option value="1:00:00 PM">01:00 PM</option><option value="1:30:00 PM">01:30 PM</option><option value="2:00:00 PM">02:00 PM</option><option value="2:30:00 PM">02:30 PM</option><option value="3:00:00 PM">03:00 PM</option><option value="3:30:00 PM">03:30 PM</option><option value="4:00:00 PM">04:00 PM</option><option value="4:30:00 PM">04:30 PM</option><option value="5:00:00 AM">05:00 PM</option><option value="5:30:00 PM">05:30 PM</option><option value="6:00:00 PM">06:00 PM</option><option value="6:30:00 PM">06:30 PM</option><option value="7:00:00 PM">07:00 PM</option><option value="7:30:00 PM">07:30 PM</option><option value="8:00:00 PM">08:00 PM</option><option value="8:30:00 PM">08:30 PM</option><option value="9:00:00 PM">09:00 PM</option><option value="9:30:00 PM">09:30 PM</option><option value="10:00:00 PM">10:00 PM</option><option value="10:30:00 PM">10:30 PM</option><option value="11:00:00 PM">11:00 PM</option><option value="11:30:00 AM">11:30 PM</option></select></td></tr>
                  <tr><td></td><td><input type="submit" value="Submit" name="sub"></td></tr>
                  </table> 
                  <input type="hidden" name="action" value="addConferenceDetails">
</div></form>
</body>
</html>