package phonebook.webrtc;

public class UserProfile {

	private String displayName;
	private String publicIdentity;
	private String privateIdentity;
	private String password;
	private String wsUri;
	private String realm;
	private String name;
	private String audiofile;
	private String videofile;
	private String picfile;
	private byte [] favaudio;
	private byte [] favvideo;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAudiofile() {
		return audiofile;
	}
	public void setAudiofile(String audiofile) {
		this.audiofile = audiofile;
	}
	public String getVideofile() {
		return videofile;
	}
	public void setVideofile(String videofile) {
		this.videofile = videofile;
	}
	public String getPicfile() {
		return picfile;
	}
	public void setPicfile(String picfile) {
		this.picfile = picfile;
	}
	public byte[] getFavaudio() {
		return favaudio;
	}
	public void setFavaudio(byte[] favaudio) {
		this.favaudio = favaudio;
	}
	public byte[] getFavvideo() {
		return favvideo;
	}
	public void setFavvideo(byte[] favvideo) {
		this.favvideo = favvideo;
	}
	public byte[] getProfilepic() {
		return profilepic;
	}
	public void setProfilepic(byte[] profilepic) {
		this.profilepic = profilepic;
	}
	
	
	
}
