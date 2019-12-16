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

import passwordmanagement.forgotpassword;

import setups.database_server;

/**
 * Servlet implementation class forgotPasswordServlet
 */

public class forgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
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

		forgotpassword fp=new forgotpassword();
		String loginpassword=fp.getpassword( userName,secretQuestion,secretAnswer);
		response.sendRedirect("pageone/viewPassword.jsp?pass="+loginpassword);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
