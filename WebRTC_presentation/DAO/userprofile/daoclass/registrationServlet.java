package userprofile.daoclass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
import userprofile.beanclass.registration;

/**
 * Servlet implementation class registrationServlet
 */

public class registrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	Connection con;
	String user2;
	String password2;
	Statement st2 = null;
	ResultSet rs2 = null;

	public registrationServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		try {

			Class.forName("com.mysql.jdbc.Driver");
			String dbip=null,uname=null,pass=null;

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
			
			System.out.println("connection " + con);
			st2 = con.createStatement();
			rs2 = st2.executeQuery("SELECT * from registrationtable");

			ArrayList<registration> list = new ArrayList<registration>();

			while (rs2.next()) {

				registration li = new registration();
				li.setDisplayName(rs2.getString(1));
				li.setPublicIdentity(rs2.getNString(2));
				li.setPrivateIdentity(rs2.getNString(3));
				li.setPassword(rs2.getNString(4));
				li.setWSUri(rs2.getNString(5));
				li.setRealm(rs2.getString(6));

				list.add(li);
			}

			request.setAttribute("registrationDetails", list);
			RequestDispatcher view = request.getRequestDispatcher("/pageone/registration.jsp");
			
			view.forward(request, response);
		
		} catch (ClassNotFoundException e) {
			out.println("Couldn't load database driver: " + e.getMessage());
		} catch (SQLException e) {
			out.println("SQLException caught: " + e.getMessage());
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
