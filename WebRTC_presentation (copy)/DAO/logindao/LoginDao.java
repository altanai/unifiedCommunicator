package logindao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import setups.database_server;
import userprofile.beanclass.registration;



public class LoginDao 
{

	public boolean register(registration reg) {
		Statement stmt = null;
		PreparedStatement ps = null;
		PreparedStatement ps1 =null;
		PreparedStatement ps2 =null;
		PreparedStatement ps3 =null;
		PreparedStatement ps4 =null;
		Connection con = null;
		String dbip=null,uname=null,pass=null;
		boolean flag=false;
		// ArrayList<String> al= new ArrayList<String>();


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
			/*con = DriverManager
			.getConnection(
					"jdbc:mysql://127.0.0.1:3306/webrtcdb",
					"root", "tcs@1234");*/
			
			String query="Select * from registrationtable where privateIdentity='"+reg.getPrivateIdentity()+"'";
			stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery(query);
			if(rs.next())
			{
				return flag;

			}
			con.setAutoCommit(false);
			
			ps = con.prepareStatement("insert into registrationtable values (?,?,?,?,?,?)");
			ps.setString(1,reg.getDisplayName());
			ps.setString(2, reg.getPublicIdentity());
			ps.setString(3, reg.getPrivateIdentity());
			ps.setString(4, reg.getPassword());
			ps.setString(5, reg.getWSUri());
			ps.setString(6, reg.getRealm());			
			int w = ps.executeUpdate();
			
			ps1=con.prepareStatement("insert into forgotpwd (username,PublicIdentity,PrivateIdentity,Realm,SecretQuestion,SecretAnswer) values (?,?,?,?,?,?)");
			ps1.setString(1,reg.getDisplayName());
			ps1.setString(2, reg.getPublicIdentity());
			ps1.setString(3, reg.getPrivateIdentity());
			ps1.setString(4, reg.getRealm());
			ps1.setString(5, reg.getSecretQuestion());
			ps1.setString(6, reg.getSecretAnswer());
			int x=ps1.executeUpdate();
			
			ps2 = con.prepareStatement("insert into login (username,password,privateIdentity) values (?,?,?)");
			ps2.setString(1,reg.getDisplayName());
			ps2.setString(2, reg.getPassword());
			ps2.setString(3, reg.getPrivateIdentity());
			
			int y = ps2.executeUpdate();
			
			ps3 = con.prepareStatement("insert into siptable (username,privateIdentity) values (?,?)");
			ps3.setString(1,reg.getDisplayName());
			ps3.setString(2, reg.getPrivateIdentity());
			int z = ps3.executeUpdate();
			
			ps4 = con.prepareStatement("insert into presence (sipuri,status) values (?,?)");
			ps4.setString(1,reg.getPrivateIdentity());
			ps4.setString(2,"offline");
			int a = ps4.executeUpdate();
			
			if(w>0&&x>0&&y>0&&z>0&&a>0){
				con.commit();
				flag=true;
				
			}
			else{
				con.rollback();
			}



		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				con.rollback();
				con.setAutoCommit(false);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		try {
			con.setAutoCommit(true);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;

	}

}
