package com.tcs.geolocation.controller;

import java.io.IOException;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import setups.presentation_server;

/**
 * Servlet implementation class ViewUserServlet
 */

public class ViewUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("View User Servlet (get) ....");
		
		//--------------------------------presentation server
	presentation_server pss=new presentation_server();
	String rdarr[]=new String[1];
	rdarr=pss.read_presentation_server_file();
	String serverip=rdarr[0];
	//--------------------------pr4esentation server
	
	String user=request.getParameter("user");
	
	   HttpSession session = request.getSession();
	   session.setAttribute( "serverip",serverip);
	   session.setAttribute( "user", user);
	
	response.sendRedirect("http://"+serverip+":8080/Geolocation/geolocation.jsp");

	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
