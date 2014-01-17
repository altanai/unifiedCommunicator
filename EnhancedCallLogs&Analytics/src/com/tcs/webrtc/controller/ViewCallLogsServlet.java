package com.tcs.webrtc.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import com.tcs.webrtc.bean.CallLogs;
import com.tcs.webrtc.dao.SipCallLogDao;

/**
 * Servlet implementation class ViewCallLogsServlet
 */
@WebServlet("/ViewCallLogsServlet")
public class ViewCallLogsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public ViewCallLogsServlet() {
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
		JSONObject jsonResponse=null;
		String action=request.getRequestURI().split("/")[request.getRequestURI().split("/").length-1];
		if(action.equals("ViewAllLogs"))
		{
			jsonResponse=serviceViewALlLogsRequest(request,response);
		}
		response.setHeader("content-application", "text/json");
		response.getWriter().println(jsonResponse.toString());
	}

	private JSONObject serviceViewALlLogsRequest(HttpServletRequest request,HttpServletResponse response) 
	{
		JSONObject jsonResponse=new JSONObject();
		SipCallLogDao callLogDao=new SipCallLogDao();
		boolean error=false;
		try
		{	
		ArrayList<CallLogs>	listOfLogs=new ArrayList<CallLogs>();	
		int totalRecordCount=-1;
		String filter=request.getParameter("queryFilter");
		String filterBy=request.getParameter("columnName");
		String dateFilter=request.getParameter("dateFilter");
		System.out.println(dateFilter);
		System.out.println(filterBy);
		System.out.println(filter);
		if(filterBy!=null&&(filterBy.equals("DAY"))&&(((dateFilter!=null))&&!(dateFilter.equals(""))))
		{
			listOfLogs=callLogDao.viewAllLogs(Integer.parseInt(request.getParameter("jtStartIndex")),
					Integer.parseInt(request.getParameter("jtPageSize")),
					request.getParameter("jtSorting"),serviceParseAndFormatRequest(dateFilter),
					request.getParameter("columnName"));
			totalRecordCount=callLogDao.getLogCount(serviceParseAndFormatRequest(dateFilter),
					request.getParameter("columnName"));
		}
		else if(filter==null||filter.equals("")||filterBy.equals("-Select-"))
		{
			listOfLogs=callLogDao.viewAllLogs(Integer.parseInt(request.getParameter("jtStartIndex")),
					Integer.parseInt(request.getParameter("jtPageSize")),
					request.getParameter("jtSorting"));
			totalRecordCount=callLogDao.getLogCount();
		}
		else
		{
			listOfLogs=callLogDao.viewAllLogs(Integer.parseInt(request.getParameter("jtStartIndex")),
					Integer.parseInt(request.getParameter("jtPageSize")),
					request.getParameter("jtSorting"),request.getParameter("queryFilter"),
					request.getParameter("columnName"));
			totalRecordCount=callLogDao.getLogCount(request.getParameter("queryFilter"),
					request.getParameter("columnName"));
		}
			jsonResponse.put("Result","OK");
			ArrayList<JSONObject> jsonLogList=new ArrayList<JSONObject>();
			for(CallLogs log:listOfLogs)
			{	
				JSONObject jsonLog=new JSONObject();
				jsonLog.put("CALLER", log.getCaller());
				jsonLog.put("CALLEE", log.getCallee());
				jsonLog.put("DAY", log.getDayOfCall());
				jsonLog.put("STARTTIME", log.getStartTime());
				jsonLog.put("ENDTIME", log.getEndTime());
				jsonLogList.add(jsonLog);
			}
			jsonResponse.accumulate("Records", jsonLogList);
			jsonResponse.put("TotalRecordCount",totalRecordCount);
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
			error=true;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			error=true;
		}
		catch(JSONException e)
		{
			e.printStackTrace();
			error=true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			error=true;
		}
		if(error)
		{
			try 
			{
				jsonResponse=new JSONObject();
				jsonResponse.put("Result", "ERROR");
				jsonResponse.put("Message", "Error occured while fetching records.");				
			}catch (JSONException e){}
		}
		return jsonResponse;
	}
	
	private String serviceParseAndFormatRequest(String unformattedDate) throws ParseException
	{
		DateFormat df=DateFormat.getDateInstance(DateFormat.SHORT);
		Date parsedDate=df.parse(unformattedDate);
		DateFormat df1=DateFormat.getDateInstance(DateFormat.MEDIUM);
		String formattedDate=df1.format(parsedDate);
		System.out.println(formattedDate);
		return formattedDate;
	}

}
