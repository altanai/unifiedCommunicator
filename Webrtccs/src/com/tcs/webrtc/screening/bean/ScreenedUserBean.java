package com.tcs.webrtc.screening.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ScreenedUserBean {

	private static ArrayList<String> whiteUsers=new ArrayList<String>(); 	
	private static ArrayList<String> blackUsers=new ArrayList<String>();
	private static Map<String,String> greyUsers=new HashMap<String,String>(); //String contains the Day_start and time stores the blocked duration

	public static ArrayList<String> getWhiteUsers() {
		return whiteUsers;
	}
	public static void setWhiteUsers(ArrayList<String> whiteUsers) {
		ScreenedUserBean.whiteUsers = whiteUsers;
	}
	public static ArrayList<String> getBlackUsers() {
		return blackUsers;
	}
	public static void setBlackUsers(ArrayList<String> blackUsers) {
		ScreenedUserBean.blackUsers = blackUsers;
	}
	public static Map<String, String> getGreyUsers() {
		return greyUsers;
	}
	public static void setGreyUsers(Map<String, String> greyUsers) {
		ScreenedUserBean.greyUsers = greyUsers;
	}

}
