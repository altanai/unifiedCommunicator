package phonebook.webrtc;
import java.util.*;
import java.sql.*;

import phonebook.webrtc.UserProfile;
import setups.database_server;
public class CreateUserDao {
	


	
	public ArrayList<UserProfile> getListOfUsers() // to fetch a list of all the users in the database
	{
		//----------------------------- reading frm db config file 
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		
		dbip=rdarr[0];
		uname=rdarr[1];
		pass=rdarr[2];
		//----------------------------- end db config file 
			

		
		Connection conn=null;
		PreparedStatement ps=null;
		ArrayList<UserProfile> listOfUsers=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager
					.getConnection(
							"jdbc:mysql://"+dbip+"/webrtcdb",
							uname, pass);
			ps=conn.prepareStatement("select a.*,b.* from webrtcdb.userprofile a join webrtcdb.registrationtable b on a.username=b.privateIdentity");
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
				user.setDisplayName(rs.getString(8));
				user.setPublicIdentity(rs.getString(9));
				user.setPrivateIdentity(rs.getString(10));
				user.setPassword(rs.getString(11));
				user.setWsUri(rs.getString(12));
				user.setRealm(rs.getString(13));
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
		//----------------------------- reading frm db config file 
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		
		dbip=rdarr[0];
		uname=rdarr[1];
		pass=rdarr[2];
		//----------------------------- end db config file 
		
		Connection conn=null;
		UserProfile user=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager
					.getConnection(
							"jdbc:mysql://"+dbip+"/webrtcdb",
							uname, pass);
		/*	PreparedStatement ps=conn.prepareStatement("Select * from userprofile where username=?");*/
			
			PreparedStatement ps=conn.prepareStatement("select a.*,b.* from webrtcdb.userprofile a join webrtcdb.registrationtable b on a.username=b.privateIdentity where a.username=?");
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
