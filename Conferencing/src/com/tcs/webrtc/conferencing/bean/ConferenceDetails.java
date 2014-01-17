package com.tcs.webrtc.conferencing.bean;

public class ConferenceDetails {
	private String host;
	private String userName;
	private String date;
	private String time;
	private String password;
	private String conferenceRoom;
	private String conferenceName;
	private String conferenceType;
	
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getConferenceType() {
		return conferenceType;
	}
	public void setConferenceType(String conferenceType) {
		this.conferenceType = conferenceType;
	}
	public String getConferenceName() {
		return conferenceName;
	}
	public void setConferenceName(String conferenceName) {
		this.conferenceName = conferenceName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConferenceRoom() {
		return conferenceRoom;
	}
	public void setConferenceRoom(String conferenceRoom) {
		this.conferenceRoom = conferenceRoom;
	}

	
}
