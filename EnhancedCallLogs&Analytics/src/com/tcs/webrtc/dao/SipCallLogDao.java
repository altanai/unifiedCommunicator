package com.tcs.webrtc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import setups.database_server;

import com.tcs.webrtc.bean.AnalyticsBean;
import com.tcs.webrtc.bean.CallLogs;

public class SipCallLogDao {
	
/*	private static String url="jdbc:mysql://localhost:3306/test";
	private static String uName="root";
	private static String pwd="";*/

	String url;
	String uName;
	String pwd;
	
	public SipCallLogDao(){
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		url="jdbc:mysql://"+rdarr[0]+":3306/webrtcdb";
		uName=rdarr[1];
		pwd=rdarr[2];
		
	}
	
	
	public int addCallDetails(CallLogs callLog) 
	{
		int resultOfInsert=0;
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			ps=conn.prepareStatement("INSERT INTO CALLLOGS VALUES (?,?,?,?,?)");
			ps.setString(1,callLog.getCaller());
			ps.setString(2, callLog.getCallee());
			ps.setString(3,callLog.getDayOfCall());
			ps.setString(4,callLog.getStartTime());
			ps.setString(5,callLog.getEndTime());
			resultOfInsert=ps.executeUpdate();
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
		String query="";
		if(filterType.equals("DAY")){
		query="SELECT A.CALLER,A.CALLEE,A.DAY,A.STARTTIME,A.ENDTIME FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM CALLLOGS C, (SELECT @ROWNUM:=0) R  WHERE "+filterType+" ='"+queryFilter+"' ORDER BY "+jtSorting +") A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);}
		else query="SELECT A.CALLER,A.CALLEE,A.DAY,A.STARTTIME,A.ENDTIME FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM CALLLOGS C, (SELECT @ROWNUM:=0) R  WHERE "+filterType+" LIKE '%"+queryFilter+"%' ORDER BY "+jtSorting +") A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
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
	
	public AnalyticsBean populateGraphDataByYear(String sipURI,String yearFilter) {
		AnalyticsBean analyticsBean= new AnalyticsBean();
		int [] incomingCalls=new int[12];
		int [] outgoingCalls= new int[12];
		String [] month={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
		Calendar cal=Calendar.getInstance();
		int year=cal.get(Calendar.YEAR);
		if(yearFilter!=null&&!yearFilter.equals(""))
		{
			year=Integer.parseInt(yearFilter);
		}
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
				if(i==3||i==5||i==8||i==10)
				{
					query="select count(caller) from CALLLOGS where callee='"+sipURI+"' and day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==0||i==2||i==4||i==6||i==7||i==9||i==11)
				{
					query="select count(caller) from CALLLOGS where callee='"+sipURI+"' and day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==1)
				{
					query="select count(caller) from CALLLOGS where callee='"+sipURI+"' and day like '%"+ month[i]+", "+year+"'";
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
					query="select count(callee) from CALLLOGS where caller='"+sipURI+"' and day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==0||i==2||i==4||i==6||i==7||i==9||i==11)
				{
					query="select count(callee) from CALLLOGS where caller='"+sipURI+"' and day like '%"+ month[i]+", "+year+"'";
				}
				else if(i==1)
				{
					query="select count(callee) from CALLLOGS where caller='"+sipURI+"' and day like '%"+ month[i]+", "+year+"'";
				}
					ResultSet rs=stmt.executeQuery(query);
					while(rs.next())
					{
						outgoingCalls[i]=rs.getInt(1);
					}
			}
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
			try 
			{
			conn2.close();
			} catch (SQLException e) {e.printStackTrace();}
		}
		return analyticsBean;
	}
	
	public AnalyticsBean populateGraphByMonth(String sipURI, String monthFilter) {
		String month=monthFilter.substring(0, 3);
		AnalyticsBean analyticsBean= new AnalyticsBean();
		ArrayList<String> monthlyIncomingCalls= new ArrayList<String>();
		ArrayList<String> monthlyOutgoingCalls= new ArrayList<String>();
		ArrayList<String> labels= new ArrayList<String>();
		int i=0;
		Connection conn2=null; 
		Statement stmt=null;
		String query=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn2 = DriverManager.getConnection(url, uName, pwd);
			stmt = conn2.createStatement();
			if(month.equalsIgnoreCase("Jan")||month.equalsIgnoreCase("Mar")||month.equalsIgnoreCase("May")||month.equalsIgnoreCase("Jul")||month.equalsIgnoreCase("Aug")||month.equalsIgnoreCase("Oct")||month.equalsIgnoreCase("Dec")){
				for(i=0;i<31;i++)
				{
					query="select count(caller) from CALLLOGS where callee='"+sipURI+"' and day ='"+i+" "+monthFilter+"'";
					ResultSet rs=stmt.executeQuery(query);
					while(rs.next())
					{
						monthlyIncomingCalls.add(rs.getString(1));
					}
					labels.add(i+" "+month);
				}
				for(i=0;i<31;i++)
				{
					query="select count(caller) from CALLLOGS where caller='"+sipURI+"' and day ='"+i+" "+monthFilter+"'";
					ResultSet rs=stmt.executeQuery(query);
					while(rs.next())
					{
						monthlyOutgoingCalls.add(rs.getString(1));
					}
				}
			}
			else if(month.equalsIgnoreCase("Apr")||month.equalsIgnoreCase("Jun")||month.equalsIgnoreCase("Sep")||month.equalsIgnoreCase("Nov")){
				for(i=0;i<30;i++)
				{
				
					query="select count(caller) from CALLLOGS where callee='"+sipURI+"' and day ='"+i+" "+monthFilter+"'";
						ResultSet rs=stmt.executeQuery(query);
						while(rs.next())
						{
							monthlyIncomingCalls.add(rs.getString(1));
						}
				}
				for(i=0;i<30;i++)
				{
					query="select count(caller) from CALLLOGS where caller='"+sipURI+"' and day ='"+i+" "+monthFilter+"'";
						ResultSet rs=stmt.executeQuery(query);
						while(rs.next())
						{
							monthlyOutgoingCalls.add(rs.getString(1));
						}
						labels.add(i+" "+month);
				}
			}
			else if(month.equalsIgnoreCase("Feb")){
				for(i=0;i<28;i++)
				{
						query="select count(caller) from CALLLOGS where callee='"+sipURI+"' and day ='"+i+" "+monthFilter+"'";
						ResultSet rs=stmt.executeQuery(query);
						while(rs.next())
						{
							monthlyIncomingCalls.add(rs.getString(1));
						}
				}
				for(i=0;i<28;i++)
				{
						query="select count(caller) from CALLLOGS where caller='"+sipURI+"' and day ='"+i+" "+monthFilter+"'";
						ResultSet rs=stmt.executeQuery(query);
						while(rs.next())
						{
							monthlyOutgoingCalls.add(rs.getString(1));
						}
						labels.add(i+" "+month);
				}
			}
		analyticsBean.setMonthlyIncomingCalls(monthlyIncomingCalls);
		analyticsBean.setMonthlyOutgoingCalls(monthlyOutgoingCalls);
		analyticsBean.setLabels(labels);
		}
		catch(SQLException s){
			System.out.println(s.getMessage());
		}
		catch (ClassNotFoundException c) {
			System.out.println(c.getMessage());
		}
		finally
		{
			try 
			{
			conn2.close();
			} catch (SQLException e) {e.printStackTrace();}
		}
		return analyticsBean;
	}


}

