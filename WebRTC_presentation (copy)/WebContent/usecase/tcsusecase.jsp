

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html __expr-val-dir="ltr" dir="ltr">
<HEAD><meta name="GENERATOR" content="Microsoft SharePoint" /><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<!-- Mimic Internet Explorer 7 -->
				<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" /><meta http-equiv="Expires" content="0" /><meta name="google-site-verification" content="XmFu8eA8ICyR5Se7AiY7VTYh_knEcxfMVsAe23bQXxk" /><meta name="alexaVerifyID" content="gJAgEJCM9l_rBKUvjOlz5HjkEGY" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><link REL="SHORTCUT ICON" href="http://www.tcs.com/favicon.ico" />
	<!-- All JavaScript at the bottom, except for Modernizr which enables HTML5 elements & feature detects -->
	<script type="text/javascript" language="javascript" src="/Style Library/jsv2/libs/modernizr-1.7.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/_layouts/1033/styles/controls.css?rev=EhwiQKSLiI%2F4dGDs6DyUdQ%3D%3D"/>
<link rel="stylesheet" type="text/css" href="/Style%20Library/cssv2/homepage.css"/>
<link rel="stylesheet" type="text/css" href="/Style%20Library/cssv2/slides.css"/>
<link rel="stylesheet" type="text/css" href="/_layouts/1033/styles/core.css?rev=5msmprmeONfN6lJ3wtbAlA%3D%3D"/>
<META NAME="ROBOTS" CONTENT="NOHTMLINDEX"/><title>
	
	TCS: IT Services, Consulting and Business Solutions

</title><script src="/_layouts/1033/init.js?rev=xlUxeoVViUTLIC7VCf9mnw%3D%3D"></script>
<script type="text/javascript" language="javascript" src="/_layouts/1033/core.js?rev=S5dt4K8TJGVTYU9HrW6enw%3D%3D" defer></script>
<script type="text/javascript" language="javascript" src="/_layouts/1033/non_ie.js?rev=yfNry4hY0Gwa%2FPDNGrqXVg%3D%3D"></script>

	<!--[if lte IE 7]>
	<![endif]-->
	<style type="text/css">
	html .jqueryslidemenu{height: 1%;} /*Holly Hack for IE7 and below*/
	</style>
	<style type="text/css">
	#ie-message {
	background:#e75429;
	text-align:center;
	border-bottom:1px solid #900;
	color: #ffffff;
	position:relative;
	top:0;
	padding:5px;
	width:99%;
	z-index: 1001;
	}
	#ie-message a {
	color: #fff;
	text-decoration: underline;
	font-weight: bold;
	}
	</style>
	
	<!--Placeholder for additional overrides-->
	
	<meta name="verify-v1" content="3h4YyUAcsoInFK75PiOHM5sW91wk3NxHCk8tqoiEqWc=" />
	<script type="text/javascript">
	    JQ = $;  //rename $ function
	</script>
	
	
	<script type="text/javascript" language="javascript">

		var dropdownItems1=[];		// Offerings: Services
		var dropdownItems2=[];		// Offerings: Software
		var dropdownItems3=[];		// Industries
		var newsItems=[];           // News & Events items
		
		function onLoad(){
			/* 
			document.getElementById("resourcesType").disabled=false;
			document.getElementById("topics").disabled=false;
			initializeScroller();
			*/
		}
		
		function dropdownItem(Link){
			this.Link= Link;	
			this.OrderKey = this.Link.substring(this.Link.indexOf('">')+2, this.Link.indexOf('</')).replace("&amp;","&");
    	}
    	function newsItem(Title,Link){
    		this.Title= Title;
    		this.Link= Link;
    	}
    	
    	var factItems=[];
    	function factItem(hp_fact_text){
			this.hp_fact_text = hp_fact_text;	
    	}
    	
		function findForm(){
	    	if (document.getElementById("resourcesType").options.length != 0){
				window.location = "/resources/Pages/filterResults.aspx?topic=" + document.forms[0].topics.options[document.forms[0].topics.selectedIndex].value + "&type=" + document.forms[0].resourcesType.options[document.forms[0].resourcesType.selectedIndex].value;
			}
		}
		
		//Disabled for SEO change
		/*function dropLink(flag){
			if(flag == 'o'){
				var theSelect = document.getElementById("offerings_list");
			}
			if(flag=="i"){
				var theSelect = document.getElementById("industries_list");
			}
			if(theSelect.selectedIndex != 0){
				window.location = theSelect.options[theSelect.selectedIndex].value;
			}			
		}*/
		
		function dropLink(flag)
		{
			if(flag == 'o'){
				window.location = document.getElementById("Offerings_List").value;
			}
			if(flag=='i'){
				window.location = document.getElementById("Industry_List").value;
			}
		}

		
		function updateCascade(){
			if(document.forms[0].topics.options[document.forms[0].topics.selectedIndex].value !="alltopics"){
				JQ.ajax({
					url: '/xml_files/Pages/default.aspx?t=' + document.forms[0].topics.options[document.forms[0].topics.selectedIndex].value,
    				type: 'GET',
    				dataType: 'html',
    				timeout: 5000,
    				error: function(){
        				//alert('Error loading cascading dropdown data.');
    				},
    				success: function(data){
        				var flagArray=data.split("||");
						var theSelect = document.getElementById("resourcesType");
						var i = 0;
						theSelect.options.length = 0;
						if(flagArray[1] == 1){
							theSelect.options[i] = new Option('Case Study','Case Study');
							i++;
						}
						if(flagArray[2] == 1){
							theSelect.options[i] = new Option('White Paper','White Paper');
							i++;
						}
						if(flagArray[0] == 1){
							theSelect.options[i] = new Option('Brochure','Brochure');
							i++;
						}
						if(flagArray[0] == 1){
							theSelect.options[i] = new Option('Media','Media');
							i++;
						}
						if(flagArray[0] == 1){
							theSelect.options[i] = new Option('Newsletter','Newsletter');
							i++;
						}
						if(flagArray[0] == 1){
							theSelect.options[i] = new Option('Podcast','Podcast');
							i++;
						}
						if(theSelect.options.length == 0){
							document.getElementById("findButton").style.display = "none";
							document.getElementById("resourcesType").style.display = "none";
							document.getElementById("typeHead").style.display = "none";
							document.getElementById("typeError").style.display = "block";
						}else{
							document.getElementById("typeError").style.display = "none";
							document.getElementById("typeHead").style.display = "block";
							document.getElementById("resourcesType").style.display = "block";
							document.getElementById("findButton").style.display = "block";
							
						}
					}
				});
			}else{
				var theSelect = document.getElementById("resourcesType");
				theSelect.options.length = 0;
				theSelect.options[0] = new Option('Case Study','Case Study');
				theSelect.options[1] = new Option('White Paper','White Paper');
				theSelect.options[2] = new Option('Brochure','Brochure');
				theSelect.options[3] = new Option('Media','Media');
				theSelect.options[4] = new Option('Newsletter','Newsletter');
				theSelect.options[5] = new Option('Podcast','Podcast');
			}
		}
    </script>

	<script language="javascript" type="text/javascript">
		
		function conditionalClear(current){
			if(current == " Search TCS.com" || current == "Please enter search term(s)"){		
				document.getElementById('searchinput').value = " "; 			
			}
		}
		
		function submitEnter(e){
			var keycode;
			if (window.event) keycode = window.event.keyCode;
			else if (e) keycode = e.which;
			else return true;
			if (keycode == 13 || keycode == 3)
			{
   				siteSearch();
   				return false;
   			}
			else
			   return true;
		}

	</script>
	
