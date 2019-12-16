package com.tcs;

import java.io.IOException;
import java.util.ArrayList;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class GoogleFriendsServlet
 */

public class GoogleFriendsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GoogleFriendsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	 HttpSession session = request.getSession();
     String gmailId=request.getParameter("id");
     String privateIdentity=(String) session.getAttribute("privateIdentity");

      GoogleContacts google=new GoogleContacts();
      ArrayList<String> sipuri=google.findContactId(gmailId,privateIdentity);
      for( int i=0;i<sipuri.size();i++)
			System. out.println(sipuri.get(i).toString());

      request.setAttribute("webrtcDetails", sipuri);
		request.getRequestDispatcher("WebrtcContacts.jsp").forward(request,
				response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		 HttpSession session = request.getSession();
       String privateIdentity=(String) session.getAttribute("privateIdentity");
       String name=(String) session.getAttribute("name");
          String sipuri=request.getParameter("sipuri");

          String delims = "[@]";
          String token[] = sipuri.split(delims);

          String delimsNew="[:]";
          String tokenNew[]=token[0].split(delimsNew);
                  
          GoogleContacts google=new GoogleContacts(); 
          
          google.addToFriendList(privateIdentity,sipuri,tokenNew[1]);
          
          response.sendRedirect("NewGoogleContactsController");

		
	}

}
