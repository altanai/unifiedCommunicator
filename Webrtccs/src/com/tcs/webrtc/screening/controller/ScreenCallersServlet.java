package com.tcs.webrtc.screening.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;
import com.tcs.webrtc.screening.bean.ListingBeans;
import com.tcs.webrtc.screening.dao.ScreeningDao;

/**
 * Servlet implementation class ScreenCallersServlet
 */
@WebServlet("/ScreenCallersServlet")
public class ScreenCallersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScreenCallersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
    	System.out.println("Code for autoSuggest");
    	String query=request.getParameter("query");
    	System.out.println(query);
    	ArrayList<String> listOfCallers=new ScreeningDao().getListOfCallers(query);
    	JSONObject jsonResponse=new JSONObject();
    	ArrayList<JSONObject> jsonArray=new ArrayList<JSONObject>();
    	try 
    	{
			jsonResponse.put("query", query);
			for(String str:listOfCallers)
			{
				JSONObject json=new JSONObject();
				json.put("value", str);
				jsonArray.add(json);
			}
			jsonResponse.accumulate("suggestions", jsonArray);
			response.setContentType("text/json");
			response.getWriter().println(jsonResponse.toString());
		}
    	catch (JSONException e) {}


    	
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String user=(String) session.getAttribute("privateIdentity");// Getting the uri of the user logged in.
		String action=request.getParameter("action");
		System.out.println(action + " " + user);
		
		if("loadDNDCollection".equalsIgnoreCase(request.getParameter("action")))
		{
			ScreeningDao screeningDao=new ScreeningDao();
			screeningDao.loadCollection(user);
		}
		
		else if("addBlackUser".equalsIgnoreCase(request.getParameter("action")))
		{
			int result=0;
			String currentUser=user;  // The Name of the user logged in from the Session attributes
			String blockedUser=request.getParameter("sip_uri");
			System.out.println(blockedUser);
			result=new ScreeningDao().addBlackUser(currentUser,blockedUser);
			System.out.println(result);
			if(result==1)
			{
				System.out.println("Values updated successfully");
				response.getWriter().println("added to the BlackList successfully!");
			}
			else if(result==4)
			{
				response.getWriter().println("already exists in the BlackList!");
			}
			else
			{
				System.out.println("Database Error Occurred");
				response.getWriter().println("couldn't be added to the BlackList!");
			}
		}
		else if("addWhiteUser".equalsIgnoreCase(request.getParameter("action")))
		{
			int result=0;
			String currentUser=user; // The Name of the user logged in from the Session attributes
			String blockedUser=request.getParameter("sip_uri");
			System.out.println(blockedUser);
			result=new ScreeningDao().addWhiteUser(currentUser,blockedUser);
			if(result==1)
			{
				System.out.println("Values updated successfully");
				response.getWriter().println("added as a WhiteUser!");
			}
			else if(result==4)
			{
				response.getWriter().println("already exists as a WhiteUser!");
			}
			else
			{
				System.out.println("Database Error Occurred");
				response.getWriter().println("couldn't be added as a WhiteUser!");
			}
		}
		
		else if("setDND".equalsIgnoreCase(request.getParameter("action")))
		{
			ListingBeans lb=new ListingBeans();
			lb.setUser(user);// The Name of the user logged in from the Session attributes
		    lb.setMonStartTime(request.getParameter("start_1"));
		    lb.setMonStopTime(request.getParameter("stop_1"));
		    lb.setTueStartTime(request.getParameter("start_2"));
		    lb.setTueStopTime(request.getParameter("stop_2"));
		    lb.setWedStartTime(request.getParameter("start_4"));
		    lb.setWedStopTime(request.getParameter("stop_4"));
		    lb.setThuStartTime(request.getParameter("start_8"));
		    lb.setThuStopTime(request.getParameter("stop_8"));
		    lb.setFriStartTime(request.getParameter("start_16"));
		    lb.setFriStopTime(request.getParameter("stop_16"));
		    lb.setSatStartTime(request.getParameter("start_32"));
		    lb.setSatStopTime(request.getParameter("stop_32"));
		    lb.setSunStartTime(request.getParameter("start_64"));
		    lb.setSunStopTime(request.getParameter("stop_64"));
		    ScreeningDao ld= new ScreeningDao();
		    try {
				if(ld.addGreyListing(lb,user)){
					response.getWriter().println("DND TIMINGS SAVED SUCCESSFULLY!");}
				else
				{
					response.getWriter().println("DND TIMINGS COULDN'T BE SAVED!");
				}
	
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
	}

}
