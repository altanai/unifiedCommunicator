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
 * Servlet implementation class ViewServlet
 */

public class ViewServletTogether extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewServletTogether() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String user=request.getParameter("user");
		
		writegeolocation wg=new writegeolocation();
		ArrayList<geolocation> glocationdata= wg.viewgeolocationDetails(user);
		
		request.setAttribute("glocationdata",glocationdata);
		
    	RequestDispatcher view = request.getRequestDispatcher("/geolocationtogether.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
