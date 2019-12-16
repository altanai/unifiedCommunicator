package com.tcs.webrtc.interest.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import setups.database_server;




public class InterestDao {
	
/*	private static String url="jdbc:mysql://localhost:3306/test";
	private static String uName="root";
	private static String pwd="";*/
	
	String url;
	String uName;
	String pwd;
	
	String resultgeolocation = null;
	String resultregistration = null,resultregistrationrealm = null;
	
	String resultstudent=null,resultstudentcollegeinstitue =null,resultstudentcoursedegree=null, resultstudentsubject=null ;
	String resultprofessional=null,resultprofessionaljobTitle=null, resultprofessionalproject=null,resultprofessionalindustry=null;
	String resultjobseeker=null, resultjobseekerqualification=null , resultjobseekerfields=null;
	String resultuserinfo=null, resultuserinfocity =null , resultuserinfostate =null, resultuserinfocountry =null;
	
	Connection conn=null;
	PreparedStatement ps=null;
	
	public InterestDao(){
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
		uName=rdarr[1];
		pwd=rdarr[2];
		
		
	}

	/*
     *  Call all method to fetch inetrests 
     */
	public Map getallinterests(String sipuri){
		
		
		HashMap<String, String> map = new HashMap();
		
		try {
			initilaiseconnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(viewprofessionalinterests(sipuri) != null){
			map.put("jobtitle",resultprofessionaljobTitle);
			map.put("project",resultprofessionalproject);
			map.put("industry",resultprofessionalindustry);
			
		}
		
		if(viewregistrationtinterests(sipuri) != null){
			map.put("realm",resultregistrationrealm);
			
		}
		
		try {
			closeconnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
			
	}
	
	
//	/***************************************************************************************************/
	
	
	/*
	 * initilize all conecetions for sel;ecet sql quesrries 
	 */
	public void initilaiseconnection() throws ClassNotFoundException, SQLException{
	

		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		
	}
	
	/*
	 * close all conecetions for sel;ecet sql quesrries 
	 */
	public void closeconnection() throws ClassNotFoundException, SQLException{
	
		
			conn.close();
		
	}
	
//	/**********************************************************************************************/
	
	/* 
	 * fetch inetrests items from geolocation tables
	 */
	public String viewgeolocationinsterest(String sipuri) 
	{

		try
		{
			ps=conn.prepareStatement("select * from webrtcdb.geolocation  where ='"+sipuri+"'");
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()){
				resultgeolocation = rs.getString(1);
			}	
		}
		
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			
		}
		return resultgeolocation;	
	}
	
	

	/* 
	 * fetch inetrests items from geolocation tables
	 */
	public String viewregistrationtinterests(String sipuri) 
	{

		try
		{
			ps=conn.prepareStatement("SELECT Realm FROM webrtcdb.registrationtable where privateIdentity='"+sipuri+"'");
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()){
				resultregistrationrealm = rs.getString(1);
			}	
		}
		
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return resultregistrationrealm;	
	}

	/*
	 * fetch intrests from profile table 
	 */
	public String viewuserinfointerests(String sipuri) 
	{

		try
		{
			ps=conn.prepareStatement("SELECT  city ,state , country FROM webrtcdb.user_info where sipURI='"+sipuri+"'");
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()){
				resultuserinfo="yes";
				resultuserinfocity = rs.getString(1);
				resultuserinfostate = rs.getString(2);
				resultuserinfocountry = rs.getString(3);
			}	
		}
		
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return resultuserinfo;	
	}
	
	/*
	 * fetch inetrests form professional table 
	 */

	/*
	 * fetch intrests from profile table 
	 */
	public String viewprofessionalinterests(String sipuri) 
	{

		try
		{
			ps=conn.prepareStatement("SELECT  jobTitle, project, industry FROM webrtcdb.professionalstable where sipURI='"+sipuri+"'");
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()){
				resultprofessional="yes";
				resultprofessionaljobTitle = rs.getString(1);
				resultprofessionalproject = rs.getString(2);
				resultprofessionalindustry = rs.getString(3);
			}	
		}
		
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return resultprofessional;	
	}
	
}

