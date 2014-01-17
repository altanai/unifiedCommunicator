package login.userlogin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import setups.database_server;

/**
 * Servlet implementation class forgotPasswordServlet
 */

public class forgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	String user2;
	String password2;
	Statement st2 = null;
	ResultSet rs2 = null;
	PreparedStatement ps = null;
	PreparedStatement ps1 =null;
	String dbip=null,uname=null,pass=null;
	
String loginpassword=null;
	
    public forgotPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	/*	PrintWriter out = response.getWriter();*/
		String userName = request.getParameter("userName");
		String secretQuestion=request.getParameter("secretQuestion");
		String secretAnswer=request.getParameter("secretAnswer");

		Connection conn2 = null;
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
				


			try {
				con = DriverManager
						.getConnection(
								"jdbc:mysql://"+dbip+"/webrtcdb",
								uname, pass);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			System.out.println("connection " + con);
			try {
				st2 = con.createStatement();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				rs2 = st2
						.executeQuery("SELECT a.password FROM webrtcdb.login a join webrtcdb.forgotpwd b on a.username=b.username  where b.SecretQuestion='"+secretQuestion+"' and b.SecretAnswer='"+secretAnswer+"' and b.username='"+userName+"'");

				while (rs2.next()) {
                      loginpassword=rs2.getString(1).toString();	
				}
					response.sendRedirect("pageone/viewPassword.jsp?pass="+loginpassword);
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
