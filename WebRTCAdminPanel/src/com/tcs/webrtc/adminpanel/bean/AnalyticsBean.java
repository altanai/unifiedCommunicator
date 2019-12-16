package com.tcs.webrtc.adminpanel.bean;

public class AnalyticsBean {

private int incomingCall []=new int[12];
public int[] getIncomingCall() {
	return incomingCall;
}
public void setIncomingCall(int[] incomingCall) {
	this.incomingCall = incomingCall;
}
public int[] getOutgoingCall() {
	return outgoingCall;
}
public void setOutgoingCall(int[] outgoingCall) {
	this.outgoingCall = outgoingCall;
}
private int outgoingCall []=new int[12];
}