<meta name="title" content="TCS: IT Services, Consulting and Business Solutions" /><meta name="description" content="Tata Consultancy Services’ IT services, consulting and business solutions deliver real results to global businesses to help them experience certainty." /><meta name="keywords" content="TCS, Tata Consultancy Services, IT services, business solutions, outsourcing, Solution Accelerators, Innovation, Offshore, IT Solutions, Network Delivery, IT outsourcing, Outsourcing Service Provider, Offshore IT Service Provider, Engineering Outsourcing," /><style type="text/css">
	.ctl00_PlaceHolderMain_g_7D319A206C9E4D28A13DEF7EA297A915_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_g_4161856566A64D1D89DA060BFE9086C7_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_g_B07D66C06A514539B86EFB0478BC34DC_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_g_6EBB9065CC8D4B2697E582959F5494EA_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_g_B4707FE372D34185A9DD6982693FBF69_0 { border-color:Black;border-width:1px;border-style:Solid; }

</style></HEAD>
<BODY class="home" onload="javascript:onLoad();if (typeof(_spBodyOnLoadWrapper) != 'undefined') _spBodyOnLoadWrapper();">
<script language="javascript" type="text/javascript">
	function siteSearch(){
			if(document.getElementById('searchinput').value != " Search TCS.com" && document.getElementById('searchinput').value != "" && document.getElementById('searchinput').value != " Please enter search term(s)" && document.getElementById('searchinput').value != " "){		
				var query = document.getElementById('searchinput').value
				if(document.getElementById('searchinput').value.substring(0,1) == ' '){
					query = query.substring(1,query.length);
				}
				query=query.replace('=','%3D');
				query=query.replace('&','%26');
				query=query.replace('?','%3F');
				query=query.replace('#','%23');
				window.location = "http://search1.tcs.com/search?q=" + query + "&client=default_frontend&output=xml_no_dtd&proxystylesheet=default_frontend";	
			}else{
				document.getElementById('searchinput').style.color = "red";	
				document.getElementById('searchinput').value = " Please enter search term(s)";	
			}
		}
</script>

<!--[if lte IE 6]>
   <div id="ie-message">
      Your browser is obsolete and may not render this site correctly. Please upgrade to <a href="http://windows.microsoft.com/en-US/internet-explorer/downloads/ie" target="_blank" rel="nofollow">Internet Explorer 8.0 or 9.0</a>
   </div>
<![endif]-->

