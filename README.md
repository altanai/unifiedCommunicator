## Unified Communcator and Collaborator for Enterperise

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
