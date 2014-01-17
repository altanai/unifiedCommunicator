package com.tcs.webrtc.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.webrtc.bean.AnalyticsBean;
import com.tcs.webrtc.dao.SipCallLogDao;

/**
 * Servlet implementation class AnalyticsServlet
 */
@WebServlet("/AnalyticsServlet")
public class AnalyticsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnalyticsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String sipURI=request.getParameter("sipUri");
		SipCallLogDao scld=new SipCallLogDao();
		AnalyticsBean analyticsBean=scld.populateGraphDataByYear(sipURI,"");
		request.setAttribute("sipUri", sipURI);
		request.setAttribute("analyticsBean", analyticsBean);
		request.getRequestDispatcher("CallGraph.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Inside post");
		if("MONTH".equalsIgnoreCase(request.getParameter("columnName")))
		{
			System.out.println("Inside month post");
			String sipURI=request.getParameter("sipUri");
			String month=request.getParameter("month");
			SipCallLogDao scld=new SipCallLogDao();
			AnalyticsBean analyticsBean=scld.populateGraphByMonth(sipURI, month);
			request.setAttribute("sipUri", sipURI);
			request.setAttribute("analyticsBean", analyticsBean);
			request.getRequestDispatcher("CallGraphMonth.jsp").forward(request, response);
		}
		else if("YEAR".equalsIgnoreCase(request.getParameter("columnName")))
		{
			System.out.println("Inside year post");
			String sipURI=request.getParameter("sipUri");
			SipCallLogDao scld=new SipCallLogDao();
			AnalyticsBean analyticsBean=scld.populateGraphDataByYear(sipURI,request.getParameter("year").toString());
			request.setAttribute("sipUri", sipURI);
			request.setAttribute("analyticsBean", analyticsBean);
			request.getRequestDispatcher("CallGraph.jsp").forward(request, response);
		}
	}

}