<form name="aspnetForm" method="post" action="default.aspx" onsubmit="javascript:return WebForm_OnSubmit();" id="aspnetForm">
<div>
<input type="hidden" name="__SPSCEditMenu" id="__SPSCEditMenu" value="true" />
<input type="hidden" name="MSOWebPartPage_PostbackSource" id="MSOWebPartPage_PostbackSource" value="" />
<input type="hidden" name="MSOTlPn_SelectedWpId" id="MSOTlPn_SelectedWpId" value="" />
<input type="hidden" name="MSOTlPn_View" id="MSOTlPn_View" value="0" />
<input type="hidden" name="MSOTlPn_ShowSettings" id="MSOTlPn_ShowSettings" value="False" />
<input type="hidden" name="MSOGallery_SelectedLibrary" id="MSOGallery_SelectedLibrary" value="" />
<input type="hidden" name="MSOGallery_FilterString" id="MSOGallery_FilterString" value="" />
<input type="hidden" name="MSOTlPn_Button" id="MSOTlPn_Button" value="none" />
<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" />
<input type="hidden" name="__REQUESTDIGEST" id="__REQUESTDIGEST" value="0x17F14905C40F4229A71983EE1F95F5D10B6C36AA29C32863A2A0551C57EF6BEB23AB5236CC63FD61810483C900E1884F5959A73481DEC2D1EC6CBCF7925A4642,04 Aug 2013 02:19:53 -0000" />
<input type="hidden" name="MSOAuthoringConsole_FormContext" id="MSOAuthoringConsole_FormContext" value="" />
<input type="hidden" name="MSOAC_EditDuringWorkflow" id="MSOAC_EditDuringWorkflow" value="" />
<input type="hidden" name="MSOSPWebPartManager_DisplayModeName" id="MSOSPWebPartManager_DisplayModeName" value="Browse" />
<input type="hidden" name="MSOWebPartPage_Shared" id="MSOWebPartPage_Shared" value="" />
<input type="hidden" name="MSOLayout_LayoutChanges" id="MSOLayout_LayoutChanges" value="" />
<input type="hidden" name="MSOLayout_InDesignMode" id="MSOLayout_InDesignMode" value="" />
<input type="hidden" name="MSOSPWebPartManager_OldDisplayModeName" id="MSOSPWebPartManager_OldDisplayModeName" value="Browse" />
<input type="hidden" name="MSOSPWebPartManager_StartWebPartEditingName" id="MSOSPWebPartManager_StartWebPartEditingName" value="false" />
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUJOTExOTI3MTIzD2QWAmYPZBYCAgEPZBYGZg9kFgICDg9kFgJmD2QWAgIBDxYCHhNQcmV2aW91c0NvbnRyb2xNb2RlCymIAU1pY3Jvc29mdC5TaGFyZVBvaW50LldlYkNvbnRyb2xzLlNQQ29udHJvbE1vZGUsIE1pY3Jvc29mdC5TaGFyZVBvaW50LCBWZXJzaW9uPTEyLjAuMC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPTcxZTliY2UxMTFlOTQyOWMBZAIBD2QWBAIED2QWAgIBDxYCHgdWaXNpYmxlaBYCZg9kFgQCAg9kFgYCAQ8WAh8BaGQCAw8WAh8BaGQCBQ8WAh8BaGQCAw8PFgIeCUFjY2Vzc0tleQUBL2RkAggPZBYSAgMPZBYCZg8PFgIfAWhkZAIFD2QWAmYPDxYCHwFoZGQCBw9kFgJmDw8WAh8BaGRkAgsPFgIfAAsrBAFkAg0PFgIfAAsrBAFkAg8PFgIfAAsrBAFkAhEPFgIfAAsrBAFkAhMPZBYCZg8PFgIfAWhkZAIVD2QWAmYPDxYCHwFoZGQCAg9kFggCAw9kFgICAw9kFgICAQ8PFgIfAWdkFgQCAQ8PFgIfAWhkFhwCAQ8PFgIfAWhkZAIDDxYCHwFoZAIFDw8WAh8BaGRkAgcPFgIfAWhkAgkPDxYCHwFoZGQCCw8PFgIfAWhkZAINDw8WAh8BaGRkAg8PDxYEHgdFbmFibGVkaB8BaGRkAhEPDxYCHwFoZGQCEw8PFgQfA2gfAWhkZAIVDw8WAh8BaGRkAhcPFgIfAWhkAhkPFgIfAWhkAhsPDxYCHwFnZGQCAw8PFgIfAWdkFgYCAQ8PFgIfAWdkZAIDDw8WAh8BZ2RkAgUPDxYCHwFnZGQCBQ9kFgICAQ8WAh8BaBYCZg9kFgQCAg9kFgICAw8WAh8BaGQCAw8PFgIfAgUBL2RkAgsPZBYCAgIPDxYCHwFnFgIeBXN0eWxlBQ5kaXNwbGF5OmJsb2NrO2QCEw9kFgICAQ9kFgJmDw9kFgIeBWNsYXNzBRhtcy1zYnRhYmxlIG1zLXNidGFibGUtZXhkZOJlHmjqj3xb08xqXik+o+7+Iby+" />
</div>

<script type="text/javascript">
//<![CDATA[
var theForm = document.forms['aspnetForm'];
if (!theForm) {
    theForm = document.aspnetForm;
}
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
//]]>
</script>


<script src="/WebResource.axd?d=JgH3kIgVn1nYIW8ZIK1tAzfcCjel_q-dLjSJmDkvTxwB_a6eo1PKEmwP9r0WNySppaAY0FDeT9B5cePakzVnKzAidAc1&amp;t=634731765016481856" type="text/javascript"></script>

<script> var MSOWebPartPageFormName = 'aspnetForm';</script><script type="text/javascript">var _gaq = _gaq || [];_gaq.push(['_setAccount', 'UA-177855-1']);_gaq.push(['_setDomainName', 'tcs.com']);_gaq.push(['_trackPageview']);(function() {var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);})();</script>
<script type="text/javascript">
//<![CDATA[

                function DoCallBack(filterText)
                {
                    WebForm_DoCallback('ctl00$m$g_d3db98bb_2b8c_4189_a1b3_e543cf0bd45a',filterText,UpdateFilterCallback,0,CallBackError,true);
                }
                function CallBackError(result, clientsideString)
                {                
                }
            //]]>
</script>
<script type="text/JavaScript" language="JavaScript">
<!--
var L_Menu_BaseUrl="";
var L_Menu_LCID="1033";
var L_Menu_SiteTheme="";
//-->
</script>
<script type="text/javascript">
//<![CDATA[
function WebForm_OnSubmit() {
UpdateFormDigest('\u002f', 1440000);return _spFormOnSubmitWrapper();
return true;
}
//]]>
</script>




