package com.tcs.webrtc.uploadmodule.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import setups.database_server;

import com.tcs.webrtc.uploadmodule.bean.UserProfile;

public class updateDetailsDao {

	
	
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
			
	
	  	ps1=conn.prepareStatement("update userprofile set profilepic=?,picfile=? where username=?");			
	//	ps.setString(1, user.getId());
	  	ps1.setBytes(1, user.getProfilepic());
		ps1.setString(2, user.getPicfile());
		ps1.setString(3, user.getName());
		
		result=ps1.executeUpdate();
	
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
