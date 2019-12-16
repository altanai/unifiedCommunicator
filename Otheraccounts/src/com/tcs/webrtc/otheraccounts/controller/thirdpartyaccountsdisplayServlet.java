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
 * Servlet implementation class thirdpartyaccountfetchservlet
 */

public class thirdpartyaccountsdisplayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public thirdpartyaccountsdisplayServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String sipuri=request.getParameter("id");
		System.out.println("thirdpartyaccount  fetch  servlet -get .... for "+ sipuri);	
		
		
		thirdpartyaccountdao tpdao=new thirdpartyaccountdao();
		ArrayList<thirdpartyaccounts> tplist=tpdao.viewthirdpartyaccountDetails(sipuri);
		System.out.println(" third party user account list " + tplist.size()+ " " +tplist  );
//		System.out.println(" tplist  googleid="+tplist.get(0).getGoogleid()+"&yahooid="+tplist.get(0).getYahooid()+"&facebookid="+tplist.get(0).getFacebookid()+"&twitterid="+tplist.get(0).getTwitterid() );
//		response.sendRedirect(request.getContextPath()+"/otheraccounts.jsp?googleid="+tplist.get(0).getGoogleid()+"&yahooid="+tplist.get(0).getYahooid()+"&facebookid="+tplist.get(0).getFacebookid()+"&twitterid="+tplist.get(0).getTwitterid());
		
		if(tplist.size()==0){
			response.sendRedirect(request.getContextPath()+"/otheraccounts.jsp?googleid=none&yahooid=none&facebookid=none&twitterid=none");

		}
		else{
			System.out.println(" tplist  googleid="+tplist.get(0).getGoogleid()+"&yahooid="+tplist.get(0).getYahooid()+"&facebookid="+tplist.get(0).getFacebookid()+"&twitterid="+tplist.get(0).getTwitterid() );
			response.sendRedirect(request.getContextPath()+"/otheraccounts.jsp?googleid="+tplist.get(0).getGoogleid()+"&yahooid="+tplist.get(0).getYahooid()+"&facebookid="+tplist.get(0).getFacebookid()+"&twitterid="+tplist.get(0).getTwitterid());
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
