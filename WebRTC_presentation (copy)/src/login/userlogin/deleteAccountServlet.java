package login.userlogin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import logindao.LoginDao;
import logindao.deleteAccountDao;
import setups.presentation_server;
import userprofile.beanclass.registration;

/**
 * Servlet implementation class deleteAccountServlet
 */

public class deleteAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteAccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		//--------------------------------presentation server
	presentation_server ps=new presentation_server();
	String rdarr[]=new String[1];
	rdarr=ps.read_presentation_server_file();
	String serverip=rdarr[0];
	
	HttpSession session=request.getSession();
	String username=(String) session.getAttribute("privateIdentity");
	System.out.println("username:"+username);

	//--------------------------pr4esentation server		
			registration reg= new registration();
			
			deleteAccountDao dao=new deleteAccountDao();
		if(dao.delete(username)==true)
		{
			System.out.println("deleted successfully");
			response.sendRedirect("pageone/login.jsp");
			
		}
		else
		{
			System.out.println("inside else");
			System.out.println("could not be deleted");
			response.sendRedirect("pageone/home.jsp");
		
			
		}
			
		}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
