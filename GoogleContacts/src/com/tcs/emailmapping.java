package com.tcs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import setups.database_server;

public class emailmapping {
	String url;
	String uName;
	String pwd;
	
	public emailmapping(){
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
		uName=rdarr[1];
		pwd=rdarr[2];
		
	}
	
	public String sipuritogmailid(String sipuri) 
	{
	
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
		
			ps=conn.prepareStatement("Select googleid from m_otheraccounts where sipuri=?");
			ps.setString(1,sipuri);
			ResultSet rs=ps.executeQuery();
			
		while(rs.next()){
				
				return rs.getString(1);

			}

			
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				conn.close();
			}catch (SQLException e) {e.printStackTrace();}
		}
		return "notfound";

	
	}
}
