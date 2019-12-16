package com.tcs.webrtc.adminpanel.bean;

public class UserProfile {

	private String displayName;
	private String publicIdentity;
	private String privateIdentity;
	private String wsUri;
	private String realm;
	private String picfile;
	private byte [] profilepic;
	
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public String getPublicIdentity() {
		return publicIdentity;
	}
	public void setPublicIdentity(String publicIdentity) {
		this.publicIdentity = publicIdentity;
	}
	public String getPrivateIdentity() {
		return privateIdentity;
	}
	public void setPrivateIdentity(String privateIdentity) {
		this.privateIdentity = privateIdentity;
	}
	
	public String getWsUri() {
		return wsUri;
	}
	public void setWsUri(String wsUri) {
		this.wsUri = wsUri;
	}
	public String getRealm() {
		return realm;
	}
	public void setRealm(String realm) {
		this.realm = realm;
	}
	
	public String getPicfile() {
		return picfile;
	}
	public void setPicfile(String picfile) {
		this.picfile = picfile;
	}
	
	public byte[] getProfilepic() {
		return profilepic;
	}
	public void setProfilepic(byte[] profilepic) {
		this.profilepic = profilepic;
	}
	
	
	
}
