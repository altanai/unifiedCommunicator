package com.tcs.geolocation.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import setups.database_server;

import com.tcs.geolocation.bean.geolocation;


public class writegeolocation {
	
/*	private static String url="jdbc:mysql://localhost:3306/test";
	private static String uName="root";
	private static String pwd="";*/
	
	String url;
	String uName;
	String pwd;
	
	public writegeolocation(){
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
		uName=rdarr[1];
		pwd=rdarr[2];
		
	}
	
	
	
	ArrayList<geolocation> geodatalist=new ArrayList<geolocation>();
	
	public ArrayList<geolocation> viewgeolocationDetails(String user) 
	{
		
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			/*ps=conn.prepareStatement("Select * from geolocation");*/
			ps=conn.prepareStatement("select * from webrtcdb.geolocation a join webrtcdb.friendlisttable b on a.sipuri=b.friendSipURI where b.userSipURI='"+user+"'");
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()){
				
				geolocation geo=new geolocation();
				geo.setSipuri(rs.getString(1));
				geo.setLatitude(rs.getString(2));
				geo.setLongitude(rs.getString(3));
				geo.setDate(rs.getString(4));
				geo.setTime(rs.getString(5));
				geo.setFriendName(rs.getString(8));
				geodatalist.add(geo);
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

		return geodatalist;
	
	}
	
	public int addgeolocationDetails(geolocation g) 
	{
		int resultOfInsert=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			
			ps=conn.prepareStatement("Select sipuri from geolocation where sipuri=?");
			ps.setString(1,g.getSipuri());
			rs=ps.executeQuery();
			
			
			if(rs.next())
			{
				System.out.println(" Geolocation -  alre4day existing or not "+rs);
				ps=conn.prepareStatement("UPDATE geolocation SET latitude =? , longitude=? , date=? ,time =? where sipuri=?");		
				ps.setString(1, g.getLatitude());
				ps.setString(2,g.getLongitude());
				ps.setString(3,g.getDate());
				ps.setString(4,g.getTime());
				ps.setString(5,g.getSipuri());
				resultOfInsert=ps.executeUpdate();
				

			}
			
			else
			{
				System.out.println(" Geolocation -  Not existing  "+rs);
				ps=conn.prepareStatement("INSERT INTO geolocation VALUES (?,?,?,?,?)");
				ps.setString(1,g.getSipuri());
				ps.setString(2, g.getLatitude());
				ps.setString(3,g.getLongitude());
				ps.setString(4,g.getDate());
				ps.setString(5,g.getTime());
				resultOfInsert=ps.executeUpdate();
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

		return resultOfInsert;
	}

	

}

