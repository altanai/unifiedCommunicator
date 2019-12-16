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
		
		/*
		 * Writing server files in sipml5 folder and pageone folder
		 */
		makeserverfiles msf=new makeserverfiles();
		msf.WriteServeripFile();
		
		
		ArrayList<registration> list = new ArrayList<registration>();
		list = (ArrayList) request.getAttribute("registrationDetails");
		
		/*
		 * get values from login servlet page 
		 */
		String serverip=request.getParameter("serverip");		
		String name=request.getParameter("name");
		String privateIdentity= request.getParameter("pvt");
		String publicIdentity=request.getParameter("pub");
		String password=request.getParameter("pass");
		String realm = request.getParameter("realm");
		
        /*		
		 * print logged in users values 
		 */
		/*
		System.out.println("name "+ name );
		System.out.println("privateIdentity "+privateIdentity);
		System.out.println("publicIdentity "+publicIdentity);
		System.out.println("password "+password);
		System.out.println("releam "+realm);*/
		
		/* 
		 * set session attributes 
		 */
		   HttpSession session = request.getSession();
        /* session.setAttribute( "serverip", request.getParameter("serverip") );
		   session.setAttribute( "name", request.getParameter("name") );
		   session.setAttribute( "privateIdentity",request.getParameter("privateIdentity") );
		   session.setAttribute( "publicIdentity",request.getParameter("publicIdentity") );
		   session.setAttribute( "releam",request.getParameter("releam"));*/
		   session.setAttribute( "serverip", serverip );
		   session.setAttribute( "name", name );
		   session.setAttribute( "privateIdentity",privateIdentity );
		   session.setAttribute( "publicIdentity",publicIdentity );
		   session.setAttribute( "password",password );
		   session.setAttribute( "realm",realm);
		  

		   		
			 /*
			  *  print logged in users values 
			  */
			System.out.println("----------------------values------------------"); 
			System.out.println("| name "+session.getAttribute("name")  );
			System.out.println("| privateIdentity "+session.getAttribute("privateIdentity"));
			System.out.println("| publicIdentity "+session.getAttribute("publicIdentity"));
			System.out.println("| password "+session.getAttribute("password"));
			System.out.println("| realm "+session.getAttribute("realm"));
			System.out.println("----------------------------------------------"); 
		   
			System.out.println(" Redirecting to home page ");
		   response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/home.jsp");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
