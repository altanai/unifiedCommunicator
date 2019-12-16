package com.tcs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import setups.database_server;

public class GoogleContacts {

	/**
	 * @param args
	 */

	String url;
	String uName;
	String pwd;

	public GoogleContacts() {
		database_server ds = new database_server();
		String rdarr[] = new String[3];
		rdarr = ds.read_database_server_file();

		url = "jdbc:mysql://" + rdarr[0] + ":3306/webrtcdb";
		uName = rdarr[1];
		pwd = rdarr[2];

	}

	public ArrayList<String> findContactId(String mailId,String privateIdentity) {

		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<String> list = new ArrayList<String>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			ps = conn
					.prepareStatement("select sipuri from webrtcdb.m_otheraccounts where googleid=? and sipuri not in (?)");
			ps.setString(1, mailId);
			ps.setString(2, privateIdentity);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString(1));
				
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
		
	}	
		
		public String addToFriendList(String privateIdentity,String sipuri,String name) {

			Connection conn = null;
			PreparedStatement ps = null;
			PreparedStatement ps2 = null;
			
			ArrayList<String> list = new ArrayList<String>();
			try {
				try {
					Class.forName("com.mysql.jdbc.Driver");
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				conn = DriverManager.getConnection(url, uName, pwd);
				
				int count=0;
				ps2=conn.prepareStatement("SELECT friendSipURI FROM webrtcdb.friendlisttable where friendSipURI=? and userSIpURI=?");
				ps2.setString(1, sipuri);
				ps2.setString(2, privateIdentity);
				ResultSet rs2=ps2.executeQuery();
								
				while (rs2.next()) {
					list.add(rs2.getString(1));
				}
				for(int j=0;j<list.size();j++)
				{
					if(list.get(j).equalsIgnoreCase(sipuri))
					{
						System.out.println("friend URI is added from before");
						break;
					}
					else
					{
						count++;
					}
				}
		if(count==list.size())	
		{
		String statement="INSERT  INTO webrtcdb.friendlisttable (userSipURI,friendSipURI,friendName) values ('"+privateIdentity+"'"+","+"'"+sipuri+"'"+","+"'"+name+"')";
		PreparedStatement pstn=conn.prepareStatement(statement);
		int result=pstn.executeUpdate();
		if(result!=0)
		{
			System.out.println("added sucessfully");
		}
			}	
		
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return sipuri;		
		}
}