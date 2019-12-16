# Unified Communicator and Collaborator for Enterprise

Modular enterprise communicator solution for enterprise based communication and collaboration . Use sipml5 client side libarary to provide webRTC based media stream capture and propagration from client side without external plugins.

Current modules include 

* Conferencing                   
* Geolocation
* WebRTC_presentation
* Emoticons                      
* Importcontacts                 
* UploadPicsAudioVideo           
* apache-tomcat-7.0.42           
* presentation_server_config.txt
* EnhancedCallLogs&Analytics     
* Notifications                  
* ViewPicsAudioVideo             
* callscreening                  
* experimental features
* Offlinemail                    
* Voicemail                      
* database_server_config.txt     
* workspace

![ucc component diagram ](img/ucc_component_diagram.png)

Technologies used :
* Java EE ( Enterprise Edition )
* Apaache WebSerer
* Front end technologies ( Javascript , CSS , Html)
* Google Maps API
* SQL backend for Database
* mysql JSDB driver 
* Directory Integration with Google contacts 

## Installation and setup

1. Install Mysql databse 

2. Install Apache tomcat 

3. Install SIP serveltes Server

4. Install Apache Server 

5. Host webproject on apache server

## Getting started 

-- tbd --

## Release Notes 

### Version 1 :

- Single Sign On
- Login with id and password to access all services
- Audio / Video Call
    - Call Hold / Call Transfer
- Messaging:
    - SIP Instant Messaging
    - Message to Facebook Messenger
    - Message delivered as Email
- Chatroom
    - group chat between multiple users . Room is created for set of users .
- Video Conferencing
    - video chat between multiple parties . Room is created for set of users .
- File Transfer
    - Sharing of files from local to remote , in peer-to-peer and broadcasting fashion .
- Third party Webservices
    - Widgets like calendar , weather , stocks , twitter are embedded.
- Visual Voice Mail
    - Record and deliver voice message to recipients voice mail inbox which can be accessed/ played from web client .
- Phonebook 
    - cloud integration
    - add new entries
    - add photos to contacts identity
    - import contacts from google account
- Click to Call :
    - Drop down list of contacts form mail call console
    - 2 step Click to call from Phonebook
- Presence :
    - Publish online / offline status
    - Use Subscribe / notify requests of SIP
- Web Ssocket  to SIP Gateway
    - Conversion between the signal coming from the  WebRTC  and SIP client  to the  IMS core
    - Conversion of  “voice/video " media  between sRTP and RTP
    - Conversion of other media (data channel) towards MSRP and Transcoding.
    - Support of ICE procedure
    - Implementation of a STUN server
- QoS Support  


### Version 2 :

- Logs
    - calls logs
    - Message logs
- User Profile
    - user details like address , email and social networking accounts
    - Phonenumber for GSM integration through SMS
    - User's Media storage like Pictures , profile picture , Audio , video
    - File sharing documents storage for future access in the same format
- Real Time and Offline Analytics
- service usage with graphical and tabular history  trends
- Session Management
    - Single Sign-on
    - Forgot password regeneration using secure question
    - Registration of new user account
    - Logout and clearance of session parameters
- Security
    - No redirection to any page through url entry without valid session
    - No going back to home page after logout by back button on browser
    - No data vulnerability
    - Multiple login through different devices handled
- OAuth
    - Login via IMAP / token through facebook and Google
- Phonebook with Presence functionality inbuilt
- Directory Service based on country / region
- Geolocation of approximate location detection of device logged in and visibility to  others

### Version 3 :

- Integration with new age CSP deployments like VoLTE, ViLTE, VoWiFi 
- Multi vendor support
- Interactive webrtc services 
- Media Services 
    - Automated Natural language Speech recognition
    - Semantic processing via ML 
    - Enhanced incall services replacing IVR ( touch -tone) 
    - VQE (voice Quality Enhancements) 
    - Encoding and Decoding - Multiple Codec Support
    - Transcoding
    - Silence Suppression
- Security via TLS, encryption and AAA
- Http, NFS caching 
- NAT using Xirsys TURN  
- Recording, playback and media file compression  
- active frame selection
- DTMF (Dual Tone Multi Frequency)
    - SIP info messages (out-of-band)
    - SIP notify messages (out-of-band)
    - Inband DTMF not supported yet 
- Audio 
    - mixing 
    - announcements ( VXML, MSML )
    - filters 
    - gain control ( AGC using webrtc stack)
    - noise suppresesion ( webrtc stack)
    - speakers notification
    - Narrowband, Wideband, and Super Wideband
    - dynamic sample rate
- Video  
    - continuous presence ( Face detetion ) 
    - floor control
    - video lipsync (sync)
    - speaker tile selection 
- VQE (Voice Quality Enhancement )
    - Acoustic Echo Cancelation
    - noise reduction
    - noise line detection
    - noise gating
    - Packet Loss concealment 
- Call analyics 
    - progress analysis   
    - MOS , R-factor ( derived from latency , jitter , packet loss )
- CDR (Call detail records ) and accounting 
- Lawful interception
