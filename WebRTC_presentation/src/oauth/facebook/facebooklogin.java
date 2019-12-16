package oauth.facebook;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import phonebook.facebookchecksipuri;
import phonebook.userfriends;
import contacts.webrtc.loaduserfrnds;

import setups.presentation_server;
import userprofile.beanclass.registration;

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
				   
        String username=request.getParameter("userName");
        
		
		username=username.toLowerCase();
		String[] array = username.split(" ");
		String user_firstname=array[0];
		String user_lastname=array[0];
				
		//System.out.println(" fb friend name "+ fbfriendname);
		
		facebookchecksipuri fbcheck =new facebookchecksipuri();
		
		String check =null;
		check=fbcheck.checkexists(user_firstname);
		System.out.println(" user "+ username + " on facebook -->  "+ check);
		
		

		System.out.println("Oauth facebook "+username+" trying to log in");
		 
		facebooklogindao fbdao=new facebooklogindao();
		String sipuri=fbdao.checkexists(check);
		
		/*
		   name=request.getParameter("userName");
		   privateIdentity="sip:"+name+"@"+releam;
		   
		   HttpSession session = request.getSession();
		   session.setAttribute( "name", name );
		   session.setAttribute( "privateIdentity",privateIdentity );
		   session.setAttribute( "releam",releam);*/

	//System.out.println("Forwarding to :"+ "http://"+serverip+":8080/WebRTC_presentation/loginsession?serverip="+serverip+":8080&name="+name+"&privateIdentity="+privateIdentity+"&releam="+releam);
	 //  response.sendRedirect("http://"+server_ip+":8080/WebRTC_presentation/pageone/home.jsp");
	//response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/loginsession?serverip="+serverip+":8080&name="+name+"&privateIdentity="+privateIdentity+"&releam="+releam);
	
		ArrayList<registration>result=fbdao.login(sipuri);
		 if ( result.size()!=0){
			 
			 
				/*
				 * read friends from File 
				 */
				userfriends ff=new userfriends();
				ArrayList<registration> friendlist=ff.fetchallpresenecevalues();
				
				System.out.println("friendlist size "+ friendlist.size());
				String[] getfriends=new String[friendlist.size()];
				
				for(int i=0;i<friendlist.size();i++)
				getfriends[i]=friendlist.get(i).getPrivateIdentity();	
				
				loaduserfrnds lf= new loaduserfrnds();
				lf.FriendsWriteToFile(result.get(0).getDisplayName(),getfriends);
				
				/*
				 * redirect control to login session page 
				 */		
				System.out.println("------------------->login sucess , redirecting to login session" );
		    response.sendRedirect(
				"loginsession?name="+result.get(0).getDisplayName()+
				"&pvt="+result.get(0).getPrivateIdentity()+
				"&pub="+result.get(0).getPublicIdentity()+
				"&pass="+result.get(0).getPassword()+
				"&realm="+result.get(0).getRealm()+
				"&serverip="+serverip);
		 }
		 else{
				System.out.println("------------------->login failed" );
				response.sendRedirect("pageone/login.jsp");
		 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
