package com.tcs.webrtc.uploadmodule.Dao;
import java.util.*;
import java.sql.*;

import setups.database_server;

import com.tcs.webrtc.uploadmodule.bean.UserProfile;
public class CreateUserDao {
	
/*	private static String url="jdbc:mysql://10.1.5.35:3306/webrtcdb";
	private static String uName="altanai";
	private static String pwd="altanai";*/
	
	String url;
	String uName;
	String pwd;
	
	public CreateUserDao(){
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
		int result=0;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			ps=conn.prepareStatement("Insert into userprofile values(?,?,?,?,?,?,?)");
		//	ps.setString(1, user.getId());
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
				//user.setId(rs.getString(1));
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
	public UserProfile getUser(String id) //to fetch an individual user based on his/her id 
	{
		Connection conn=null;
		UserProfile user=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
		/*	PreparedStatement ps=conn.prepareStatement("Select * from userprofile where username=?");*/
			
			PreparedStatement ps=conn.prepareStatement("select a.*,b.* from webrtcdb.userprofile a join webrtcdb.registrationtable b on a.username=b.privateIdentity where a.username=?");
			/*PreparedStatement ps=conn.prepareStatement("update  webrtcdb.userprofile as a , webrtcdb.registrationtable as b join webrtcdb.userprofile as a on a.username=b.privateIdentity where a.username=?");*/
			
			ps.setString(1, id);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				user=new UserProfile();
				//user.setId(rs.getString(1));
				user.setName(rs.getString(1));
				user.setProfilepic(rs.getBytes(2));
				user.setPicfile(rs.getString(3));
				user.setFavaudio(rs.getBytes(4));
				user.setAudiofile(rs.getString(5));
				user.setFavvideo(rs.getBytes(6));
				user.setVideofile(rs.getString(7));
				user.setDisplayName(rs.getString(8));
				user.setPublicIdentity(rs.getString(9));
				user.setPrivateIdentity(rs.getString(10));
				user.setPassword(rs.getString(11));
				user.setWsUri(rs.getString(12));
				user.setRealm(rs.getString(13));
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
}
