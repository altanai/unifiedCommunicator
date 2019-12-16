package com.tcs.webrtc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import setups.database_server;

public class interestsDAO {

	static String url = null;
	static String uName = null;
	static String pwd = null;

	public interestsDAO() {

		// ----------------------------- reading frm db config file
		database_server ds = new database_server();
		String rdarr[] = new String[3];
		rdarr = ds.read_database_server_file();
		// ----------------------------- end db config file

		url = "jdbc:mysql://" + rdarr[0] + ":3306/webrtcdb";
		uName = rdarr[1];
		pwd = rdarr[2];
	}

	public int addToUserinfo(String sipuri, String address,
			String city, String state, String country, String contactno,
			String profile) {
		Connection con = null;
		int result=0;

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			con = DriverManager.getConnection(url, uName, pwd);

			PreparedStatement ps = con
					.prepareStatement("INSERT  INTO webrtcdb.user_info  values (?,?,?,?,?,?,?)");
			ps.setString(1, sipuri);
			ps.setString(2, address);
			ps.setString(3, city);
			ps.setString(4, state);
			ps.setString(5, country);
			ps.setString(6, contactno);
			ps.setString(7, profile);
			result=ps.executeUpdate();
		}

		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Sql exception ");
		} finally {

			try {
				if (con != null)
					con.close();
			} catch (SQLException ignored) {
			}
		}
		return result;
	}

	public int addToStudent(String sipuri, String institute,
			String course, String subject) {
		Connection con = null;
	int result=0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(url, uName, pwd);

			PreparedStatement ps = con
					.prepareStatement("INSERT  INTO webrtcdb.studenttable  values (?,?,?,?)");
			ps.setString(1, sipuri);
			ps.setString(2, institute);
			ps.setString(3, course);
			ps.setString(4, subject);
			result=ps.executeUpdate();
		}

		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Sql exception ");
		} finally {

			try {
				if (con != null)
					con.close();
			} catch (SQLException ignored) {
			}
		}
		return result;
	}

	public int addTojobseeker(String sipuri, String qualification,
			String field) {
		Connection con = null;
		int result=0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(url, uName, pwd);

			PreparedStatement ps = con
					.prepareStatement("INSERT  INTO webrtcdb.jobseekertable  values (?,?,?)");
			ps.setString(1, sipuri);
			ps.setString(2, qualification);
			ps.setString(3, field);
			result=ps.executeUpdate();
		}

		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Sql exception ");
		} finally {

			try {
				if (con != null)
					con.close();
			} catch (SQLException ignored) {
			}
		}
		return result;
	}

	public int  addToprofessionals(String sipuri, String jobtitle,
			String project, String industry) {
		Connection con = null;
		int result=0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(url, uName, pwd);

			PreparedStatement ps = con
					.prepareStatement("INSERT  INTO webrtcdb.professionalstable  values (?,?,?,?)");
			ps.setString(1, sipuri);
			ps.setString(2, jobtitle);
			ps.setString(3, project);
			ps.setString(4, industry);
			result=ps.executeUpdate();
		}

		catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Sql exception ");
		} finally {

			try {
				if (con != null)
					con.close();
			} catch (SQLException ignored) {
			}
		}
		return result;
	}
}
