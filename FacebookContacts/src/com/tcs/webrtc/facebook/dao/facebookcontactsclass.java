package com.tcs.webrtc.facebook.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.tcs.webrtc.facebook.bean.facebookbean;


import setups.database_server;



public class facebookcontactsclass {
	String url;
	String uName;
	String pwd;
	
	public facebookcontactsclass(){
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
		uName=rdarr[1];
		pwd=rdarr[2];
		
	}
	
	
ArrayList<facebookbean> fblist=new ArrayList<facebookbean>();
	
	
	
	public int findfacebookfriends(String facebookusername) 
	{
		int resultOfsearch=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			
			ps=conn.prepareStatement("select sipuri from webrtcdb.facebooklogin where facebookusername=?" );
			ps.setString(1,facebookusername);
			rs=ps.executeQuery();
			
			
			if(rs.next())
			{
				System.out.println(" Facebookcontactsclass- fb user has a account on webrtc  ");
/*				ps=conn.prepareStatement("UPDATE geolocation SET latitude =? , longitude=? , date=? ,time =? where sipuri=?");		
				ps.setString(1, g.getLatitude());*/
				resultOfsearch=ps.executeUpdate();
				

			}
			
			else
			{
				System.out.println(" Facebookcontactsclass- fb user DOES NOT have a account on webrtc  ");
				resultOfsearch=0;
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

		return resultOfsearch;
	}

	
}
