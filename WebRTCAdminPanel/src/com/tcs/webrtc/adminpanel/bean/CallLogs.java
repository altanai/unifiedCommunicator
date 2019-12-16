package com.tcs.webrtc.adminpanel.bean;

public class CallLogs 
{
	private String caller;
	private String callee;
	private String startTime;
	private String endTime;
	private String dayOfCall;
	
	public String getCaller() {
		return caller;
	}
	public void setCaller(String caller) {
		this.caller = caller;
	}
	public String getCallee() {
		return callee;
	}
	public void setCallee(String callee) {
		this.callee = callee;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getDayOfCall() {
		return dayOfCall;
	}
	public void setDayOfCall(String dayOfCall) {
		this.dayOfCall = dayOfCall;
	}
	
}
