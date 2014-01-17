package com.tcs.webrtc.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.webrtc.bean.CallLogs;
import com.tcs.webrtc.dao.SipCallLogDao;

/**
 * Servlet implementation class SipCallLogServlet
 */
@WebServlet("/SipCallLogServlet")
public class SipCallLogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public SipCallLogServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("Sip Call Log Servlet : updating calllogs ");
		CallLogs callLog=new CallLogs();
		String day=formatDate(request.getParameter("startTime"));
		String startTime=formatTime(request.getParameter("startTime"));
		String endTime=formatTime(request.getParameter("endTime"));
		callLog.setCaller(request.getParameter("caller"));
		callLog.setCallee(request.getParameter("callee"));
		callLog.setDayOfCall(day);
		callLog.setStartTime(startTime);
		callLog.setEndTime(endTime);
		int result=new SipCallLogDao().addCallDetails(callLog);
		if(result>0)
		{
			response.setContentType("text/html");
			//response.getWriter().println("Action Completed Successfully!");
		}
		else
		{
			response.setContentType("text/html");
			//response.getWriter().println("Action Could not be completed Successfully!");
			
		}
	}
	
	private String formatDate(String milliseconds)
	{
		Long millisecs=Long.parseLong(milliseconds);// Parsing the String milliseconds to Long variable
		Date myDate=new Date(millisecs); //Creating a new Date Object using the milliseconds
		DateFormat df=DateFormat.getDateInstance(DateFormat.MEDIUM);
		String formattedDate=df.format(myDate);//FORMATTING THE DATE TO THE APPROPRIATE FORMAT
		return formattedDate;            
	}
	private String formatTime(String milliseconds)
	{
		Long millisecs=Long.parseLong(milliseconds);// Parsing the String milliseconds to Long variable
		Date myTime=new Date(millisecs); //Creating a new Date Object using the milliseconds
		DateFormat df=DateFormat.getTimeInstance();
		String formattedTime=df.format(myTime);//FORMATTING THE TIME TO THE APPROPRIATE FORMAT
		return formattedTime;            
	}

}
