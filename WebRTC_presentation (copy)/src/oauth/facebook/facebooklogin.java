package oauth.facebook;

import java.io.IOException;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import setups.presentation_server;

/**
 * Servlet implementation class facebooklogin
 */

public class facebooklogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public facebooklogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String releam="tcs.com";
		String name=null;
		
		String privateIdentity=null;
		String publicIdentity=null;

		
		System.out.println("Status : facebookloginservlet mtd :get");
		
		//Call method for reading the IP of presentation server
		//--------------------------------presentation server
	presentation_server ps=new presentation_server();
	String rdarr[]=new String[1];
	rdarr=ps.read_presentation_server_file();
	String serverip=rdarr[0];
	//--------------------------pr4esentation server
		System.out.println("Server IP :"+ serverip);
				   
		/*  response.sendRedirect("nextPage.jsp");*/
				/*   End session*/
		System.out.println(" credentials :"+request.getParameter("userName"));
		
	if( request.getParameter("userName").equalsIgnoreCase("Altanai Bisht"))
	{
		 System.out.println(request.getParameter("name")+" trying to log in");
		 
		   name=request.getParameter("userName");
		   privateIdentity="sip:"+name+"@"+releam;
		   
		   HttpSession session = request.getSession();
		   session.setAttribute( "name", name );
		   session.setAttribute( "privateIdentity",privateIdentity );
		   session.setAttribute( "releam",releam);
	}
	else{
		
		System.out.println("Oauth facebook "+request.getParameter("name")+" trying to log in");
		 
		   name=request.getParameter("userName");
		   privateIdentity="sip:"+name+"@"+releam;
		   
		   HttpSession session = request.getSession();
		   session.setAttribute( "name", name );
		   session.setAttribute( "privateIdentity",privateIdentity );
		   session.setAttribute( "releam",releam);
	}
	System.out.println("Forwarding to :"+ "http://"+serverip+":8080/WebRTC_presentation/loginsession?serverip="+serverip+":8080&name="+name+"&privateIdentity="+privateIdentity+"&releam="+releam);
	 //  response.sendRedirect("http://"+server_ip+":8080/WebRTC_presentation/pageone/home.jsp");
	response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/loginsession?serverip="+serverip+":8080&name="+name+"&privateIdentity="+privateIdentity+"&releam="+releam);
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
