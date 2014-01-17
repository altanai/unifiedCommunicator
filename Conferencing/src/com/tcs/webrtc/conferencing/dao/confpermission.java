package com.tcs.webrtc.conferencing.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.tcs.webrtc.conferencing.bean.ConferenceDetails;

public class confpermission {
	private static String url="jdbc:mysql://localhost:3306/webrtcdb";
	private static String uName="altanai";
	private static String pwd="altanai";

	public boolean checkconfpermission(){
		
		return false;
		
	}
	
	public boolean addConferenceDetails(ConferenceDetails conDetails){
		int result=0;
		Connection conn=null;
		PreparedStatement ps=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url,uName,pwd);
			ps=conn.prepareStatement("INSERT INTO CONFERENCING VALUES(?,?,?,?,?,?)");
			ps.setString(1, conDetails.getConferenceName());
			ps.setString(2, conDetails.getHost());
			ps.setString(3, conDetails.getUserName());
			ps.setString(4, conDetails.getPassword());
			ps.setString(5, conDetails.getDate());
			ps.setString(6, conDetails.getConferenceType());
			result=ps.executeUpdate();
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return result>0?true:false;
	}
}
