package com.tcs.webrtc.notification.bean;

public class Notification {
	
	private String sender;
	private String reciever;
	private String timeOfNotification;
	private String typeOfNotification;
	private String notificationId;
	private String messageForUser;
	
	public Notification()
	{
		
	}
	
	public Notification(String notificationId,String sender, String reciever,
			String timeOfNotification, String typeOfNotification) 
	{
		super();
		this.sender = sender;
		this.reciever = reciever;
		this.timeOfNotification = timeOfNotification;
		this.typeOfNotification = typeOfNotification;
		this.notificationId = notificationId;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReciever() {
		return reciever;
	}
	public void setReciever(String reciever) {
		this.reciever = reciever;
	}
	public String getTimeOfNotification() {
		return timeOfNotification;
	}
	public void setTimeOfNotification(String timeOfNotification) {
		this.timeOfNotification = timeOfNotification;
	}
	public String getTypeOfNotification() {
		return typeOfNotification;
	}
	public void setTypeOfNotification(String typeOfNotification) {
		this.typeOfNotification = typeOfNotification;
	}
	public String getNotificationId() {
		return notificationId;
	}
	public void setNotificationId(String notificationId) {
		this.notificationId = notificationId;
	}
	public String getMessageForUser() {
		return messageForUser;
	}
	public void setMessageForUser(String messageForUser) {
		this.messageForUser = messageForUser;
	}
	
	
	
	

}
