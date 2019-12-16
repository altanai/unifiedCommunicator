package sessionmanagement;

import java.io.IOException;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class logoutServlet
 */

public class logoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       	
    public logoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println(" logout servlet  : mtd  get");
		
		 HttpSession session  = request.getSession();
		    try
		    {      
		        session.removeAttribute("logonSessData");
		        request.getSession().invalidate();                               
		       
		        response.setHeader("Cache-Control", "no-cache, no-store"); 
		        response.setHeader("Pragma", "no-cache");
		        response.sendRedirect("/WebRTC_presentation/pageone/login.jsp");  
		    }
		    catch (Exception sqle)
		    {
		        System.out.println("error UserValidateServlet message : " + sqle.getMessage());
		        System.out.println("error UserValidateServlet exception : " + sqle);
		    }
		   
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 
		   
		   
	
	}

}