<div id="container">
	
	<div id="globalheader">
			<ul id="globalnav">
				<li><a href="/worldwide/Pages/default.aspx" class="global-worldwide">Worldwide</a>
					<!--<div class="worldwide">drop drop</div>-->
				</li>
				<li><a href="https://grs.tcs.com/ep/index.jsp">Careers</a></li>
				<li><a href="/investors/Pages/default.aspx">Investors</a></li>
				<li><a href="/media/Pages/default.aspx">Media</a></li>
				<li class="start"><a href="/contact/Pages/default.aspx" class="global-contactus"><span>&nbsp;</span> Contact Us</a></li>
				<li>						<!-- AddThis Button BEGIN -->
						<script type="text/javascript">var addthis_pub  = "tcsmarketing";
							addthis_logo            = 'http://www.tcs.com/Style%20Library/Images/common/tcs_stacked_logo_sharethis.gif';
							addthis_logo_background = 'EFEFEF';
							addthis_logo_color      = '666699';
							addthis_brand           = 'www.tcs.com';
							addthis_options         = 'twitter, linkedin, favorites, digg, delicious, myspace, facebook, google, live, buzz, more';				
						</script>
						<a href="http://www.addthis.com/bookmark.php" rel="nofollow" onmouseover="return addthis_open(this, '', '[URL]', '[TITLE]')" onmouseout="addthis_close()" onclick="return addthis_sendto()" class="global-share"><span>&nbsp;</span> Share </a>
						<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js"></script></li>
			</ul>
			<!--<input type="text" id="searchinput" value="Search TCS.com" name="searchinput" size="20px" onclick="javascript:conditionalClear(this.value);this.style.color='#ffffff';" onkeypress="return submitEnter(event);" />-->
			<input type="text" id="searchinput"  value=" Search TCS.com" name="searchinput" size="10" onclick="javascript:conditionalClear(this.value);this.style.color='#717171';" onkeypress="return submitEnter(event);" />
			

			<a href="#" id="searchbtn" onclick="javascript:siteSearch();">Tata</a>
			<!-- -- -- Site Actions Menu -- -- -->
			
<!-- Begin Action Menu Markup -->
<table height=100% class="ms-siteaction" cellpadding=0 cellspacing=0>
	<tr>
					   <td class="ms-siteactionsmenu" id="siteactiontd">
					   
					</td>
	</tr>
