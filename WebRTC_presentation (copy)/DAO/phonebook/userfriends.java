package phonebook;

import java.io.PrintWriter;
import userprofile.beanclass.registration;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;

import setups.database_server;
import setups.presentation_server;
import setups.*;

public class userfriends {

	public ArrayList<registration> fetchallpresenecevalues() {

		String user2;
		String password2;
		Statement st2 = null;
		PreparedStatement pst2 = null;
		ResultSet rs2 = null;
		String sql=null;
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		
		ArrayList<registration> list = new ArrayList<registration>();
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
			//System.out.println(" frm db file "+ dbip+uname+pass);
			//----------------------------- end db config file 
			try{
			con = DriverManager
						.getConnection(
								"jdbc:mysql://"+dbip+"/webrtcdb",uname,pass);
				pst2 = con.prepareStatement("SELECT * from presence");
				rs2 = pst2.executeQuery();			
				while (rs2.next()) {
					registration li = new registration();
					li.setPrivateIdentity(rs2.getNString(1));
					list.add(li);
				}
			System.out.println("login.userlogin : User friends ->All values fetched from database : "+ list.size());
				
			}catch(SQLException e){
				System.out.println("Sql exception in registration Dao");
			}
			finally {
				// Always close the database connection.
					try {
						if (con != null)
							con.close();
					} catch (SQLException ignored) {
					}
			}
		 
		return list;
		
	}
	
public ArrayList<registration> fetchuserfriends(String sipuri) {

	String user2;
	String password2;
	Statement st2 = null;
	PreparedStatement pst2 = null;
	ResultSet rs2 = null;
	String sql=null;
	Connection con = null;
	String dbip=null,uname=null,pass=null;
	
	ArrayList<registration> list = new ArrayList<registration>();
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
		//System.out.println(" frm db file "+ dbip+uname+pass);
		//----------------------------- end db config file 
		try{
		con = DriverManager
					.getConnection(
							"jdbc:mysql://"+dbip+"/webrtcdb",uname,pass);
			pst2 = con.prepareStatement("SELECT friendSipURI FROM webrtcdb.friendlisttable where userSipURI=?");
			pst2.setString(1,sipuri);
			rs2 = pst2.executeQuery();			
			while (rs2.next()) {
				registration li = new registration();
				li.setPrivateIdentity(rs2.getNString(1));
				list.add(li);
			}
		System.out.println(" Frindlist fetched from database : "+ list.size());
			
		}catch(SQLException e){
			System.out.println("Sql exception in registration Dao");
		}
		finally {
			// Always close the database connection.
				try {
					if (con != null)
						con.close();
				} catch (SQLException ignored) {
				}
		}
	 
	return list;
	
}	

public static void main(String args[]) {
	 
	userfriends usf=new userfriends();
	ArrayList<registration> friendlist=usf.fetchuserfriends("sip:aaa@10.1.5.30:6060");
	for(int i=0;i<friendlist.size();i++)
		System.out.println(friendlist.get(i).getPrivateIdentity());
	
}
	
}
