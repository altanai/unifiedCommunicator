package com.tcs.webrtc.uploadmodule.Dao;
import java.util.*;
import java.sql.*;

import setups.database_server;

import com.tcs.webrtc.uploadmodule.bean.UserProfile;
public class CreateUserDao {
	 String url=null;
	 String uName=null;
	 String pwd=null;
	
	public CreateUserDao(){
		
		//----------------------------- reading frm db config file 
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		//----------------------------- end db config file 
		
	 url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
	 uName=rdarr[1];
	 pwd=rdarr[2];
	}


	public int addUser(UserProfile user) //to add a user to the database
	{
		Connection conn=null;
		PreparedStatement ps=null;
		int result=0;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			ps=conn.prepareStatement("Insert into userprofile values(?,?,?,?,?,?,?)");
			ps.setString(1, user.getName());
			ps.setBytes(2, user.getProfilepic());
			ps.setString(3, user.getPicfile());
			ps.setBytes(4, user.getFavaudio());
			ps.setString(5,user.getAudiofile());
			ps.setBytes(6,user.getFavvideo());
			ps.setString(7, user.getVideofile());
			result=ps.executeUpdate();
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
	public ArrayList<UserProfile> getListOfUsers() // to fetch a list of all the users in the database
	{
		Connection conn=null;
		PreparedStatement ps=null;
		ArrayList<UserProfile> listOfUsers=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			ps=conn.prepareStatement("Select * from userprofile");
			listOfUsers=new ArrayList<UserProfile>();
			UserProfile user=null;
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				user=new UserProfile();
				user.setName(rs.getString(1));
				user.setProfilepic(rs.getBytes(2));
				user.setPicfile(rs.getString(3));
				user.setFavaudio(rs.getBytes(4));
				user.setAudiofile(rs.getString(5));
				user.setFavvideo(rs.getBytes(6));
				user.setVideofile(rs.getString(7));
				listOfUsers.add(user);
			}
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return listOfUsers;
	}
	public UserProfile getUser(String uri) //to fetch an individual user based on his/her id 
	{
		Connection conn=null;
		UserProfile user=null;
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			PreparedStatement ps=conn.prepareStatement("Select * from userprofile where username=?");
			ps.setString(1, uri);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				user=new UserProfile();
				user.setName(rs.getString(1));
				user.setProfilepic(rs.getBytes(2));
				user.setPicfile(rs.getString(3));
				user.setFavaudio(rs.getBytes(4));
				user.setAudiofile(rs.getString(5));
				user.setFavvideo(rs.getBytes(6));
				user.setVideofile(rs.getString(7));
			}
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return user;
	}
	
	public ArrayList<UserProfile> getUserprofiledetails(String uri) //to fetch an individual user based on his/her id 
	{
		Connection conn=null;
		
		ArrayList<UserProfile> listOfUsers=null;
		listOfUsers=new ArrayList<UserProfile>();
		UserProfile user=null;
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			PreparedStatement ps=conn.prepareStatement("Select * from userprofile where username=?");
			ps.setString(1, uri);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				user=new UserProfile();
				user.setName(rs.getString(1));
				user.setProfilepic(rs.getBytes(2));
				user.setPicfile(rs.getString(3));
				user.setFavaudio(rs.getBytes(4));
				user.setAudiofile(rs.getString(5));
				user.setFavvideo(rs.getBytes(6));
				user.setVideofile(rs.getString(7));
				listOfUsers.add(user);
			}
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return listOfUsers;
	}
	
	
}