</table>
<!-- End Action Menu Markup -->


	</div>
	<div class="header">
	<div class="home">
			<h1><a href="/pages/default.aspx" class="tagline"><img src="/Style Library/imagesv2/background-tcs.png" alt="Tata Consultancy Services: IT Services, Consulting and Business Solutions"/></a></h1>
			<div class="tata-logo">&nbsp;</div>
			<!--<ul id="topnav">
				<li><a href="https://grs.tcs.com/ep/index.jsp">Careers</a></li>
				<li><a href="/investors/Pages/default.aspx">Investors</a></li>
				<li><a href="/media/Pages/default.aspx">Media</a></li>

			</ul>-->
			<ul id="mainnav">
				<li ><a href="/offerings/Pages/default.aspx">Offerings&nbsp;&nbsp;<span>&nbsp;</span></a>
					<div>
						<!--<p>
							TCS offers a wide range of IT services, outsourcing and business solutions. 
						</p>-->
						<ul>
							<!--<li class="first">Services</li>-->
							<li><a href="/offerings/assurance_services/Pages/default.aspx">Assurance Services</a></li>
							<li><a href="/offerings/business-intelligence-performance-management/Pages/default.aspx">BI & Performance Management</a></li>
							<!--<li><a href="/offerings/big-data/Pages/default.aspx">Big Data Solutions and Services</a></li>-->
							<li><a href="/offerings/business_process_outsourcing_BPO/Pages/default.aspx">Business Process Services</a></li>
							<li><a href="/offerings/cloud/Pages/default.aspx">Cloud Services</a></li>
							<li><a href="/offerings/connected-marketing-solutions/Pages/default.aspx">Connected Marketing Solutions</a></li>
							<li><a href="/offerings/consulting/Pages/default.aspx">Consulting</a></li>
							<li><a href="/offerings/Eco-sustainability-Services/Pages/default.aspx">Eco-sustainability Services</a></li>
							<li><a href="/offerings/engineering_services/Pages/default.aspx">Engineering & Industrial Services</a></li>
							<li><a href="/offerings/enterprise_solutions/Pages/default.aspx">Enterprise Solutions</a></li>
							<li><a href="/offerings/ion-small-medium-business-SMB/Pages/default.aspx">iON Small and Medium Business</a></li>
							<li><a href="/offerings/it_infrastructure/Pages/default.aspx">IT Infrastructure Services</a></li>
							<li><a href="/offerings/it-services/Pages/default.aspx">IT Services</a></li>
							<li><a href="/offerings/mobility_products_services/Pages/default.aspx">Mobility Products and Services</a></li>
							<li class="last"><a href="/offerings/platform_solutions/Pages/default.aspx">Platform Solutions</a></li>
						</ul>
						<ul>
							<li class="first">Products</li>
							<li><a href="/offerings/bancs/Pages/default.aspx">TCS BaNCS</a></li>
							<li><a href="/offerings/mastercraft/Pages/default.aspx">TCS MasterCraft</a></li>
							<li class="last"><a href="/offerings/technology-products/Pages/default.aspx">TCS Technology Products</a></li>
							<!--<li class="last"><a href="/offerings/other_solutions/Pages/default.aspx">Other Products</a></li>-->
						</ul>
					</div>
				</li>
				<li ><a href="/industries/Pages/default.aspx">Industries<span>&nbsp;</span></a>
					<div class="industry">
						<!--<p>
							TCS has the depth and breadth of experience and expertise. 
						</p>-->
	
						<ul>
							<!--<li class="first">Industries</li>-->
							<li class="firstnotitle"><a href="/industries/banking/Pages/default.aspx">Banking & Financial Services</a></li>
							<li><a href="/industries/construction/Pages/default.aspx">Construction</a></li>
							<li><a href="/industries/eru/Pages/default.aspx">Energy & Utilities</a></li>
							<li><a href="/industries/government/Pages/default.aspx">Government</a></li>
							<li><a href="/industries/healthcare/Pages/default.aspx">Healthcare</a></li>
							<li><a href="/industries/high_tech/Pages/default.aspx">High Tech</a></li>
							<li><a href="/industries/insurance/Pages/default.aspx">Insurance</a></li>
							<li><a href="/industries/life-sciences/Pages/default.aspx">Life Sciences</a></li>
							<li><a href="/industries/manufacturing/Pages/default.aspx">Manufacturing</a>
							<li><a href="/industries/media/Pages/default.aspx">Media & Information Services</a></li>
							<li><a href="/industries/metals-mining/Pages/default.aspx">Metals & Mining</a></li>
							<li><a href="/industries/retail-consumer-products/Pages/default.aspx">Retail & Consumer Products</a></li>
							<li><a href="/industries/telecom/Pages/default.aspx">Telecom</a></li>
							<li class="last"><a href="/industries/travel-transportation-hospitality/Pages/default.aspx">Travel, Transportation & Hospitality</a></li>						
						</ul>
					</div>
	
				</li>
				<li><a href="/Insights/Pages/TCS-Insights.aspx">Insights<span>&nbsp;</span></a>
					<div class="insights"> 
						<ul class="topics">
							<li><a href="/insights/Pages/analyze.aspx">Analyze - Understand Customers and Markets</a></li>
							<li><a href="/insights/Pages/digitize.aspx">Digitize - Deliver Digital Experiences</a></li>
							<li><a href="/insights/Pages/optimize.aspx">Optimize - Elevate Business Performance</a></li>
							<li><a href="/insights/Pages/derisk.aspx">De-Risk - Safeguard the Enterprise</a></li>
							<li><a href="/insights/Pages/sustain.aspx">Sustain - Build Sustainable Enterprises and Communities</a></li>
						</ul>
						<ul class="journal">
							<li><a href="/perspectives/Pages/default.aspx">Perspectives - TCS Consulting Journal</a></li>
						</ul>
						<!--<ul class="study">
							<li><a href="#">Other TCS insights</a></li>
						</ul>-->
					</div>
				</li>
				<li ><a href="/about/Pages/default.aspx">About TCS<span>&nbsp;</span></a>
					<div class="aboutus">
						<!--<p>
							Experience certainty. 
						</p>-->
						<ul>
							<!--<li class="first">About Us</li>-->
							<li class="firstnotitle"><a href="/about/experience-certainty/Pages/default.aspx">Experience certainty</a></li>
							<li><a href="/about/tcs_difference/Pages/default.aspx">The TCS Advantage</a></li>
							<li><a href="/about/corp_facts/Pages/default.aspx">Corporate Facts</a></li>
							<li><a href="/about/heritage_values/Pages/default.aspx">Heritage and Values</a></li>
							<li><a href="/about/research/Pages/default.aspx">Research</a></li>
							<li class="last"><a href="/about/corp_responsibility/Pages/default.aspx">Corporate Sustainability</a></li>
						</ul>
					</div>
				</li>
				<li ><a href="/resources/Pages/default.aspx">Resources<span>&nbsp;</span></a>
					<div class="resources">
						<!--<p >
							Browse this extensive collection of downloadable collaterals.
						</p>-->
						<ul>
							<!--<li class="first">Resources</li>-->
							<li class="firstnotitle"><a href="/resources/case_studies/Pages/default.aspx">Case Studies</a></li>
							<li><a href="/resources/white_papers/Pages/default.aspx">White Papers</a></li>
							<li><a href="/resources/podcasts/Pages/default.aspx">Podcasts</a></li>
							<li><a href="/resources/multimedia/Pages/default.aspx">Videos & Multimedia</a></li>
							<li><a href="/resources/newsletters/Pages/default.aspx">Newsletters</a></li>
							<li><a href="/resources/brochures/Pages/default.aspx">Brochures</a></li>
							<li class="last"><a href="/resources/Pages/filterResults.aspx">Search All Resources</a></li>
						</ul>
					</div>
				</li>
				<li class="last "><a href="/news_events/Pages/default.aspx">News/Events<span class="newsevents"></span></a>
					<div class="newsevents">
						<!--<p>All the latest TCS information and events, including press releases, analyst reports, and news items.</p>-->
						<ul>
							<!--<li class="first">News & Events</li>-->
							<li class="firstnotitle"><a href="/news_events/press_releases/Pages/default.aspx">Press Releases</a></li>
							<li><a href="/news_events/events/Pages/default.aspx">Events</a></li>
							<li><a href="/news_events/analyst_reports/Pages/default.aspx">Analyst Reports</a></li>
							<li class="last"><a href="/news_events/tcs_news/Pages/default.aspx">TCS in the News</a></li>
						</ul>
					</div>
				</li>
			</ul>

		</div>
		</div>		
		<div id="main" class="home" role="main">
			
			





	
	<ul class="homemodules">
				<li class="first">
					<div id="homemodule1">
						<h2>Insights</h2>
						<div class="slides_container">
							<div>
								<p>									
									<a href="http://sites.tcs.com/insights/articles/five-mobile-fails-mobile-pitfalls" title="Five Mobile Fails – How the Financial Industry Can Avoid Mobile Pitfalls">Five Mobile Fails – How the Financial Industry Can Avoid Mobile Pitfalls</a>
									<br />
									<span><span><span><span><span><span lang=EN><span><span>
