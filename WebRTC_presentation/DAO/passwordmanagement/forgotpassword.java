package passwordmanagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import setups.database_server;
import userprofile.beanclass.friend;

public class forgotpassword {
	Connection con;
	String user2;
	String password2;
	Statement st2 = null;
	ResultSet rs2 = null;
	PreparedStatement ps = null;
	PreparedStatement ps1 =null;
	String dbip=null,uname=null,pass=null;
	String loginpassword=null;
	Connection conn2 = null;
	
	public String getpassword(String userName, String secretQuestion, String secretAnswer){
		
		
		
		try {

			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("driver class found");

			//----------------------------- reading frm db config file 
			database_server ds=new database_server();
			String rdarr[]=new String[3];
			rdarr=ds.read_database_server_file();
			
			dbip=rdarr[0];
			uname=rdarr[1];
			pass=rdarr[2];
			//----------------------------- end db config file 
				con = DriverManager
						.getConnection(
								"jdbc:mysql://"+dbip+"/webrtcdb",
								uname, pass);

				st2 = con.createStatement();

				rs2 = st2
						.executeQuery("SELECT a.password FROM webrtcdb.login a join webrtcdb.forgotpwd b on a.username=b.username  where b.SecretQuestion='"+secretQuestion+"' and b.SecretAnswer='"+secretAnswer+"' and b.username='"+userName+"'");

				while (rs2.next()) {
	                  loginpassword=rs2.getString(1).toString();	
				}
				

		} catch (ClassNotFoundException e) {
			System.out.println("Couldn't load database driver: " + e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
         finally {
 			// Always close the database connection.
 			try {  if (con != null)			con.close();   } 
 			catch (SQLException ignored) {			}
 		}
		
		return loginpassword;

}
}
