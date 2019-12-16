package com.tcs.webrtc;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProfessionalsController
 */

public class ProfessionalsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfessionalsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String dName = request.getParameter("displayName");
		String sipuri = request.getParameter("name");
		String jobtitle = request.getParameter("jobtitle");
		String project = request.getParameter("project");
		String industry = request.getParameter("industry");
		
		System.out.println("inside post+++"+sipuri);

		interestsDAO details = new interestsDAO();
		int i=details.addToprofessionals(sipuri, jobtitle, project, industry);
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
