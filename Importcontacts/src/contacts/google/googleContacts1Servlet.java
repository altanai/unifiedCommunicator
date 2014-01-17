package contacts.google;

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

/**
 * Servlet implementation class googleContacts1Servlet
 */

public class googleContacts1Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	Connection conn2;
	String user2;
	String password2;
	Statement st2 = null;
	ResultSet rs2 = null;
    public googleContacts1Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		Connection conn = null;
		try {

			Class.forName("com.mysql.jdbc.Driver");
			out.println("driver class found");

			user2 = "root";
			password2 = "tcs@1234";
			conn2 = DriverManager
					.getConnection(
							"jdbc:mysql://127.0.0.1:3306/webrtcdb",
							"root", "tcs@1234");

			System.out.println("connection " + conn2);
			st2 = conn2.createStatement();
			rs2 = st2.executeQuery("SELECT * from gmailcontacts");

			ArrayList<googleContacts> list = new ArrayList<googleContacts>();

			while (rs2.next()) {

				googleContacts li = new googleContacts();
				li.setFirstName(rs2.getString(1));
				li.setLastName(rs2.getString(3));
				li.setEmailAddress(rs2.getString(15));
				li.setPriority(rs2.getString(86));
				
				list.add(li);
			}

			request.setAttribute("googleContacts", list);
			RequestDispatcher view = request.getRequestDispatcher("/pageone/googleContactsList.jsp");
			view.forward(request, response);

		} catch (ClassNotFoundException e) {
			out.println("Couldn't load database driver: " + e.getMessage());
		} catch (SQLException e) {
			out.println("SQLException caught: " + e.getMessage());
		} finally {
			// Always close the database connection.
			try {
				if (conn2 != null)
					conn2.close();
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
