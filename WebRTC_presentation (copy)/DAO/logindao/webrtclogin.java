package logindao;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import userprofile.beanclass.registration;
import javax.servlet.RequestDispatcher;

import setups.database_server;
import setups.presentation_server;
import userprofile.beanclass.registration;
import logindao.webrtclogin;
import setups.*;

public class webrtclogin {

public ArrayList<registration> login(String username , String password, String realm) {

	String user2;
	String password2;
	Statement st2 = null;
	PreparedStatement pst2 = null;
	ResultSet rs2 = null;
	String sql=null;
	Connection con = null;
	String dbip=null,uname=null,pass=null;
	
	System.out.println(" In DAO class credentials name : "+username+ " pass : "+password+" realm : "+realm );
	
	ArrayList<registration> list = new ArrayList<registration>();
	
	try {

		Class.forName("com.mysql.jdbc.Driver");

		//----------------------------- reading frm db config file 
		database_server ds=new database_server();
		String rdarr[]=new String[3];
		rdarr=ds.read_database_server_file();
		
		dbip=rdarr[0];
		uname=rdarr[1];
		pass=rdarr[2];
		//System.out.println(" frm db file "+ dbip+uname+pass);
		//----------------------------- end db config file 
			
		try {
			con = DriverManager
					.getConnection(
							"jdbc:mysql://"+dbip+"/webrtcdb",
							uname, pass);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("connection " + con);
		try {
			//st2 = conn2.createStatement();
			sql="SELECT a.* FROM webrtcdb.registrationtable a join webrtcdb.siptable b on a.privateIdentity=b.privateIdentity join webrtcdb.login c on c.username=b.username where c.username=? AND c.password=?";
			pst2= con.prepareStatement(sql);
			pst2.setString(1, username);
			pst2.setString(2, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		try {
			rs2 = pst2.executeQuery();

			while (rs2.next()) {

				registration li = new registration();
				li.setDisplayName(rs2.getString(1));
				li.setPublicIdentity(rs2.getString(2));
				li.setPrivateIdentity(rs2.getString(3));
				li.setPassword(rs2.getString(4));
				li.setWSUri(rs2.getString(5));
				li.setRealm(rs2.getString(6));

				list.add(li);
				
				System.out.println("++++++++++++"+li.toString());
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	} catch (ClassNotFoundException e) {
		System.out.println("Couldn't load database driver: " + e.getMessage());
		
	} finally {
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
	 
	webrtclogin wl=new webrtclogin();
	ArrayList<registration> arr = null;
	arr = wl.login("alice", "alice", "tcs.com");
	
	System.out.println(" list "+ arr.size());
System.out.println(" pvt "+arr.get(0).getPrivateIdentity());
System.out.println(" pub "+arr.get(0).getPublicIdentity());
}
	
}
