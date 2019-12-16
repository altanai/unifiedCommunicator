package com.tcs.webrtc.voicemail.bean;

public class VoiceMail {
	
	private String fromUser;
	private String toUser;
	private String timeOfMail;
	private String voiceMailFile;
	private String voiceMailId;
	
	public String getVoiceMailId() {
		return voiceMailId;
	}
	public void setVoiceMailId(String voiceMailId) {
		this.voiceMailId = voiceMailId;
	}
	private byte[] voiceMail;
	
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getTimeOfMail() {
		return timeOfMail;
	}
	public void setTimeOfMail(String timeOfMail) {
		this.timeOfMail = timeOfMail;
	}
	public String getVoiceMailFile() {
		return voiceMailFile;
	}
	public void setVoiceMailFile(String voiceMailFile) {
		this.voiceMailFile = voiceMailFile;
	}
	public byte[] getVoiceMail() {
		return voiceMail;
	}
	public void setVoiceMail(byte[] voiceMail) {
		this.voiceMail = voiceMail;
	}
	

}
