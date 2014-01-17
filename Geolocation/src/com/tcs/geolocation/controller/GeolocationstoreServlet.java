package com.tcs.geolocation.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.geolocation.bean.geolocation;
import com.tcs.geolocation.dao.writegeolocation;

/**
 * Servlet implementation class GeolocationstoreServlet
 */

public class GeolocationstoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GeolocationstoreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("GeolocationstoreServlet (get) ....");

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("GeolocationstoreServlet (post) ....");

		String sipuri=request.getParameter("sipuri");
		String latitude=request.getParameter("latitude");
		String longitude=request.getParameter("longitude");
		String date=request.getParameter("date");
		String time=request.getParameter("time");
		System.out.println("-->"+sipuri+" "+latitude+longitude);
		System.out.println("--"+ date + time);
		
		geolocation gdata=new geolocation(sipuri,latitude,longitude,date,time);
		
		writegeolocation wg=new writegeolocation();
		int result= wg.addgeolocationDetails(gdata);
		System.out.println(" Lines inserted  "+ result);
		
		
	}

}
