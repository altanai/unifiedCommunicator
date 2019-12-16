package com.tcs.webrtc.otheraccounts.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import setups.database_server;

import com.tcs.webrtc.otheraccounts.bean.*;

public class thirdpartyaccountdao {
	String url;
	String uName;
	String pwd;
	
	public thirdpartyaccountdao(){
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
		uName=rdarr[1];
		pwd=rdarr[2];
		
	}
	
	
	
	ArrayList<thirdpartyaccounts> otheraccountdatalist=new ArrayList<thirdpartyaccounts>();
	
	public ArrayList<thirdpartyaccounts> viewthirdpartyaccountDetails(String sipuri) 
	{
		
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			ps=conn.prepareStatement("Select sipuri, googleid,facebookid,twitterid,yahooid from m_otheraccounts where sipuri=?");
			ps.setString(1,sipuri);
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()){
				
				thirdpartyaccounts geo=new thirdpartyaccounts();
				geo.setSipuri(rs.getString(1));
				geo.setGoogleid(rs.getString(2));
				geo.setFacebookid(rs.getString(3));
				geo.setTwitterid(rs.getString(4));
				geo.setYahooid(rs.getString(5));
				otheraccountdatalist.add(geo);
				
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

		
		return otheraccountdatalist;
	
	}
	
	
	
	
	
	
	
	public int addthirdpartyaccountDetails(thirdpartyaccounts tpa) 
	{
		int resultOfInsert=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			
			ps=conn.prepareStatement("Select sipuri from m_otheraccounts where sipuri=?");
			ps.setString(1,tpa.getSipuri());
			rs=ps.executeQuery();
			
			
			if(rs.next())
			{
				System.out.println(" other account links -  alreaday existing or not "+rs);
				ps=conn.prepareStatement("UPDATE m_otheraccounts SET  googleid=? , facebookid=? ,twitterid =?, yahooid=? where sipuri=?");		
				//add variables 
				ps.setString(1, tpa.getGoogleid());
				ps.setString(2, tpa.getFacebookid());
				ps.setString(3, tpa.getTwitterid());
				ps.setString(4, tpa.getYahooid());
				ps.setString(5, tpa.getSipuri());
				
				resultOfInsert=ps.executeUpdate();
				

			}
			
			else
			{
				System.out.println(" other account links -  Not existing  "+rs);
				ps=conn.prepareStatement("INSERT INTO m_otheraccounts(sipuri,googleid,facebookid,twitterid,yahooid) VALUES (?,?,?,?,?)");
				ps.setString(1,tpa.getSipuri());
				ps.setString(2,tpa.getGoogleid());
				ps.setString(3,tpa.getFacebookid());
				ps.setString(4,tpa.getTwitterid());
				ps.setString(5,tpa.getYahooid());
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

	
	
	public static void main(String args []){
		thirdpartyaccountdao tpdao=new thirdpartyaccountdao();
		ArrayList<thirdpartyaccounts> tplist=tpdao.viewthirdpartyaccountDetails("sip:alice@tcs.com");
		System.out.println(" third party user account list " + tplist.size()+ " " +tplist  );
		System.out.println(" tplist  googleid="+tplist.get(0).getGoogleid()+"&yahooid="+tplist.get(0).getYahooid()+"&facebookid="+tplist.get(0).getFacebookid()+"&twitterid="+tplist.get(0).getTwitterid() );

	}	
	
	
}


