package com.tcs.webrtc.uploadmodule.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import setups.database_server;

import com.tcs.webrtc.uploadmodule.bean.UserProfile;

public class updateDetailsDao {

	/*	
	private static String url="jdbc:mysql://10.1.5.35:3306/webrtcdb";
	private static String uName="altanai";
	private static String pwd="altanai";*/
	
	String url;
	String uName;
	String pwd;
	
	public updateDetailsDao(){
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
		uName=rdarr[1];
		pwd=rdarr[2];
		
	}

	public int addUser(UserProfile user) //to add a user to the database
	{
		Connection conn=null;
		PreparedStatement ps=null;
		PreparedStatement ps1=null;
		int result=0;

		
		try
		{
			System.out.println("pic"+user.getProfilepic());
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			
		/*	conn.setAutoCommit(false);
	
		
		System.out.println("2");
		ps=conn.prepareStatement("delete from webrtcdb.userprofile where username=?");
		ps.setString(1, user.getName());
		System.out.println("3");
		int x=ps.executeUpdate();
		System.out.println("int "+x);*/
	  	ps1=conn.prepareStatement("update userprofile set profilepic=?,picfile=? where username=?");			
	//	ps.setString(1, user.getId());
	  	ps1.setBytes(1, user.getProfilepic());
		ps1.setString(2, user.getPicfile());
		ps1.setString(3, user.getName());
		
		result=ps1.executeUpdate();
			
	/*	ps1=conn.prepareStatement("insert into webrtcdb.userprofile values(?,?,?,?,?,?,?");
		ps1.setString(1, user.getName());
		ps1.setBytes(2, user.getProfilepic());
		ps1.setString(3, user.getPicfile());
		ps1.setBytes(4, user.getFavaudio());
		ps1.setString(5,user.getAudiofile());
		ps1.setBytes(6,user.getFavvideo());
		ps1.setString(7, user.getVideofile());
		int y=ps1.executeUpdate();
		if(x>0&&y>0){
	conn.commit();
		
	}
		else{
			conn.rollback();
		}*/
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return result;
		
		
	}
}
