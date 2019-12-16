package sessionmanagement;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import setups.*;


/**
 * Servlet implementation class start
 */

public class start extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public start() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			//--------------------------------presentation server
		presentation_server ps=new presentation_server();
		String rdarr[]=new String[1];
		rdarr=ps.read_presentation_server_file();
		String serverip=rdarr[0];
		//--------------------------prsentation server
		
		//response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/login.html");
		response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/login.jsp");
		}
		catch(Exception e){
		 System.out.println("start servlet failed ");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	
	
}