<p><span>Designing your mobile strategy? We present five common mobile “fails” across mobile apps, promotions or mobile-enabling the website.</span></span></span></span></span></span></span></span></span></p>
								</p>
							</div>
							<div>
								<p>									
									<a href="http://sites.tcs.com/insights/articles/a-dozen-ways-insurers-can-leverage-big-data-for-business-value" title="A Dozen Ways Insurers Can Leverage Big Data for Business Value">A Dozen Ways Insurers Can Leverage Big Data for Business Value</a>
									<br />
									<p><span><span><span><span><span><span><span><span><span><span>Learn how insurers can harness and harvest Big Data with a close collaboration between IT and business to drive actionable insights.</span></span></span></span></span></span></span></span></span></span></p>
								</p>
							</div>
						</div>
						<P><img src="/Style Library/imagesv2/icon-bullet.png" />&nbsp;<a href="/Insights/Pages/TCS-Insights.aspx" class="more_link">More 
						Insights</a></p>
					</div>
				</li>
				<!-- CODED FOR QRTLY RESULTS DAY-->
								<li class="second">
					<h2>Financial Results for Q1 FY14</h2>
					<div style="width:285px;">
						<div style="float:left;  padding-top: 10px; line-height:15px;">
										TCS announced its financial results for Q1 FY14<br>on Thursday, July 18, 2013. 
														<ul style="padding-left: 15px; margin-left: 2px; padding-top: 3px; list-style:disc; padding-bottom: 8px;">
															<li>View updated information about <a href="/investors/Pages/default.aspx">TCS’ Financial Results for Q1 2013-14</a></li>
															<li>Follow us on <a href="http://www.twitter.com/tcs_news" target="_blank">Twitter </a>for live updates</li>
														</ul>
																			
							<p style="margin-left:0; padding-top: 4px; "><img src="/Style Library/imagesv2/icon-bullet.png" />&nbsp;<a href="http://www.tcs.com/investors/Pages/default.aspx" >Visit 
							TCS Investor Relations</a></p>
						</div>
					</div>
				</li>

				<!--CODED FOR QRTLY RESULTS DAY ENDS-->
				<!--CODE AFTER QRTLY RESULTS DAY 
				<li class="second">
					<h2>The Emerging Big Returns on Big Data</h2>
					<div style="width:285px;">
					<div style="padding: 10px 0 4px 0;">A TCS 2013 Global Trend 
						Study</div>
						<div style="float:left;  padding-top: 5px; line-height:15px;">
										We highlight how large companies are 
										investing in and deriving returns from 
										Big Data. We surveyed 1,217 companies across the globe. 
																<p style="margin-left:0; padding-top: 4px; "><img src="/Style Library/imagesv2/icon-bullet.png" />&nbsp;<a href="/bigdatastudy/Pages/default.aspx" >Read 
																the findings of 
																the study</a></p>
						</div>
					</div>
				</li>
								CODES AFTER QRTLY RESULTS DAY ENDS-->
				
				<li class="third">
					<div id="homemodule2">
						<h2>News &amp; Events</h2>
						<div class="slides_container" style="left: 0px; height: 102px;">							
							<div>
								<ul id="news_list">
								</ul>
							</div>
							<div>
								<ul id="news_list1">
								</ul>
							</div>
						</div>
						<p>
						<img src="/Style Library/imagesv2/icon-bullet.png" />&nbsp;<a href="/news_events" class="more_link">More 
						News &amp; Events</a></p>
					</div>
				</li>

			</ul>
			<div id="homeslidesimage">
				<div class="slides_container">
					<div><img src="/Style Library/imagesv2/rotate-HBR.jpg" alt="Harvard Business Review"/>
						<div class="caption">
							<p class="caption-category">Harvard business review</p>
							<div  style="width:430px"><span>What the Companies Winning at Big Data Do Differently</span></div>
							<p>Satya Ramaswamy, TCS, discusses how Big Data can revolutionize an industry by shifting the balance of power.</p>
							<!--<p class="certain">They found a way to be certain.</p>-->
							<div><a href="http://blogs.hbr.org/cs/2013/06/what_the_companies_winning_at.html" onClick="_gaq.push(['_trackEvent', 'Read', 'Click', 'Homepage-Theater-External-HBR-BigData']);" class="readmorebtn"></a></div>
						</div>
					</div>
					<div><img src="/Style Library/imagesv2/rotate-sanlam.jpg" alt="TCS helps Sanlam re-engineer policy administration system"/>
						<div class="caption">
							<p class="caption-category">Client Testimonial</p>
							<div  style="width:430px"><span>TCS helps Sanlam re-engineer policy administration system</span></div>
							<p>Sanlam sought to be the first to renew its legacy platform and gain a competitive edge.</p>
							<p class="certain">It found a certain way.</p>
							<div><a href="http://www.tcs.com/resources/multimedia/Pages/Sanlam-life-insurance-reengineer-policy-administration-system.aspx" onClick="_gaq.push(['_trackEvent', 'Watch', 'Click', 'Homepage-Theater-Testimonial-Sanlam']);" class="play">Watch Video</a></div>
						</div>
					</div>

					<div><img src="/Style Library/imagesv2/rotate-astra.jpg" alt="Video Testimonial - AstraZeneca" />
						<div class="caption">
							<p class="caption-category">Client Testimonial</p>
							<div  style="width:500px"><span>AstraZeneca</span></div>
							<p>AstraZeneca wished to focus its core resources on 
							strategic, proactive and scientific patient safety.</p>
							<p class="certain">It found a certain way.</p>
							<div><a href="http://www.tcs.com/resources/multimedia/Pages/TCS-Astra-Zeneca-core-activities-enhanced-patient-safety.aspx " onClick="_gaq.push(['_trackEvent', 'Watch', 'Click', 'Homepage-Theater-Testimonial-AstraZeneca']);" class="play">Play Video</a></div>
						</div>
					</div>

					<div><img src="/Style Library/imagesv2/theaterSlide-Bigdata.jpg" alt="Trend Study - The Emerging Big Returns on Big Data" />
						<div class="caption">
							<p class="caption-category">Trend Study</p>
							<div  style="width:430px"><span>The Emerging Big Returns<br>on Big Data<br></span></div>
							<p>Discover how Big Data is paying off for many companies, and big time for some.</p>
							<p class="certain">Find a way to be certain.</p>
							<!--<p>A TCS 2013 Global Trend Study</p>-->
							<!--<p class="clientTitle">We capture how global corporations are responding to win the loyalty of the new digital mobile consumer. </p>-->
							<div><a href="http://www.tcs.com/big-data-study/Pages/default.aspx" onClick="_gaq.push(['_trackEvent', 'Read', 'Click', 'Homepage-Theater-TrendStudy-BigData']);" class="readmorebtn"></a></div>
						</div>
					</div>
				</div>

			</div>
			<div><img src="/Style Library/imagesv2/apptestimage.jpg" style="visibility:hidden" /></div>
			<div class="clear"></div>
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td id="MSOZoneCell_WebPartWPQ2" vAlign="top"><table TOPLEVEL border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td valign="top"><div WebPartID="d3db98bb-2b8c-4189-a1b3-e543cf0bd45a" HasPers="false" id="WebPartWPQ2" width="100%" class="ms-WPBody" allowDelete="false" style="" ><table id="cbqwp" cellspacing="0" cellpadding="0" class="cbq-layout-main"><tr><td id="column" width="100%" valign="top"><script language="javascript" type="text/javascript">
				newsItems.push(new newsItem(
			 		'TCS ranked #1 for customer satisfaction in the UK',
  				 	'http://www.tcs.com/news_events/press_releases/Pages/TCS-number-1-customer-satisfaction-UK.aspx'
  				));
		</script><script language="javascript" type="text/javascript">
				newsItems.push(new newsItem(
			 		'TCS Receives Partner Excellence Award From Pegasystems, Inc.',
  				 	'http://www.tcs.com/news_events/press_releases/Pages/TCS-Partner-Excellence-Award-Pegasystems.aspx'
  				));
		</script><script language="javascript" type="text/javascript">
				newsItems.push(new newsItem(
			 		'TCS to modernize and automate taxation system in Zambia',
  				 	'http://www.tcs.com/news_events/press_releases/Pages/TCS-taxation-system-Zambia.aspx'
  				));
		</script><script language="javascript" type="text/javascript">
				newsItems.push(new newsItem(
			 		'TCS Honored as Technology Partner at the Manufacturing Leadership 100 Awards',
  				 	'http://www.tcs.com/news_events/press_releases/Pages/TCS-Technology-Partner-Manufacturing-Leadership-100-Awards.aspx'
  				));
		</script><div id="footer"></div></td ></tr></table></div></td>
			</tr>
		</table></td>
	</tr>
