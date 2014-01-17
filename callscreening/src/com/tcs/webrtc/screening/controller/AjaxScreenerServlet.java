package com.tcs.webrtc.screening.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tcs.webrtc.screening.bean.ScreenedUserBean;
import com.tcs.webrtc.screening.utility.Utility;

/**
 * Servlet implementation class AjaxScreenerServlet
 */
@WebServlet("/AjaxScreenerServlet")
public class AjaxScreenerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxScreenerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action=request.getParameter("action");
		System.out.println(action);
		String callerUri=request.getParameter("callerUri");
		System.out.println(callerUri);
		if(action.equalsIgnoreCase("chkWhiteUsers"))
		{
			boolean userIsWhite=false;
			if(ScreenedUserBean.getWhiteUsers().contains(callerUri))
			{
				userIsWhite=true;
			}
			System.out.println("User is white ?" + userIsWhite);
			response.setContentType("text/html");
			response.getWriter().println(userIsWhite);
		}
		else if(action.equalsIgnoreCase("chkBlackUsers"))
		{
			boolean userIsBlack=false;
			if(ScreenedUserBean.getBlackUsers().contains(callerUri))
			{
				userIsBlack=true;
			}
			System.out.println("User is black ?"+ userIsBlack);
			response.setContentType("text/html");
			response.getWriter().println(userIsBlack);
			
		}
		else if(action.equalsIgnoreCase("chkDndValues"))
		{
			boolean userIsGrey=false;
			Map<String,String> greyUser=ScreenedUserBean.getGreyUsers();
			Calendar calendar=Calendar.getInstance();
			int dayOfCall=calendar.get(Calendar.DAY_OF_WEEK);
			dayOfCall=dayOfCall-1;
			String [][] month={{"Sun_Strt","Sun_End"},{"Mon_Strt","Mon_End"},{"Tue_Strt","Tue_End"},{"Wed_Strt","Wed_End"},{"Thu_Strt","Thu_End"},{"Fri_Strt","Fri_End"},{"Sat_Strt","Sat_End"}};
			Utility obj=new Utility();
			Calendar startTime=Calendar.getInstance();
			Calendar endTime=Calendar.getInstance();
			Calendar currentTime=Calendar.getInstance();
			startTime.setTime(obj.concatenatedTime(greyUser.get(month[dayOfCall][0])));
			endTime.setTime(obj.concatenatedTime(greyUser.get(month[dayOfCall][1])));
			if((currentTime.after(startTime))&&(currentTime.before(endTime)))
			{
				userIsGrey=true;
			}
			System.out.println("DND Active ?=" + userIsGrey);
			response.setContentType("text/html");
			response.getWriter().println(userIsGrey);
			
		}
	}

}
