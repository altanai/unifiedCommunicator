package friendList.webrtc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class FriendListController
 */

public class FriendListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public FriendListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action=request.getParameter("action");
		//could be either removefriend or findFriendURI
		
		HttpSession session=request.getSession();
		String username=(String) session.getAttribute("privateIdentity");
		/*String username=request.getParameter("name");*/
		System.out.println("user sipuri  :"+ username);
		
		if(action.equalsIgnoreCase("removefriend"))
		{
			System.out.println("----> Remove frind section of FrindList controller ");
			String friendUri=request.getParameter("friendName");
			System.out.println("friendUri++"+friendUri);
			

			
			FriendListDAO.removeFriendFromList(friendUri,username);
				
		 //  response.sendRedirect("phonebookLineServlet");
		}
		
		else if (action.equalsIgnoreCase("findFriendURI"))
		{
			System.out.println("----> Find and Add frind section of FrindList controller ");
			
			String sipURI=request.getParameter("friendName");
			System.out.println("sipuri of friend  :"+ sipURI);
			
			/*String str=sipURI;
			str= str.substring(str.lastIndexOf("sip:")+4, str.lastIndexOf("@tcs.com"));
			System.out.println(" name of frnd  :"+str);*/
			
			if(request.getParameter("action").equalsIgnoreCase("findFriendURI"))
			{			
				System.out.println("..."+sipURI);
				FriendListDAO.addFriendToList(username, sipURI);				
			}
			
		}
		
		else {
			System.out.println(" something has hit friend servlet without add or delete ");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("action.."+request.getParameter("action"));
		String action=request.getParameter("action");
		//System.out.println("action..."+action);
		System.out.println("----> POST FrindList controller ");
		
		
	}

}



