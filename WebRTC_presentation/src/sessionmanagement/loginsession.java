package sessionmanagement;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userprofile.beanclass.registration;

/**
 * Servlet implementation class loginsession
 */

public class loginsession extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public loginsession() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println(" loginsession : mtd  get");
		
		makeserverfiles msf=new makeserverfiles();
		msf.WriteServeripFile();
		
		
		ArrayList<registration> list = new ArrayList<registration>();
		list = (ArrayList) request.getAttribute("registrationDetails");
		
		String serverip=request.getParameter("serverip");		
		
		String name=request.getParameter("name");
		String privateIdentity= request.getParameter("pvt");
		String publicIdentity=request.getParameter("pub");
		String password=request.getParameter("pass");
		String releam = request.getParameter("realm");
		
		   HttpSession session = request.getSession();
		   session.setAttribute( "serverip", request.getParameter("serverip") );
		   session.setAttribute( "name", request.getParameter("name") );
		   session.setAttribute( "privateIdentity",request.getParameter("privateIdentity") );
		   session.setAttribute( "releam",request.getParameter("releam"));
		   session.setAttribute( "serverip",request.getParameter("serverip"));
		   
		   response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/home.jsp");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
