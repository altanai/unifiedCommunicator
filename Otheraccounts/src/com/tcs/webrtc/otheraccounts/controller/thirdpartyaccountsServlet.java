package com.tcs.webrtc.otheraccounts.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.webrtc.otheraccounts.bean.thirdpartyaccounts;
import com.tcs.webrtc.otheraccounts.dao.thirdpartyaccountdao;

/**
 * Servlet implementation class thirdpartyaccountsServlet
 */

public class thirdpartyaccountsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public thirdpartyaccountsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("thirdpartyaccountservlet (get ....");

		String googleid=request.getParameter("googleid");
		String facebookid=request.getParameter("facebookid");
		String twitterid=request.getParameter("twitterid");
		String yahooid=request.getParameter("yahooid");
		System.out.println("fjdhgjsdf"+yahooid);
		
	
		
		/*thirdpartyaccounts acc=new thirdpartyaccounts(sipuri,googleid,facebookid,twitterid,yahooid);
		
		thirdpartyaccountdao tpdao=new thirdpartyaccountdao();
		tpdao.addthirdpartyaccountDetails(acc);
		*/

		
		response.sendRedirect(request.getContextPath()+"/../WebRTC_presentation/pageone/addotheraccounts.jsp?googleid="+googleid+"&yahooid="+yahooid+"&facebookid="+facebookid+"&twitterid="+twitterid);
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("thirdpartyaccountservlet (post) ....");

		String sipuri=request.getParameter("sipuri");
		String googleid=request.getParameter("googleid");
		String facebookid=request.getParameter("facebookid");
		String twitterid=request.getParameter("twitterid");
		String yahooid=request.getParameter("yahooid");

		
		
		thirdpartyaccounts acc=new thirdpartyaccounts(sipuri,googleid,facebookid,twitterid,yahooid);
		
		thirdpartyaccountdao tpdao=new thirdpartyaccountdao();
		tpdao.addthirdpartyaccountDetails(acc);
		
	/*	response.sendRedirect(request.getContextPath()+"/../WebRTC_presentation/pageone/serviceprofile.jsp");*/
		
		response.sendRedirect(request.getContextPath()+"/../WebRTC_presentation/pageone/home.jsp");
		
		/*response.sendRedirect(request.getContextPath()+"/../UploadPicsAudioVideo/ViewUserProfile.jsp?"+displayName+""+publicIdentity+""+privateIdentity+""+password+""+realm+""+id);*/
	}

}