</table>
			<script type="text/javascript" language="javascript">
			//	var FactBuilder = "";
			//	FactBuilder += "<li>";
			//	var factIndex = Math.floor(Math.random() * (factItems.length));
			//	FactBuilder += factItems[factIndex].hp_fact_text;
			//	FactBuilder += "</li>";
			//	document.getElementById("fact_list").innerHTML = FactBuilder;
				
				var NewsBuilder = "";
				var NewsBuilder2 = "";
				for (var j=0; j<newsItems.length; j++) {
					if(j<2)
					{
						NewsBuilder += "<li><a href=\"" + newsItems[j].Link + "\">" + newsItems[j].Title + " </a></li>";
					}					
					else
					{
						NewsBuilder2 += "<li><a href=\"" + newsItems[j].Link + "\">" + newsItems[j].Title + " </a></li>";
					}
				}
				document.getElementById("news_list").innerHTML = NewsBuilder;
				document.getElementById("news_list1").innerHTML = NewsBuilder2;
				function sortByKey(a, b) {
			    	var x = a.OrderKey;
			   	 	var y = b.OrderKey;
			    	return ((x < y) ? -1 : ((x > y) ? 1 : 0));
				}
			</script>

 </div>
		<footer class="home">
			<div id="newfooter_top">
			<div id="footer_left">
				<ul>
						<li class="first"><strong><a href="/offerings/Pages/default.aspx">Offerings</a></strong><br>
							<a href="/offerings/assurance_services/Pages/default.aspx">Assurance Services</a><br>
							<a href="/offerings/business-intelligence-performance-management/Pages/default.aspx">BI & Performance Management</a><br>
							<!--<a href="/offerings/big-data/Pages/default.aspx">Big Data Solutions and Services</a><br>-->
							<a href="/offerings/business_process_outsourcing_BPO/Pages/default.aspx">Business Process Services</a><br>
							<a href="/offerings/cloud/Pages/default.aspx">Cloud Services</a><br>							
							<a href="/offerings/connected-marketing-solutions/Pages/default.aspx">Connected Marketing Solutions</a><br>
							<a href="/offerings/consulting/Pages/default.aspx">Consulting</a><br>
							<a href="/offerings/Eco-sustainability-Services/Pages/default.aspx">Eco-sustainability Services</a><br>
							<a href="/offerings/engineering_services/Pages/default.aspx">Engineering & Industrial Services</a><br>
							<a href="/offerings/enterprise_solutions/Pages/default.aspx">Enterprise Solutions</a><br>
							<a href="/offerings/ion-small-medium-business-SMB/Pages/default.aspx">iON Small and Medium Business</a><br>
							<a href="/offerings/it_infrastructure/Pages/default.aspx">IT Infrastructure Services</a><br>
							<a href="/offerings/it-services/Pages/default.aspx">IT Services</a><br>
							<a href="/offerings/mobility_products_services/Pages/default.aspx">Mobility Products and Services</a><br>
							<a href="/offerings/platform_solutions/Pages/default.aspx">Platform Solutions</a>
						</li>
					<li><strong><a href="/industries/Pages/default.aspx">Industries</a></strong><br>
						<a href="/industries/banking/Pages/default.aspx">Banking & Financial Services</a><br>
						<a href="/industries/construction/Pages/default.aspx">Construction</a><br>
						<a href="/industries/eru/Pages/default.aspx">Energy & Utilities</a><br>
						<a href="/industries/government/Pages/default.aspx">Government</a><br>
						<a href="/industries/healthcare/Pages/default.aspx">Healthcare</a><br>
						<a href="/industries/high_tech/Pages/default.aspx">High Tech</a><br>
						<a href="/industries/insurance/Pages/default.aspx">Insurance</a><br>
						<a href="/industries/life-sciences/Pages/default.aspx">Life Sciences</a><br>
						<a href="/industries/manufacturing/Pages/default.aspx">Manufacturing</a><br>
						<a href="/industries/media/Pages/default.aspx">Media & Information Services</a><br>
						<a href="/industries/metals-mining/Pages/default.aspx">Metals & Mining</a><br>
						<a href="/industries/retail-consumer-products/Pages/default.aspx">Retail & Consumer Products</a><br>
						<a href="/industries/telecom/Pages/default.aspx">Telecom</a><br>
						<a href="/industries/travel-transportation-hospitality/Pages/default.aspx">Travel, Transportation & Hospitality</a><br>
					</li>
					<li><strong><a href="/offerings/Pages/default.aspx">Products</a></strong><br>
						<a href="/offerings/bancs/Pages/default.aspx">TCS BaNCS</a><br>
						<a href="/offerings/mastercraft/Pages/default.aspx">TCS MasterCraft</a><br>
						<a href="/offerings/technology-products/Pages/default.aspx">TCS Technology Products</a><br>
					</li>
					<li class="last">
						<a href="/Insights/Pages/TCS-Insights.aspx">Insights</a><br>
                        <a href="/about/Pages/default.aspx">About TCS</a><br>
						<a href="/resources/Pages/default.aspx">Resources</a><br>
						<a href="/news_events/Pages/default.aspx">News & Events</a><br>
                        <a href="https://grs.tcs.com/ep/index.jsp">Careers</a><br>
						<a href="/investors/Pages/default.aspx">Investors</a><br>
						<a href="/media/Pages/default.aspx">Media</a><br>
						<a href="/worldwide/Pages/default.aspx">TCS Worldwide</a><br>
					</li>
				</ul>
			</div>
			<div id="footer_rite">
				<div id="withsocial">
					<li>Connect with TCS</li>
					<div style="">
						<a href="http://www.tcs.com/twitter" style="border: none;" rel="nofollow"><img src="/Style Library/imagesv2/twitter.png" border="0" alt="Twitter Icon"/></a>&nbsp;
						<a href="http://www.tcs.com/facebook" style="border: none;" rel="nofollow"><img src="/Style Library/imagesv2/facebook.png" border="0" alt="Facebook Icon" /></a>&nbsp;
						<a href="http://www.tcs.com/linkedin" style="border: none;" rel="nofollow"><img src="/Style Library/imagesv2/linkedin.png" border="0" alt="Linkedin Icon" /></a>&nbsp;
						<!--<a href="http://www.tcs.com/googleplus" style="border: none;" rel="nofollow"><img src="/Style Library/imagesv2/gplus.png" border="0" alt="GooglePlus icon"/></a>&nbsp;-->
						<a href="https://plus.google.com/106174146421219809019/" style="border: none;" rel="nofollow"><img src="/Style Library/imagesv2/gplus.png" border="0" alt="GooglePlus icon"/></a>&nbsp;
						<a href="http://www.tcs.com/youtube" style="border: none;" rel="nofollow"><img src="/Style Library/imagesv2/youtube.png" border="0"  alt="Youtube Icon" /></a>&nbsp;
						<a href="/rss_feeds/Pages/default.aspx" style="border: none;" rel="nofollow"><img src="/Style Library/imagesv2/rss.png" border="0" alt="RSS Icon" /></a></div>
				</div>
				<div id="footerothers">
					<li><a href="/contact/Pages/default.aspx" rel="nofollow">Contact us</a></li>
					<li><a href="/disclaimer/Pages/default.aspx" rel="nofollow">Disclaimer</a></li>
					<li><a href="/privacy/Pages/default.aspx" rel="nofollow">Privacy Policy</a></li>
					<li><a href="/safeharbor/Pages/default.aspx" rel="nofollow">Safe Harbor</a></li>
					<li><a href="/sitemap/Pages/default.aspx" rel="nofollow">Sitemap</a></li>
				</div>
			</div>			
			</div>
			<div id="newfooter_bottom">
				<ul>
					<li style="padding-left: 20px">&copy; 2010-2013 Tata Consultancy Services Limited.  All Rights Reserved</li>
					<li style="padding-left: 410px; padding-right:0px;">TCS is a member of the <a target="_blank" href="http://www.tata.com">Tata Group</a>&nbsp;</li>
					<li style="margin-top:0px;"><a target="_blank" href="http://www.tata.com"></a></li>
				</ul>
			</div>
		</footer>
