package com.tcs.webrtc.otheraccounts.bean;

public class thirdpartyaccounts {

public thirdpartyaccounts(String sipuri, String googleid,
			String facebookid, String twitterid, String yahooid) {
		super();
		this.sipuri = sipuri;
		this.googleid = googleid;
		this.facebookid = facebookid;
		this.twitterid = twitterid;
		this.yahooid = yahooid;
	}

String sipuri;
String googleid;
String facebookid;
String twitterid;
String yahooid;

public String getSipuri() {
	return sipuri;
}
public void setSipuri(String sipuri) {
	this.sipuri = sipuri;
}
public String getGoogleid() {
	return googleid;
}
public void setGoogleid(String googleid) {
	this.googleid = googleid;
}
public String getFacebookid() {
	return facebookid;
}
public void setFacebookid(String facebookid) {
	this.facebookid = facebookid;
}
public String getTwitterid() {
	return twitterid;
}
public void setTwitterid(String twitterid) {
	this.twitterid = twitterid;
}
public String getYahooid() {
	return yahooid;
}
public void setYahooid(String yahooid) {
	this.yahooid = yahooid;
}

public thirdpartyaccounts() {
	// TODO Auto-generated constructor stub
}

}
