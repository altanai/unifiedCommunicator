package com.tcs.webrtc;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import setups.presentation_server;

/**
 * Servlet implementation class StudentsController
 */

public class StudentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String dName = request.getParameter("displayName");
		String sipuri = request.getParameter("name");
		String institute = request.getParameter("institute");
		String course = request.getParameter("course");
		String subject = request.getParameter("subject");
		
		System.out.println("inside post+++"+sipuri);

		interestsDAO details = new interestsDAO();
		int i=details.addToStudent(sipuri, institute, course, subject);
		 String addResult="";
		if(i>0)
		 {		
			 addResult="User added successfully";
			 System.out.println("The values were added Successfully");
		 }
		 else
		 {
			 addResult="Could not add the user";
		 }
		
		response.sendRedirect("CreateResult.jsp?msg="+addResult);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
