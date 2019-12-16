package com.tcs.webrtc.screening.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import com.tcs.webrtc.screening.bean.ListingBeans;
import com.tcs.webrtc.screening.bean.ScreenedUserBean;



public class ScreeningDao {
	private static String url="jdbc:mysql://localhost:3306/testwork";
	private static String uName="root";
	private static String pwd="sad123";


	public int addBlackUser(String currentUser, String blockedUser) {
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			ps = conn.prepareStatement("Select * from BlackUsers where user=? and blackuser=?");
			ps.setString(1, currentUser);
			ps.setString(2, blockedUser);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				result=4;
				return result;
			}
			else{
				ps = conn.prepareStatement("Insert into BlackUsers values (?,?)");
				ps.setString(1, currentUser);
				ps.setString(2, blockedUser);
				result = ps.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception Occured:");
		}
		finally{
			if(conn!=null){
				try{
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		}

		return result;
	}
	
	public boolean addGreyListing(ListingBeans lb,String sipUri) throws ClassNotFoundException {
		PreparedStatement ps = null;
		Connection con = null;
		int res=0;
	
		try {	   
			Class.forName("com.mysql.jdbc.Driver");   
			con = DriverManager.getConnection(url, uName, pwd);
			ps=con.prepareStatement("SELECT USER FROM DNDVALUES WHERE USER=?");
			ps.setString(1, lb.getUser());
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				res=1;
			}
			if(res==0)
			{
				ps = con.prepareStatement("INSERT into DNDVALUES values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps.setString(1, lb.getUser());
				ps.setString(2,	lb.getMonStartTime());
				ps.setString(3, lb.getMonStopTime());
				ps.setString(4, lb.getTueStartTime());
				ps.setString(5, lb.getTueStopTime());
				ps.setString(6, lb.getWedStartTime());
				ps.setString(7, lb.getWedStopTime());
				ps.setString(8, lb.getThuStartTime());
				ps.setString(9, lb.getThuStopTime());
				ps.setString(10, lb.getFriStartTime());
				ps.setString(11, lb.getFriStopTime());
				ps.setString(12, lb.getSatStartTime());
				ps.setString(13, lb.getSatStopTime());
				ps.setString(14, lb.getSunStartTime());
				ps.setString(15, lb.getSunStopTime());
				res=ps.executeUpdate();
			}
			else if(res==1)
			{
				res=0;
				ps=con.prepareStatement("UPDATE DNDVALUES SET MON_STRT=?,MON_END=?,TUE_STRT=?,TUE_END=?,WED_STRT=?," +
										"WED_END=?,THU_STRT=?,THU_END=?,FRI_STRT=?,FRI_END=?,SAT_STRT=?,SAT_END=?," +
										"SUN_STRT=?,SUN_END=? WHERE USER='"+sipUri+"'");
				ps.setString(1,	lb.getMonStartTime());
				ps.setString(2, lb.getMonStopTime());
				ps.setString(3, lb.getTueStartTime());
				ps.setString(4, lb.getTueStopTime());
				ps.setString(5, lb.getWedStartTime());
				ps.setString(6, lb.getWedStopTime());
				ps.setString(7, lb.getThuStartTime());
				ps.setString(8, lb.getThuStopTime());
				ps.setString(9, lb.getFriStartTime());
				ps.setString(10, lb.getFriStopTime());
				ps.setString(11, lb.getSatStartTime());
				ps.setString(12, lb.getSatStopTime());
				ps.setString(13, lb.getSunStartTime());
				ps.setString(14, lb.getSunStopTime());
				res=ps.executeUpdate();
			}
		}catch (SQLException e){
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if(con!=null)
				con.close();
			}
			catch(Exception e){e.printStackTrace();}
		}
		return res>0?true:false;

	}
	
	
	public boolean checkBlackUser(String callee, String caller) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			ps = conn.prepareStatement("Select * from BlackUsers where user=? and blockeduser=?");
			ps.setString(1, callee);
			ps.setString(2, caller);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			if(conn!=null){
				try{
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		return false;
	}

	public void loadCollection(String sipUri) {
		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<String> whiteUsers=new ArrayList<String>();
		ArrayList<String> blackUsers=new ArrayList<String>();
		Map<String,String> greyUsers=new HashMap<String,String>(); 
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			ps=conn.prepareStatement("SELECT WHITEUSER FROM WHITEUSERS WHERE USER='"+sipUri+"'");
			ResultSet resultSet=ps.executeQuery();
			while(resultSet.next())
			{
				whiteUsers.add(resultSet.getString(1));
			}
			ps=conn.prepareStatement("SELECT BLACKUSER FROM BLACKUSERS WHERE USER='"+sipUri+"'");
			ResultSet resultSet1=ps.executeQuery();
			while(resultSet1.next())
			{
				blackUsers.add(resultSet1.getString(1));
			}
			ps=conn.prepareStatement("SELECT * FROM DNDVALUES WHERE USER='"+sipUri+"'");
			ResultSet mapResult=ps.executeQuery();
			while(mapResult.next())
			{
				greyUsers.put("Mon_Strt", mapResult.getString(2));
				greyUsers.put("Mon_End", mapResult.getString(3));
				greyUsers.put("Tue_Strt", mapResult.getString(4));
				greyUsers.put("Tue_End", mapResult.getString(5));
				greyUsers.put("Wed_Strt", mapResult.getString(6));
				greyUsers.put("Wed_End", mapResult.getString(7));
				greyUsers.put("Thu_Strt", mapResult.getString(8));
				greyUsers.put("Thu_End", mapResult.getString(9));
				greyUsers.put("Fri_Strt", mapResult.getString(10));
				greyUsers.put("Fri_End", mapResult.getString(11));
				greyUsers.put("Sat_Strt", mapResult.getString(12));
				greyUsers.put("Sat_End", mapResult.getString(13));
				greyUsers.put("Sun_Strt", mapResult.getString(14));
				greyUsers.put("Sun_End", mapResult.getString(15));
			}
			ScreenedUserBean.setBlackUsers(blackUsers);
			ScreenedUserBean.setWhiteUsers(whiteUsers);
			ScreenedUserBean.setGreyUsers(greyUsers);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			if(conn!=null){
				try{
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		
	}
	
	public int addWhiteUser(String currentUser, String whiteUser) {
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			ps = conn.prepareStatement("Select * from WhiteUsers where user=? and whiteUser=?");
			ps.setString(1, currentUser);
			ps.setString(2, whiteUser);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				result=4;
				return result;
			}
			else{
				ps = conn.prepareStatement("Insert into WhiteUsers values (?,?)");
				ps.setString(1, currentUser);
				ps.setString(2, whiteUser);
				result = ps.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception Occured:");
		}
		finally{
			if(conn!=null){
				try{
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		}

		return result;
	}

	public ArrayList<String> getListOfCallers(String queryFilter) {
		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<String> list=new ArrayList<String>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			ps = conn.prepareStatement("Select distinct caller from calllogs where caller like '%"+queryFilter+"%'");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) 
				{
				list.add(rs.getString(1));
				}
			}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception Occured:");
			}
		finally{
			if(conn!=null){
				try{
					conn.close();
				}catch(Exception e){e.printStackTrace();}
			}
		}
		return list;
		
	}
}
