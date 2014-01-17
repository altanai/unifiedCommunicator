package com.tcs.webrtc.bean;

import java.util.ArrayList;

public class AnalyticsBean {

	private int incomingCall []=new int[12];
	private int outgoingCall []=new int[12];
	private ArrayList<String> monthlyIncomingCalls= new ArrayList<String>();
	private ArrayList<String> monthlyOutgoingCalls= new ArrayList<String>();
	private ArrayList<String> labels= new ArrayList<String>();
	
	public ArrayList<String> getMonthlyIncomingCalls() {
		return monthlyIncomingCalls;
	}
	public void setMonthlyIncomingCalls(ArrayList<String> monthlyIncomingCalls) {
		this.monthlyIncomingCalls = monthlyIncomingCalls;
	}
	public ArrayList<String> getMonthlyOutgoingCalls() {
		return monthlyOutgoingCalls;
	}
	public void setMonthlyOutgoingCalls(ArrayList<String> monthlyOutgoingCalls) {
		this.monthlyOutgoingCalls = monthlyOutgoingCalls;
	}
	public ArrayList<String> getLabels() {
		return labels;
	}
	public void setLabels(ArrayList<String> labels) {
		this.labels = labels;
	}

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

}
