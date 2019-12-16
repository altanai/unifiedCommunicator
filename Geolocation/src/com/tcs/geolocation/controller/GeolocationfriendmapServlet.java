package com.tcs.geolocation.controller;

import java.io.IOException;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import setups.presentation_server;

/**
 * Servlet implementation class GeolocationfriendmapServlet
 */

public class GeolocationfriendmapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GeolocationfriendmapServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("GeolocationfrinedmapServlet (get) ....");
		
		//--------------------------------presentation server
	presentation_server pss=new presentation_server();
	String rdarr[]=new String[1];
	rdarr=pss.read_presentation_server_file();
	String serverip=rdarr[0];
	//--------------------------pr4esentation server
		
	    String name=request.getParameter("friendName");
		String sipuri=request.getParameter("sipuri");
		String latitude=request.getParameter("latitude");
		String longitude=request.getParameter("longitude");
		String date=request.getParameter("date");
		String time=request.getParameter("time");
		System.out.println(" Friend Latitude " + latitude + " Friend longtitude "+ longitude);
		response.sendRedirect("http://"+serverip+":8080/Geolocation/geolocationfriend.jsp?friendlatitude="+latitude+"&friendlongitude="+longitude+"&friendName="+name);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("GeolocationfrinedmapServlet (post) ....");
	}

}
