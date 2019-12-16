package com.tcs.geolocation.bean;

public class geolocation {
String sipuri;
String latitude;
String longitude;
String date;
String time;
String friendName;
public geolocation(String sipuri, String latitude, String longitude,
		String date, String time) {
	super();
	this.sipuri = sipuri;
	this.latitude = latitude;
	this.longitude = longitude;
	this.date = date;
	this.time = time;
	
}
public geolocation() {
	// TODO Auto-generated constructor stub
}
public String getSipuri() {
	return sipuri;
}
public void setSipuri(String sipuri) {
	this.sipuri = sipuri;
}
public String getLatitude() {
	return latitude;
}
public void setLatitude(String latitude) {
	this.latitude = latitude;
}
public String getLongitude() {
	return longitude;
}
public void setLongitude(String longitude) {
	this.longitude = longitude;
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
public String getFriendName() {
	return friendName;
}
public void setFriendName(String friendName) {
	this.friendName = friendName;
}


}
