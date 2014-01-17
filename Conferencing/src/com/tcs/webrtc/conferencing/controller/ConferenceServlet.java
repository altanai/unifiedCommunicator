package com.tcs.webrtc.conferencing.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tcs.webrtc.conferencing.bean.ConferenceDetails;
import com.tcs.webrtc.conferencing.dao.confpermission;

/**
 * Servlet implementation class ConferenceServlet
 */
@WebServlet("/ConferenceServlet")
public class ConferenceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       String room;
       String pass;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConferenceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action=request.getParameter("action");
		System.out.println("action = "+ action);

		if(action.equalsIgnoreCase("joinconf"))
		{
			
			String room="roomone";
			String pass="1234";
			
			/*request.setAttribute("confname", "tcs");*/
				
/*			request.setAttribute("host", "sip:altanai@tcs.com");
			request.setAttribute("membersnumber", "2");
			request.setAttribute("member1", "sip:puru@tcs.com");
			request.setAttribute("member2", "sip:ashu@tcs.com");
			request.setAttribute("pass", "1234");*/
		
			if(pass!=null){
				System.out.println("forwarding to existing cong password entry page ");
				RequestDispatcher view = request.getRequestDispatcher("http://localhost:8080/Conferencing/pageone/enterpassconf.jsp");
				view.forward(request, response);
			}
			else
			{
			System.out.println("formwarding to existing conf page");
			response.sendRedirect("http://localhost:8080/Conferencing/pageone/conf.jsp?room="+room);
	
			//RequestDispatcher view = request.getRequestDispatcher("/pageone/conf.jsp?room="+room);
	    	//view.forward(request, response);
			
			}
		}
		
		else if(action.equalsIgnoreCase("makeconf"))
		{
			request.setAttribute("host", "sip:altanai@tcs.com");
			System.out.println("formwarding to make new conf page");
			response.sendRedirect("http://localhost:8080/Conferencing/pageone/conf.jsp?room=makeroom");

		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String passcode=request.getParameter("passcode");
		HttpSession session=request.getSession();
		System.out.println("passcode = "+ passcode);
		if("addConferenceDetails".equalsIgnoreCase(request.getParameter("action")))
		{
			ConferenceDetails conference=new ConferenceDetails();
			conference.setConferenceName(request.getParameter("conferenceName"));//Please set the values as per requirements
			conference.setConferenceRoom(request.getParameter("conferenceRoom"));
			conference.setDate(request.getParameter("confDate")+" "+request.getParameter("confTime"));
			conference.setPassword(request.getParameter("confPwd"));
			conference.setHost((String)session.getAttribute("privateIdentity"));
			conference.setUserName(request.getParameter("member"));
			conference.setConferenceType(request.getParameter("conferenceType"));
			
			confpermission dao=new confpermission();
			boolean result=dao.addConferenceDetails(conference);
			
			if(result){
				System.out.println("Details added successfully");
			}
			else
				System.out.println("Details could not be added");
		}
		
		
		
	}

}
