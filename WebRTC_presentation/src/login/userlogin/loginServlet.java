package login.userlogin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import phonebook.userfriends;

import contacts.webrtc.loaduserfrnds;

import logindao.LoginDao;
import logindao.webrtclogin;
import userprofile.beanclass.registration;
import setups.*;
/**
 * Servlet implementation class loginservlet
 */

public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginServlet() {
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
	
	String displayName=request.getParameter("displayName");
	String privateIdentity=request.getParameter("privateIdentity");
	//--------------------------pr4esentation server		
			registration reg= new registration();
			reg.setDisplayName(request.getParameter("displayName"));
			reg.setPublicIdentity(request.getParameter("publicIdentity"));
			reg.setPrivateIdentity(request.getParameter("privateIdentity"));
			reg.setPassword(request.getParameter("password"));
			reg.setWSUri(request.getParameter("wsuri"));
			reg.setRealm(request.getParameter("realm"));
			reg.setSecretQuestion(request.getParameter("secretQuestion"));
			reg.setSecretAnswer(request.getParameter("secretAnswer"));
			
			LoginDao dao=new LoginDao();
		if(dao.register(reg)==true)
		{
			System.out.println(displayName+"registered sucessfully");
			//request.getRequestDispatcher("pageone/success.jsp").forward(request, response);
			   response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/addmoredetails.jsp?privateIdentity="+privateIdentity+"&displayName="+displayName);
		}
		else
		{
			System.out.println("displayName could not register ");
		
			//request.getRequestDispatcher("pageone/failure.jsp").forward(request, response);
			   response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/addmoredetails.jsp");
		}
			
		}
		
			

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		PrintWriter out = response.getWriter();
		
		//Call method for reading the IP of presentation server
		//--------------------------------presentation server
	presentation_server ps=new presentation_server();
	String rdarr[]=new String[1];
	rdarr=ps.read_presentation_server_file();
	String serverip=rdarr[0];
	//--------------------------pr4esentation server
		System.out.println("Server IP :"+ serverip);
		
		String realm="tcs.com";		
		String privateIdentity=null;
		String publicIdentity=null;
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		
		System.out.println("Status : loginservlet mtd :post");
		System.out.println(" In login servlet credentials username : "+userName+ " pass : "+password+" realm : "+realm );	
		
		webrtclogin wl = new webrtclogin();
		ArrayList<registration>result=wl.login(userName,password,realm);
		
		if(result.size()!=0)
		{
			System.out.println("login with registrationDetails "+ result.size() );
			
//			request.setAttribute("registrationDetails", result);
//			RequestDispatcher view = request.getRequestDispatcher("loginsession");
//			view.forward(request, response);	
			
			/*
			 * read friends from File 
			 */
			userfriends ff=new userfriends();
			ArrayList<registration> friendlist=ff.fetchallpresenecevalues();
			
			System.out.println("friendlist size "+ friendlist.size());
			String[] getfriends=new String[friendlist.size()];
			
			for(int i=0;i<friendlist.size();i++)
			getfriends[i]=friendlist.get(i).getPrivateIdentity();
				
			/*
			 * load frndlist into temp file
			 */
			//getfriends[0]="sip:bob@tcs.com";
			//getfriends[1]="sip:hunt@tcs.com";
			
			
			loaduserfrnds lf= new loaduserfrnds();
			lf.FriendsWriteToFile(result.get(0).getDisplayName(),getfriends);
			
			response.sendRedirect(
					"loginsession?name="+result.get(0).getDisplayName()+
					"&pvt="+result.get(0).getPrivateIdentity()+
					"&pub="+result.get(0).getPublicIdentity()+
					"&pass="+result.get(0).getPassword()+
					"&realm="+result.get(0).getRealm()+
					"&serverip="+serverip);
		}
		else{

			System.out.println("login failed" );
			response.sendRedirect("pageone/login.jsp");
			
		}

		}
	}

