package logindao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import setups.database_server;

public class deleteAccountDao {
	
		public boolean delete(String username) {
			Statement stmt = null;
			PreparedStatement ps = null;
			PreparedStatement ps1 =null;
			PreparedStatement ps2 =null;
			PreparedStatement ps3 =null;
			PreparedStatement ps4 =null;
			PreparedStatement ps5 =null;
			PreparedStatement ps6 =null;
			Connection con = null;
			String dbip=null,uname=null,pass=null;
			boolean flag=false;
			
			System.out.println("userbname+++++"+username);
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
				/*
				String query="Select * from registrationtable where privateIdentity='"+username+"'";
				stmt=con.createStatement();
				ResultSet rs=stmt.executeQuery(query);
				if(rs.next())
				{
					return flag;

				}*/
			con.setAutoCommit(false);
				
				ps = con.prepareStatement("delete from registrationtable where privateIdentity='"+username+"'");
						
				int w = ps.executeUpdate();
				
				
				ps1=con.prepareStatement("delete from forgotpwd where PrivateIdentity='"+username+"'");

				int x=ps1.executeUpdate();
			
				ps2 = con.prepareStatement("delete from login where privateIdentity='"+username+"'");

				int y = ps2.executeUpdate();
			
				
				ps3 = con.prepareStatement("delete from siptable where privateIdentity='"+username+"'");
			
				int z = ps3.executeUpdate();
				
				
				ps4 = con.prepareStatement("delete from presence where sipuri='"+username+"'");
			
				int a = ps4.executeUpdate();
				
			
				
                ps6 = con.prepareStatement("delete from userprofile where username='"+username+"'");
				
				int c = ps6.executeUpdate();
				
				
				if((w>0&&x>0&&y>0&&z>0&&a>0)&&(c>0||c<=0)){
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

