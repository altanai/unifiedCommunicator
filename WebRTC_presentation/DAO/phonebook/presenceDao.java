package phonebook;

import java.io.PrintWriter;
import userprofile.beanclass.friend;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;

import presence.beanclass.presence;

import setups.*;

public class presenceDao {

	private static final String String = null;

	public ArrayList<presence> readpresencelist(String sipuri){

		String user2;
		String password2;
		Statement st2 = null;
		PreparedStatement pst2 = null;
		ResultSet rs2 = null;
		int result=0;
		String sql=null;
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		
		ArrayList<presence> plist = new ArrayList<presence>();
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
			  sql="Select * from webrtcdb.presence where sipuri=?";
			  pst2.setString(1, sipuri);
			  pst2 = con.prepareStatement(sql);

	         rs2 = pst2.executeQuery();
	         
		         while(rs2.next()){
		        	 presence p= new presence();
		        	 p.setPrivateIdentity(rs2.getString(1));
		        	 p.setPresence(rs2.getString(2));
		        	 plist.add(p);
		         }

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
		 
		return plist;
		
	}	
	
	public String readpresence(String sipuri){

		String user2;
		String password2;
		Statement st2 = null;
		PreparedStatement pst2 = null;
		ResultSet rs2 = null;
		int result=0;
		String sql=null;
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		String status = null;
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
			  sql="Select status from webrtcdb.presence where sipuri=?";
			
			  pst2 = con.prepareStatement(sql);
			  pst2.setString(1, sipuri);
	         rs2 = pst2.executeQuery();
	         
		         while(rs2.next()){
		        	 status = rs2.getString(1);   	
		         }

				}catch(SQLException e){
				System.out.println("Sql exception in presence Dao");
			}
			finally {
				// Always close the database connection.
					try {
						if (con != null)
							con.close();
					} catch (SQLException ignored) {
					}
			}
			 if(status==null) status="notfound";	
			
		 System.out.println(" read presence : sip uri "+ sipuri+" status : "+ status );
		 
		return status;
		
	}	
	
	
public int writepresence(String sipuri, String status){

	 System.out.println(" write presence : sip uri "+ sipuri+" status : "+ status );
	
	String user2;
	String password2;
	Statement st2 = null;
	PreparedStatement pst2 = null;
	ResultSet rs2 = null;
	int result=0;
	String sql=null;
	Connection con = null;
	String dbip=null,uname=null,pass=null;
	
	ArrayList<friend> list = new ArrayList<friend>();
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
		  sql="update webrtcdb.presence set status=? where sipuri=? ";
		  pst2 = con.prepareStatement(sql);
		  pst2.setString(1, status);
		 pst2.setString(2, sipuri);
         result = pst2.executeUpdate();

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
	 
	return result;
	
}	


}