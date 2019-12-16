package com.tcs.webrtc.adminpanel.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import setups.database_server;

import com.tcs.webrtc.adminpanel.bean.AdminBean;
import com.tcs.webrtc.adminpanel.bean.FriendsBean;
import com.tcs.webrtc.adminpanel.bean.UserBean;
import com.tcs.webrtc.adminpanel.bean.CallLogs;
import com.tcs.webrtc.adminpanel.bean.AnalyticsBean;
import com.tcs.webrtc.adminpanel.bean.UserProfile;

public class AdminDao {

	 String url=null;
	 String uName=null;
	 String pwd=null;

	public void demoFunction()
	{
	/*	int resultOfInsert=0;
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
		}
		catch(ClassNotFoundException e){e.printStackTrace();}
		catch(SQLException e){e.printStackTrace();}*/
	}
	
	public AdminDao(){
		
		//----------------------------- reading frm db config file 
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		//----------------------------- end db config file 
		
	 url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
	 uName=rdarr[1];
	 pwd=rdarr[2];
	}

	public ArrayList<UserBean> getAllUsers() {
		ArrayList<UserBean> userList= new ArrayList<UserBean>();
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT A.DISPLAYNAME,A.PUBLICIDENTITY,A.PRIVATEIDENTITY,A.WSURI,A.REALM FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM REGISTRATIONTABLE C, (SELECT @ROWNUM:=0) R)A";
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				UserBean userBean = new UserBean();
				userBean.setDisplayName(resultSet.getString(1));
				userBean.setPublicIdentity(resultSet.getString(2));
				userBean.setPrivateIdentity(resultSet.getString(3));
				userBean.setWsUri(resultSet.getString(4));
				userBean.setRealm(resultSet.getString(5));
				userList.add(userBean);
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
			}catch (SQLException e) {
				e.printStackTrace();
				}
		}
		return userList;
	
		
	}

	public UserBean getUserDetails(String sipUri) {
		Connection conn=null;
		PreparedStatement ps=null;
		UserBean userBean=new UserBean();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			
			String Query="SELECT * FROM REGISTRATIONTABLE WHERE PRIVATEIDENTITY='"+sipUri+"'";
			ps=conn.prepareStatement(Query);
			ResultSet resultSet=ps.executeQuery();
			
			while(resultSet.next()){
				userBean.setDisplayName(resultSet.getString(1));
				userBean.setPublicIdentity(resultSet.getString(2));
				userBean.setPrivateIdentity(resultSet.getString(3));
				userBean.setWsUri(resultSet.getString(5));
				userBean.setRealm(resultSet.getString(6));
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
	
		return userBean;
	}
	
	public boolean updateUserDetails(UserBean user)
	{
		Connection conn=null;
		PreparedStatement ps=null;
		boolean flag=false;
		int r1,r2,r3,r4=0;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			conn.setAutoCommit(false);
			String query="UPDATE REGISTRATIONTABLE SET DISPLAYNAME='"+user.getDisplayName()+"',PUBLICIDENTITY='"+user.getPublicIdentity()+"',WSURI='"+user.getWsUri()+"',REALM='"+user.getRealm()+"'" +
					"WHERE PRIVATEIDENTITY='"+user.getPrivateIdentity()+"'";
			 ps=conn.prepareStatement(query);
			 r1=ps.executeUpdate();
			 query="UPDATE LOGIN SET USERNAME='"+user.getDisplayName()+"'WHERE PRIVATEIDENTITY='"+user.getPrivateIdentity()+"'";
			 ps=conn.prepareStatement(query);
			 r2=ps.executeUpdate();
			 query="UPDATE FORGOTPWD SET USERNAME='"+user.getDisplayName()+"'WHERE PRIVATEIDENTITY='"+user.getPrivateIdentity()+"'";
			 ps=conn.prepareStatement(query);
			 r3=ps.executeUpdate();
			 query="UPDATE SIPTABLE SET USERNAME='"+user.getDisplayName()+"'WHERE PRIVATEIDENTITY='"+user.getPrivateIdentity()+"'";
			 ps=conn.prepareStatement(query);
			 r4=ps.executeUpdate();
			 if(r1==1&&r2==1&&r3==1&&r4==1)
			 {
				 conn.commit();
				 conn.setAutoCommit(true);
				 flag=true;
			 }
			 else {
				 conn.rollback();
				 conn.setAutoCommit(true);
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
		return flag;
	}
	
	public boolean deleteUser(String userId)
	{
		Connection conn=null;
		PreparedStatement ps=null;
		boolean flag=false;
		int resultOfDelete,r2,r3,r4,r5,r6=0;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			conn.setAutoCommit(false);
			String query="DELETE FROM REGISTRATIONTABLE WHERE PRIVATEIDENTITY='"+userId+"'";
			ps=conn.prepareStatement(query);
			resultOfDelete=ps.executeUpdate();
			
			query="DELETE FROM FORGOTPWD WHERE PRIVATEIDENTITY='"+userId+"'";
			ps=conn.prepareStatement(query);
			r3=ps.executeUpdate();
			query="DELETE FROM FRIENDLISTTABLE  WHERE USERSIPURI='"+userId+"' OR FRIENDSIPURI='"+userId+"'";
			ps=conn.prepareStatement(query);
			r4=ps.executeUpdate();
			query="DELETE FROM LOGIN WHERE PRIVATEIDENTITY='"+userId+"'";
			ps=conn.prepareStatement(query);
			r5=ps.executeUpdate();
			query="DELETE FROM SIPTABLE WHERE PRIVATEIDENTITY='"+userId+"'";
			ps=conn.prepareStatement(query);
			r2=ps.executeUpdate();
			query="DELETE FROM USERPROFILE WHERE USERNAME='"+userId+"'";
			ps=conn.prepareStatement(query);
			r6=ps.executeUpdate();
			if( resultOfDelete>0||r2>0||r3>0||r4>0||r5>0||r6>0)
			{
				conn.commit();
				conn.setAutoCommit(true);
				flag=true;
			}
			else{
				conn.rollback();
				conn.setAutoCommit(true);
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
		
		return flag;
	}

	public UserBean getUserProfilePic(String userId) {
		Connection conn=null;
		PreparedStatement ps=null;
		UserBean userBean=new UserBean();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String query="SELECT PROFILEPIC,PICFILE FROM USERPROFILE WHERE USERNAME='"+userId+"'";
			ps=conn.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				userBean.setProfilepic(rs.getBytes(1));
				userBean.setPicfile(rs.getString(2));
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
		return userBean;
	}

	public UserBean getPaticularUserDetails(String searchField, String searchVal) {
	
		Connection conn=null;
		PreparedStatement ps=null;
		UserBean userBean=new UserBean();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String Query="";
			if(searchField.equalsIgnoreCase("userSipUri"));
			{
				 Query="SELECT * FROM REGISTRATIONTABLE WHERE PRIVATEIDENTITY='"+searchVal+"'";
			}
			if(searchField.equalsIgnoreCase("userDisplayName"))
			{
				 Query="SELECT * FROM REGISTRATIONTABLE WHERE DISPLAYNAME='"+searchVal+"'";
			}
			System.out.println(Query);
			ps=conn.prepareStatement(Query);
			ResultSet resultSet=ps.executeQuery();
			
			while(resultSet.next()){
				userBean.setDisplayName(resultSet.getString(1));
				userBean.setPublicIdentity(resultSet.getString(2));
				userBean.setPrivateIdentity(resultSet.getString(3));
				userBean.setWsUri(resultSet.getString(5));
				userBean.setRealm(resultSet.getString(6));
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
	
		return userBean;
	}
	
	public ArrayList<CallLogs> viewAllLogs(int jtStartIndex, int jtPageSize, String jtSorting) throws ClassNotFoundException,SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		String query="SELECT A.CALLER,A.CALLEE,A.DAY,A.STARTTIME,A.ENDTIME FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM CALLLOGS C, (SELECT @ROWNUM:=0) R ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
		String query2="SELECT A.CALLER,A.CALLEE,A.DAY,A.STARTTIME,A.ENDTIME FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM CALLLOGS C, (SELECT @ROWNUM:=0) R ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
		System.out.println(query);
		System.out.println(query2);
		ps=conn.prepareStatement(query);
		ResultSet resultSet=ps.executeQuery();
		ArrayList<CallLogs> listOfLogs=new ArrayList<CallLogs>();
		CallLogs log=null;
		while(resultSet.next())
		{
			log=new CallLogs();
			log.setCaller(resultSet.getString(1));
			log.setCallee(resultSet.getString(2));
			log.setStartTime(resultSet.getString(4));
			log.setEndTime(resultSet.getString(5));
			log.setDayOfCall(resultSet.getString(3));
			listOfLogs.add(log);
		}
		conn.close();
		return listOfLogs;
	}

	public ArrayList<CallLogs> viewAllLogs(int jtStartIndex, int jtPageSize,
			String jtSorting, String queryFilter, String filterType) throws ClassNotFoundException,SQLException {

		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		String query="SELECT A.CALLER,A.CALLEE,A.DAY,A.STARTTIME,A.ENDTIME FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM CALLLOGS C, (SELECT @ROWNUM:=0) R  WHERE "+filterType+" LIKE '%"+queryFilter+"%' ORDER BY "+jtSorting +") A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
		System.out.println(query);
		ps=conn.prepareStatement(query);
		ResultSet resultSet=ps.executeQuery();
		ArrayList<CallLogs> listOfLogs=new ArrayList<CallLogs>();
		CallLogs log=null;
		while(resultSet.next())
		{
			log=new CallLogs();
			log.setCaller(resultSet.getString(1));
			log.setCallee(resultSet.getString(2));
			log.setStartTime(resultSet.getString(4));
			log.setEndTime(resultSet.getString(5));
			log.setDayOfCall(resultSet.getString(3));
			listOfLogs.add(log);
		}
		conn.close();
		return listOfLogs;
	}
	
	public int getLogCount() throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM CALLLOGS");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}

	public int getLogCount(String queryFilter, String filterType) throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM CALLLOGS WHERE "+filterType+" LIKE '%"+queryFilter+"%'");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}
	
	public ArrayList<UserBean> viewAllUsers(int jtStartIndex, int jtPageSize, String jtSorting) throws ClassNotFoundException,SQLException 
	{
		ArrayList<UserBean> userList= new ArrayList<UserBean>();
		Connection conn=null;
		PreparedStatement ps=null;
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT A.DISPLAYNAME,A.PUBLICIDENTITY,A.PRIVATEIDENTITY,A.WSURI,A.REALM FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM REGISTRATIONTABLE C, (SELECT @ROWNUM:=0)R ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) 
			{
				UserBean userBean = new UserBean();
				userBean.setDisplayName(resultSet.getString(1));
				userBean.setPublicIdentity(resultSet.getString(2));
				userBean.setPrivateIdentity(resultSet.getString(3));
				userBean.setWsUri(resultSet.getString(4));
				userBean.setRealm(resultSet.getString(5));
				userList.add(userBean);
			}
		return userList;
	}
	
	public ArrayList<UserBean> viewAllUsers(int jtStartIndex, int jtPageSize,
			String jtSorting, String filterVal, String filterField) throws ClassNotFoundException,SQLException 
			{
		ArrayList<UserBean> userList= new ArrayList<UserBean>();
		Connection conn=null;
		PreparedStatement ps=null;
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT A.DISPLAYNAME,A.PUBLICIDENTITY,A.PRIVATEIDENTITY,A.WSURI,A.REALM FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM REGISTRATIONTABLE C, (SELECT @ROWNUM:=0)R WHERE "+filterField+" LIKE '%"+filterVal+"%' ORDER BY "+jtSorting +") A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) 
			{
				UserBean userBean = new UserBean();
				userBean.setDisplayName(resultSet.getString(1));
				userBean.setPublicIdentity(resultSet.getString(2));
				userBean.setPrivateIdentity(resultSet.getString(3));
				userBean.setWsUri(resultSet.getString(4));
				userBean.setRealm(resultSet.getString(5));
				userList.add(userBean);
			}
		return userList;
	}
	
	public int getUserCount() throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM REGISTRATIONTABLE");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}

	public int getUserCount(String filterValue, String filterField) throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM REGISTRATIONTABLE WHERE "+filterField+" LIKE '%"+filterValue+"%'");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}

	public ArrayList<String> getDataForAutoComplete(String filter,
			String filterBy) {
		ArrayList<String> userList= new ArrayList<String>();
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT DISTINCT "+filterBy+" FROM REGISTRATIONTABLE WHERE "+filterBy+" like '%"+filter+"%'";
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				userList.add(resultSet.getString(1));
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
		return userList;
	}

	public AdminBean checkAdmin(String id, String password) {
		
		
		Connection conn=null;
		PreparedStatement ps=null;
		AdminBean adminBean= new AdminBean();
		String status="active";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String Query="select * from adminlogin where adminid='"+id+"' and password='"+password+"' and status='"+status+"'";
			ps=conn.prepareStatement(Query);
			ResultSet resultSet=ps.executeQuery();
			while(resultSet.next()){
				
				adminBean.setUserId(resultSet.getString(1));
				adminBean.setAdminType(resultSet.getString(3));
				adminBean.setAdminStatus(resultSet.getString(4));
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
		return adminBean;
		
	}

	public String resetUserPassword(String sipUri) {
		Connection conn=null;
		PreparedStatement ps=null;
		String query="";
		String msg="The password could not be reset.";
		String paswrd="";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			ps=conn.prepareStatement("SELECT DISPLAYNAME FROM REGISTRATIONTABLE WHERE PRIVATEIDENTITY='"+sipUri+"'");
			ResultSet resultSet=ps.executeQuery();
			while(resultSet.next()){
				paswrd=resultSet.getString(1)+"@123";
			}
			query="UPDATE REGISTRATIONTABLE SET PASSWORD='"+paswrd+"' WHERE PRIVATEIDENTITY='"+sipUri+"'";
			ps=conn.prepareStatement(query);
			int flag=ps.executeUpdate();
			if(flag>0){
				msg="The password for user with "+sipUri+" has been reset to user's display name@1234";
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
		return msg;
	}
	
	public com.tcs.webrtc.adminpanel.bean.AnalyticsBean populateGraphDataByYear(String sipURI) {
		AnalyticsBean analyticsBean= new AnalyticsBean();
		int [] incomingCalls=new int[12];
		int [] outgoingCalls= new int[12];
		String [] month={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
		Calendar cal=Calendar.getInstance();
		int year=cal.get(Calendar.YEAR);
		int i=0;
		Connection conn2=null; 
		Statement stmt=null;
		String query=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn2 = DriverManager.getConnection(url, uName, pwd);
			stmt = conn2.createStatement();
			for(i=0;i<12;i++)
			{
				System.out.println("in for loop2");
				if(i==3||i==5||i==8||i==10)
				{
					query="select count(caller) from calllogs where day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==0||i==2||i==4||i==6||i==7||i==9||i==11)
				{
					query="select count(caller) from calllogs where day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==1)
				{
					query="select count(caller) from calllogs where day like '%"+ month[i]+", "+year+"'";
				}
					ResultSet rs=stmt.executeQuery(query);
					while(rs.next())
					{
						incomingCalls[i]=rs.getInt(1);
					}
			}
			for(i=0;i<12;i++)
			{
				System.out.println("in for loop2");
				if(i==3||i==5||i==8||i==10)
				{
					query="select count(callee) from calllogs where day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==0||i==2||i==4||i==6||i==7||i==9||i==11)
				{
					query="select count(callee) from calllogs where day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==1)
				{
					query="select count(callee) from calllogs where day like '%"+ month[i]+", "+year+"'";
				}
					ResultSet rs=stmt.executeQuery(query);
					while(rs.next())
					{
						outgoingCalls[i]=rs.getInt(1);
					}
			}
			System.out.println("\n outgoing :");
			for(int j:outgoingCalls)
			{
				System.out.print(j);
			}
			System.out.println("\n Incoming :");
			for(int j:incomingCalls)
			{
				System.out.print(j);
			}
			analyticsBean.setIncomingCall(incomingCalls);
			analyticsBean.setOutgoingCall(outgoingCalls);
		}
		catch(SQLException s){
			System.out.println(s.getMessage());
		}
		catch (ClassNotFoundException c) {
			System.out.println(c.getMessage());
		}
		finally
		{
			/*try 
			{
			conn2.close();
			} catch (SQLException e) {e.printStackTrace();}*/
		}
		return analyticsBean;
	}
	
	public boolean createUserProfile(UserProfile user) 
	{
		boolean resultOfInsert=false;
		int r1=0,r2,r3,r4;
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String Query="INSERT INTO REGISTRATIONTABLE VALUES (?,?,?,?,?,?)";
			ps=conn.prepareStatement(Query);
			ps.setString(1, user.getDisplayName());
			ps.setString(2, user.getPublicIdentity());
			ps.setString(3, user.getPrivateIdentity());
			ps.setString(4, user.getDisplayName()+"@1234");
			ps.setString(5, user.getWsUri());
			ps.setString(6, user.getRealm());
			r1=ps.executeUpdate();
			
			Query="INSERT INTO USERPROFILE (USERNAME,PROFILEPIC,PICFILE) VALUES (?,?,?)";
			ps=conn.prepareStatement(Query);
			ps.setString(1, user.getPrivateIdentity());
			ps.setBytes(2,	user.getProfilepic());
			ps.setString(3, user.getPicfile());
			r2=ps.executeUpdate();
			
			Query="INSERT INTO FORGOTPWD VALUES (?,?,?,?,?,?)";
			ps=conn.prepareStatement(Query);
			ps.setString(1, user.getDisplayName());
			ps.setString(2, user.getPublicIdentity());
			ps.setString(3, user.getPrivateIdentity());
			ps.setString(4, user.getRealm());
			ps.setString(5, "Default");
			ps.setString(6, "Default");
			r3=ps.executeUpdate();
			
			Query="INSERT INTO SIPTABLE VALUES (?,?)";
			ps=conn.prepareStatement(Query);
			ps.setString(1,	user.getPublicIdentity() );
			ps.setString(2, user.getPrivateIdentity());
			r4=ps.executeUpdate();
			
			if(r1>0&&r2>0&&r3>0&&r4>0)
			{
				resultOfInsert=true;
			}
		}
		catch(ClassNotFoundException e){e.printStackTrace();}
		catch(SQLException e){e.printStackTrace();}
		finally
		{
			try
			{
				conn.close();
			}catch (SQLException e) {e.printStackTrace();}
		}
		return resultOfInsert;
		
	}

	public ArrayList<FriendsBean> getAllFriends(int jtStartIndex, int jtPageSize,String jtSorting, String filterVal, String filterField) throws ClassNotFoundException,SQLException  {
		ArrayList<FriendsBean> friendList = new ArrayList<FriendsBean>();
		Connection conn = null;
		PreparedStatement ps = null;
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT A.userSipUri,A.friendSipUri,A.friendName FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM FRIENDLISTTABLE C, (SELECT @ROWNUM:=0)R WHERE "+filterField+" LIKE '%"+filterVal+"%' ORDER BY "+jtSorting +") A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) 
			{
				FriendsBean friendsBean= new FriendsBean();
				friendsBean.setUserSipUri(resultSet.getString(1));
				friendsBean.setFreindSipUri(resultSet.getString(2));
				friendsBean.setFriendName(resultSet.getString(3));
				friendList.add(friendsBean);
			}
		return friendList;
	
		
	}
	
	public ArrayList<FriendsBean> getAllFriends(int jtStartIndex, int jtPageSize,String jtSorting) throws ClassNotFoundException,SQLException  {
		ArrayList<FriendsBean> friendList= new ArrayList<FriendsBean>(); 
				Connection conn=null;
		PreparedStatement ps=null;
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = " Select A.userSipUri,A.friendSipUri,A.friendName FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM FRIENDLISTTABLE C, (SELECT @ROWNUM:=0)R ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) 
			{
				FriendsBean friendsBean= new FriendsBean();
				friendsBean.setUserSipUri(resultSet.getString(1));
				friendsBean.setFreindSipUri(resultSet.getString(2));
				friendsBean.setFriendName(resultSet.getString(3));
				friendList.add(friendsBean);
			}
		return friendList;
	
		
	}

	public ArrayList<FriendsBean> getUserFriends(int jtStartIndex, int jtPageSize,String jtSorting,String userId) {
		
		ArrayList<FriendsBean> listOfFriends= new ArrayList<FriendsBean>();
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "Select A.USERSIPURI,A.FRIENDSIPURI,A.FRIENDNAME FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM FRIENDLISTTABLE  C, (SELECT @ROWNUM:=0) R WHERE USERSIPURI='"+userId+"' ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) 
			{
				FriendsBean friendBean= new FriendsBean();
				friendBean.setUserSipUri(resultSet.getString(1));
				friendBean.setFreindSipUri(resultSet.getString(2));
				friendBean.setFriendName(resultSet.getString(3));
				listOfFriends.add(friendBean);
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
		return listOfFriends;
	
	
	}

	public int getNoOfFriends(String userId) throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM FRIENDLISTTABLE WHERE USERSIPURI='"+userId+"'");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}
	
	public boolean deleteFriend(String userId, String friendSipUri,String friendName) {
		boolean flag=false;
		Connection conn=null;
		PreparedStatement ps=null;
	
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String query="DELETE FROM FRIENDLISTTABLE WHERE FRIENDSIPURI='"+friendSipUri+"' OR USERSIPURI='"+userId+"'";
			ps=conn.prepareStatement(query);
			int resultOfDelete = ps.executeUpdate();
			if(resultOfDelete>0){
				flag=true;
				
			}
			else flag=false;
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		return flag;
		
	}

	public boolean addFriend(String userId, String friendSipUri,String friendName) {
		boolean flag=false;
		Connection conn=null;
		PreparedStatement ps=null;
	
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String query="SELECT * FROM REGISTRATIONTABLE WHERE PRIVATEIDENTITY='"+userId+"'";
			ps=conn.prepareStatement(query);
			ResultSet resultSet=ps.executeQuery();
			if(resultSet.next()){
				query="INSERT INTO FRIENDLISTTBALE VALUES('"+userId+"','"+friendSipUri+"','"+friendName+ "')";
				ps=conn.prepareStatement(query);
				int result=ps.executeUpdate();
				if(result>0){
					flag=true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		System.out.println(flag);
		return flag;
	}
}
