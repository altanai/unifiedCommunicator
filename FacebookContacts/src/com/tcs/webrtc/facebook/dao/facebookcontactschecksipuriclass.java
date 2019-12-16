package com.tcs.webrtc.facebook.dao;

import java.io.PrintWriter;
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

public class facebookcontactschecksipuriclass {



public String checkexists(String username) {

    String sipuri = null;
	Statement st2 = null;
	PreparedStatement pst2 = null;
	ResultSet rs2 = null;
	String sql=null;
	Connection con = null;
	String dbip=null,uname=null,pass=null;
		
	//ArrayList<registration> list = new ArrayList<registration>();
	
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

			//st2 = conn2.createStatement();
			sql="SELECT sipuri FROM webrtcdb.m_otheraccounts where sipuri LIKE ? OR facebookid LIKE ? OR googleid LIKE ? LIMIT 1 ";
			pst2= con.prepareStatement(sql);
			pst2.setString(1, "%"+username + "%");
			pst2.setString(2, "%"+username + "%");
			pst2.setString(3, "%"+username + "%");
		
			rs2 = pst2.executeQuery();

			while (rs2.next()) {
               sipuri=rs2.getString(1);

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
	return sipuri;
	
}	



public static void main(String args[]) {
	
 facebookcontactschecksipuriclass fblogindao = new facebookcontactschecksipuriclass();
 String sipuri= fblogindao.checkexists("alice");
 System.out.println(" sipuri "+ sipuri);
 
 
 
}
	
}