<!-- end of container -->
</div> 



<script type="text/javascript">
//<![CDATA[

WebForm_InitCallback();var __wpmExportWarning='This Web Part Page has been personalized. As a result, one or more Web Part properties may contain confidential information. Make sure the properties contain information that is safe for others to read. After exporting this Web Part, view properties in the Web Part description file (.WebPart) by using a text editor such as Microsoft Notepad.';var __wpmCloseProviderWarning='You are about to close this Web Part.  It is currently providing data to other Web Parts, and these connections will be deleted if this Web Part is closed.  To close this Web Part, click OK.  To keep this Web Part, click Cancel.';var __wpmDeleteWarning='You are about to permanently delete this Web Part.  Are you sure you want to do this?  To delete this Web Part, click OK.  To keep this Web Part, click Cancel.';//]]>
</script>
</form> 

<!--[if lt IE 7 ]>
    <script src="js/libs/dd_belatedpng.js"></script>
    <script>DD_belatedPNG.fix("img, .png_bg"); // Fix any <img> or .png_bg bg-images. Also, please read goo.gl/mZiyb </script>
  <![endif]-->
  	  
<!-- -- --  Hidden Placeholders -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -->

<!-- -- --  End of Hidden Placeholders -- -- -->
	<script>window.jQuery || document.write("<script src='/Style Library/jsv2/libs/jquery-1.5.1.min.js'>\x3C/script>")</script>

	<script type="text/javascript" language="javascript" src="/Style Library/jsv2/libs/slides.min.jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/Style Library/jsv2/main.js"></script>
	<script src="http://munchkin.marketo.net/munchkin.js" type="text/javascript"></script> 
	<script>mktoMunchkin("120-PTN-868");</script>
</BODY>
</html>
