package com.tcs.webrtc.notification.dao;

import java.sql.*;
import java.util.ArrayList;

import com.tcs.webrtc.notification.bean.Notification;

public class NotificationDao {

	private static String url="jdbc:mysql://10.1.5.6:3306/webrtcdb";
	private static String uName="altanai";
	private static String pwd="altanai";

	public ArrayList<Notification> getNotificationData(String userId)
	{
		Connection conn=null;
		PreparedStatement ps=null;
		ArrayList<Notification> newNotifications=new ArrayList<Notification>();
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String Query="SELECT * FROM NOTIFICATION WHERE RECEIVER='"+userId+"' AND STATUS='NEW'";
			ps=conn.prepareStatement(Query);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				Notification notification=new Notification(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
				newNotifications.add(notification);
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
		return newNotifications;
	}

	public boolean updateNotificationStatus(String userId) {

		Connection conn=null;
		PreparedStatement ps=null;
		boolean flag=false;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			String Query="update notification set status='OLD' where id='"+userId+"'";
			ps=conn.prepareStatement(Query);
			if(ps.executeUpdate()>0){
				flag=true;
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
}