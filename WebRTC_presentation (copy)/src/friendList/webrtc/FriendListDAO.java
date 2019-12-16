package friendList.webrtc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import setups.database_server;

public class FriendListDAO {
	
	
	public static void addFriendToList(String userURI,String sipURI)
	{
		
		
		Statement st2 = null;
		ResultSet rs2 = null;
		Connection con = null;
		String dbip=null,uname=null,pass=null,friendURI = null;
		
		ArrayList<String> list = new ArrayList<String>();
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
			//----------------------------- reading frm db config file 
			database_server ds=new database_server();
			String rdarr[]=new String[3];
			rdarr=ds.read_database_server_file();
			
			dbip=rdarr[0];
			uname=rdarr[1];
			pass=rdarr[2];
		
			//----------------------------- end db config file 
			try{
			con = DriverManager
						.getConnection(
								"jdbc:mysql://"+dbip+"/webrtcdb",uname,pass);
			
				st2 = con.createStatement();
				System.out.println("userName="+userURI+"....friendName="+sipURI);
				/*rs2 = st2.executeQuery("SELECT PrivateIdentity FROM webrtcdb.registrationtable where DisplayName='"+name+"'");
				while (rs2.next()) {
					friendURI=rs2.getNString(1);
					System.out.println("friendURI="+friendURI);
				}
				
			
	          // now store privateIdentity of friend to friendlist in bd
				if(friendURI!=null)
				{*/
				
				rs2 = st2.executeQuery("SELECT DisplayName,PrivateIdentity FROM webrtcdb.registrationtable where privateIdentity='"+sipURI+"'");
				while(rs2.next()){
					/*list.add(rs2.getString(1));*/
					String friendName=rs2.getString(1);
				
				
				
				int count=0;
					rs2 = st2.executeQuery("SELECT friendSipURI FROM webrtcdb.friendlisttable where userSipURI='"+userURI+"'");
					while (rs2.next()) {
						list.add(rs2.getNString(1));
					}
					for(int j=0;j<list.size();j++)
					{
						if(list.get(j).equalsIgnoreCase(sipURI))
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
			String statement="INSERT  INTO webrtcdb.friendlisttable (userSipURI,friendSipURI,friendName) values ('"+userURI+"'"+","+"'"+sipURI+"'"+","+"'"+friendName+"')";
			PreparedStatement pstn=con.prepareStatement(statement);
			int result=pstn.executeUpdate();
			if(result!=0)
			{
				System.out.println("added sucessfully");
			}
				}
			
			}
			}
			
			catch(SQLException e){
				e.printStackTrace();
				System.out.println("Sql exception ");
			}
			finally {
				
					try {
						if (con != null)
							con.close();
					} catch (SQLException ignored) {
					}
			}
		 	
	}
	public static ArrayList<String> getFriendList(String userSipURI)
	{ System.out.println("name.."+userSipURI);
		Statement st2 = null;
		ResultSet rs2 = null;
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		ArrayList<String> list = new ArrayList<String>();
		 try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
			//----------------------------- reading frm db config file 
			database_server ds=new database_server();
			String rdarr[]=new String[3];
			rdarr=ds.read_database_server_file();
			
			dbip=rdarr[0];
			uname=rdarr[1];
			pass=rdarr[2];
		
			//----------------------------- end db config file 
			try{
				con = DriverManager
							.getConnection(
									"jdbc:mysql://"+dbip+"/webrtcdb",uname,pass);
				
					st2 = con.createStatement();
					rs2 = st2.executeQuery("SELECT friendSipURI FROM webrtcdb.friendlisttable where userSipURI='"+userSipURI+"'");
					while (rs2.next()) {
						list.add(rs2.getNString(1));
					}
			}
					catch(SQLException e){
						e.printStackTrace();
						System.out.println("Sql exception ");
					}
					finally {
						
							try {
								if (con != null)
									con.close();
							} catch (SQLException ignored) {
							}
					}
		return list;
		}
	public static ArrayList<String> searchFriendList(String name)
	{
		Statement st2 = null;
		ResultSet rs2 = null;
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		ArrayList<String> list = new ArrayList<String>();
		 try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
			//----------------------------- reading frm db config file 
			database_server ds=new database_server();
			String rdarr[]=new String[3];
			rdarr=ds.read_database_server_file();
			
			dbip=rdarr[0];
			uname=rdarr[1];
			pass=rdarr[2];
		
			//----------------------------- end db config file 
			try{
				con = DriverManager
							.getConnection(
									"jdbc:mysql://"+dbip+"/webrtcdb",uname,pass);
				
					st2 = con.createStatement();
					rs2 = st2.executeQuery("SELECT PrivateIdentity FROM webrtcdb.registrationtable where DisplayName='"+name+"'");
					while (rs2.next()) {
						list.add(rs2.getNString(1));
					}
			}
					catch(SQLException e){
						e.printStackTrace();
						System.out.println("Sql exception ");
					}
					finally {
						
							try {
								if (con != null)
									con.close();
							} catch (SQLException ignored) {
							}
					}
		return list;
		}
	
	
	public static void removeFriendFromList(String sipURI,String userURI){
		System.out.println("uri.to remove..."+sipURI);
		Statement st2 = null;
		ResultSet rs2 = null;
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		//----------------------------- reading frm db config file 
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		dbip=rdarr[0];
		uname=rdarr[1];
		pass=rdarr[2];
	
		//----------------------------- end db config file 
		
		
		try {
			con = DriverManager
					.getConnection(
							"jdbc:mysql://"+dbip+"/webrtcdb",uname,pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		try {
			st2 = con.createStatement();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			int i= st2.executeUpdate("DELETE from webrtcdb.friendlisttable where friendSipURI='"+sipURI+"' and userSipURI='"+userURI+"'");
	        if(i>0)
	        	System.out.println("removed");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
