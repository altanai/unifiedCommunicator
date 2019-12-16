package com.tcs.webrtc.adminpanel.controller;

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
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.tcs.webrtc.adminpanel.bean.AdminBean;
import com.tcs.webrtc.adminpanel.bean.FriendsBean;
import com.tcs.webrtc.adminpanel.bean.UserBean;
import com.tcs.webrtc.adminpanel.dao.AdminDao;
import com.tcs.webrtc.adminpanel.bean.CallLogs;
import com.tcs.webrtc.adminpanel.bean.AnalyticsBean;


/**
 * Servlet implementation class AdminPanelServlet
 */
@WebServlet("/AdminPanelServlet")
public class AdminPanelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPanelServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		if("viewAllUsers".equalsIgnoreCase(request.getParameter("action")))
		{
			JSONObject jsonResponse=null;
			jsonResponse=serviceViewALlUsersRequest(request,response);
			response.setHeader("content-application", "text/json");
			response.getWriter().println(jsonResponse.toString());
		}
		else if("ViewUserDetail".equalsIgnoreCase(request.getParameter("action")))
		{
			AdminDao adminDAO = new AdminDao();
			UserBean userBean = new UserBean();
			userBean = adminDAO.getUserDetails(request.getParameter("value"));
			request.setAttribute("userBean", userBean);
			request.getRequestDispatcher("ViewUserProfile.jsp").forward(request, response);
		}
		else if("viewPaticularUser".equalsIgnoreCase(request.getParameter("action")))
		{
			AdminDao adminDAO = new AdminDao();
			UserBean userBean = new UserBean();
			HttpSession session=request.getSession(false);
			userBean = adminDAO.getPaticularUserDetails(request.getParameter("searchField"),request.getParameter("searchVal"));
			session.setAttribute("uId",userBean.getPrivateIdentity());
			JSONObject jsonResponse=null;
			try 
			{
				jsonResponse=new JSONObject();
				jsonResponse.put("DISPLAYNAME",userBean.getDisplayName());
				jsonResponse.put("PUBLICIDENTITY",userBean.getPublicIdentity());
				jsonResponse.put("PRIVATEIDENTITY",userBean.getPrivateIdentity());
				jsonResponse.put("WSURI",userBean.getPrivateIdentity());
				jsonResponse.put("REALM",userBean.getRealm());
			} 
			catch (JSONException e) {e.printStackTrace();}
			response.setContentType("text/json");
			response.getWriter().println(jsonResponse.toString());
		}
		else if("editUserDetail".equalsIgnoreCase(request.getParameter("action")))
		{
			AdminDao adminDAO = new AdminDao();
			UserBean userBean = new UserBean();
			userBean = adminDAO.getUserDetails(request.getParameter("value"));
			request.setAttribute("userBean", userBean);
			request.getRequestDispatcher("EditUserProfile.jsp").forward(request, response);
		}
		
		else if("editUser".equalsIgnoreCase(request.getParameter("action")))
		{
			boolean resultOfUpdate=false;
			UserBean userProfile=new UserBean();
			userProfile.setDisplayName(request.getParameter("userDisplayName"));
			userProfile.setPublicIdentity(request.getParameter("userPublicIdentity"));
			userProfile.setPrivateIdentity(request.getParameter("userSipUri"));
			userProfile.setRealm(request.getParameter("realm"));
			userProfile.setWsUri(request.getParameter("userWsUri"));
			resultOfUpdate=new AdminDao().updateUserDetails(userProfile);
			if(resultOfUpdate){
				System.out.println("User Data updated successfully");
				response.getWriter().println("User Data updated successfully");
			}
			else
			{
				System.out.println("User Data could not be updated successfully");
				response.getWriter().println("User Data could not be updated successfully");
			}
		}
		else if("getProfilePic".equalsIgnoreCase(request.getParameter("action")))
		{
			UserBean person=new AdminDao().getUserProfilePic(request.getParameter("id"));
			if(person==null)
			{
				System.out.println("No Record Found");
				return;
			}
			response.setContentType("image/jpeg");
			response.setContentLength(person.getProfilepic().length);
			response.getOutputStream().write(person.getProfilepic());
		}
		
		else if("login".equalsIgnoreCase(request.getParameter("action"))){
			AdminDao adminDao= new AdminDao();
			AdminBean adminBean=adminDao.checkAdmin(request.getParameter("userid"),request.getParameter("password"));
			System.out.println(adminBean.getAdminType());
			System.out.println(adminBean.getAdminStatus());
			if(adminBean!=null){
				System.out.println("hello");
				if("active".equalsIgnoreCase(adminBean.getAdminStatus())&&!"".equalsIgnoreCase(adminBean.getAdminType())){
					System.out.println("hello1");
					HttpSession session= request.getSession(false);
				session.setAttribute("userId", adminBean.getUserId());
				session.setAttribute("adminStatus", adminBean.getAdminStatus());
				session.setAttribute("adminType", adminBean.getAdminType());
				System.out.println("hello2");
				//response.sendRedirect("AdminHome.jsp");
				request.getRequestDispatcher("AdminHome.jsp").forward(request, response);
				}
				
				else{
					request.setAttribute("loginMsg", "The User Id or Password is incorrect.");
					request.getRequestDispatcher("Login.jsp").forward(request, response);
				}

			
			}
			
		}
		
		else if("logout".equalsIgnoreCase(request.getParameter("action"))){
			HttpSession session= request.getSession(false);
			session.invalidate();
			response.sendRedirect("Login.jsp");
		}
		
		else if("resetpwd".equalsIgnoreCase(request.getParameter("action"))){
			AdminDao adminDao= new AdminDao();
			String msg=adminDao.resetUserPassword(request.getParameter("sipUri"));
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("resetuserpassword.jsp").forward(request, response);
		}
		else if("ViewAllLogs".equalsIgnoreCase(request.getParameter("action")))
		{
			JSONObject jsonResponse=null;
			jsonResponse=serviceViewALlLogsRequest(request,response);
			response.setHeader("content-application", "text/json");
			response.getWriter().println(jsonResponse.toString());
		}
		else if("autoComplete".equalsIgnoreCase(request.getParameter("action")))
		{
			JSONObject jsonResponse=new JSONObject();
			String filter=request.getParameter("query");
			String filterBy=request.getParameter("option");
			System.out.println("option ="+ filterBy +" & filter="+filter);
			if(filterBy.equalsIgnoreCase("userDisplayName"))
			{
				filterBy="DISPLAYNAME";
			}
			else if(filterBy.equalsIgnoreCase("userSipUri"))
			{
				filterBy="PRIVATEIDENTITY";
			}
			ArrayList<String> listOfSuggestions=new ArrayList<String>();
			listOfSuggestions=new AdminDao().getDataForAutoComplete(filter,filterBy);
			ArrayList<JSONObject> jsonListOfSuggestions=new ArrayList<JSONObject>(); 
			try {
				jsonResponse.put("query", request.getParameter("query"));
				for(String suggestion:listOfSuggestions)
				{
					JSONObject json=new JSONObject();
					json.put("value", suggestion);
					jsonListOfSuggestions.add(json);
				}
			jsonResponse.accumulate("suggestions", jsonListOfSuggestions);
			} catch (JSONException e) {e.printStackTrace();}		
			response.setContentType("text/json");
			response.getWriter().println(jsonResponse.toString());
		}
		else if("deleteUser".equalsIgnoreCase(request.getParameter("action")))
		{
			System.out.println("hyy");
			String userId=request.getParameter("PRIVATEIDENTITY");
			System.out.println(userId);
			new AdminDao().deleteUser(userId);
			String listData="{\"Result\":\"OK\"}";       
			response.getWriter().print(listData);
		}
		else if("viewgraph".equalsIgnoreCase(request.getParameter("action")))
		{
		String sipURI=request.getParameter("sipUri");
		//SipCallLogDao scld=new SipCallLogDao();
		AdminDao adminDao= new AdminDao();
		AnalyticsBean analyticsBean=adminDao.populateGraphDataByYear(sipURI);
		request.setAttribute("sipUri", sipURI);
		request.setAttribute("analyticsBean", analyticsBean);
		request.getRequestDispatcher("CallGraph.jsp").forward(request, response);
		}
		else if("viewAllFriends".equalsIgnoreCase(request.getParameter("action")))
		{
			JSONObject jsonResponse=null;
			jsonResponse=serviceViewAllFriends(request,response);
			response.setHeader("content-application", "text/json");
			response.getWriter().println(jsonResponse.toString());
		}
		else if("viewUsersFriends".equalsIgnoreCase(request.getParameter("action")))
		{
			
			JSONObject jsonResponse=null;
			jsonResponse=serviceViewUsersFriends(request,response);
			response.setHeader("content-application", "text/json");
			response.getWriter().println(jsonResponse.toString());
		}
		
		else if("deleteFriend".equalsIgnoreCase(request.getParameter("action"))){
			String userId=request.getParameter("USERID");
			String friendSipUri=request.getParameter("FRIENDSIPURI");
			String friendName=request.getParameter("FRIENDNAME");
			System.out.println(userId);
			System.out.println(friendSipUri);
			System.out.println(friendName);
			boolean del=new AdminDao().deleteFriend(userId,friendSipUri,friendName);
			if(del){
				String listData="{\"Result\":\"OK\"}";       
				response.getWriter().print(listData);
			}
			else{
				String listData="{\"Error\":\"The friend could not be deleted.\"}";       
				response.getWriter().print(listData);
			}
		}
		else if("addFriend".equalsIgnoreCase(request.getParameter("action"))){
			String userId=request.getParameter("SIPURI");
			String friendSipUri=request.getParameter("FRIENDSIPURI");
			String friendName=request.getParameter("FRIENDNAME");
			System.out.println(userId);
			System.out.println(friendSipUri);
			System.out.println(friendName);
			boolean del=new AdminDao().addFriend(userId,friendSipUri,friendName);
			if(del){
				JSONObject jsonResponse=new JSONObject();
				try {
					jsonResponse.put("Result","OK");
					JSONObject friend=new JSONObject();
					friend.put("USERSIPURI",request.getParameter("SIPURI"));
					friend.put("FRIENDSIPURI", request.getParameter("FRIENDSIPURI"));
					friend.put("FRIENDNAME",request.getParameter("FRIENDNAME"));
					jsonResponse.put("Record", friend);
					jsonResponse.put("TotalRecordCount",1);
					response.setHeader("content-application", "text/json");
					response.getWriter().println(jsonResponse.toString());
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			
			}
			else{
				String listData="{\"Error\":\"The friend could not be deleted.\"}";       
				response.getWriter().print(listData);
			
			}
		}


	}
	
	private JSONObject serviceViewUsersFriends(HttpServletRequest request,HttpServletResponse response) {
		JSONObject jsonResponse=new JSONObject();
		AdminDao adminDAO=new AdminDao();
		boolean error=false;
		try
		{
			System.out.println(request.getParameter("userId"));
			System.out.println(request.getParameter("USERID"));
			ArrayList<FriendsBean> listOffriends= new ArrayList<FriendsBean>();
			int totalRecordCount=-1;
			jsonResponse.put("Result","OK");
			
			listOffriends=adminDAO.getUserFriends(Integer.parseInt(request.getParameter("jtStartIndex")),
					Integer.parseInt(request.getParameter("jtPageSize")),
					request.getParameter("jtSorting"),request.getParameter("userId"));
			
			totalRecordCount=adminDAO.getNoOfFriends(request.getParameter("userId"));
			ArrayList<JSONObject> jsonFriendList=new ArrayList<JSONObject>();
			for(FriendsBean currentFriend: listOffriends){
				JSONObject friend=new JSONObject();
				friend.put("USERSIPURI",currentFriend.getUserSipUri());
				friend.put("FRIENDSIPURI", currentFriend.getFreindSipUri());
				friend.put("FRIENDNAME",currentFriend.getFriendName());
				jsonFriendList.add(friend);
			}
			jsonResponse.accumulate("Records", jsonFriendList);
			jsonResponse.put("TotalRecordCount",totalRecordCount);
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
	
	private JSONObject serviceViewAllFriends(HttpServletRequest request,HttpServletResponse response) {
		JSONObject jsonResponse=new JSONObject();
		AdminDao adminDAO=new AdminDao();
		String filterVal=request.getParameter("queryFilter");
		String filterField=request.getParameter("columnName");
		boolean error=false;
		try
		{
			ArrayList<FriendsBean> listOffriends= new ArrayList<FriendsBean>();
			int totalRecordCount=-1;
			jsonResponse.put("Result","OK");
			if((filterField!=null)&&((filterVal!=null)&&(filterVal!="")))
			{
				listOffriends=adminDAO.getAllFriends(Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"),filterVal, filterField);
				totalRecordCount=adminDAO.getUserCount(filterVal, filterField);
			}
			else if(filterVal==null||filterVal==""||filterField.equalsIgnoreCase("Select"))
			{
				listOffriends=adminDAO.getAllFriends(Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"));
				totalRecordCount=adminDAO.getUserCount();
			}
			ArrayList<JSONObject> jsonFriendList=new ArrayList<JSONObject>();
			for(FriendsBean currentFriend: listOffriends){
				JSONObject friend=new JSONObject();
				friend.put("USERSIPURI",currentFriend.getUserSipUri());
				friend.put("FRIENDSIPURI", currentFriend.getFreindSipUri());
				friend.put("FRIENDNAME",currentFriend.getFriendName());
				jsonFriendList.add(friend);
			}
			jsonResponse.accumulate("Records", jsonFriendList);
			jsonResponse.put("TotalRecordCount",totalRecordCount);
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

	private JSONObject serviceViewALlUsersRequest(HttpServletRequest request,HttpServletResponse response) 
	{
		JSONObject jsonResponse=new JSONObject();
		AdminDao adminDAO=new AdminDao();
		String filterVal=request.getParameter("queryFilter");
		String filterField=request.getParameter("columnName");
		boolean error=false;
		try
		{	
			ArrayList<UserBean>	listOfUsers=new ArrayList<UserBean>();
			listOfUsers=adminDAO.getAllUsers();
			int totalRecordCount=-1;
			jsonResponse.put("Result","OK");
			if((filterField!=null)&&((filterVal!=null)&&(filterVal!="")))
			{
				listOfUsers=adminDAO.viewAllUsers(Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"),filterVal, filterField);
				totalRecordCount=adminDAO.getUserCount(filterVal, filterField);
			}
			else if(filterVal==null||filterVal==""||filterField.equalsIgnoreCase("Select"))
			{
				listOfUsers=adminDAO.viewAllUsers(Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"));
				totalRecordCount=adminDAO.getUserCount();
			}
			ArrayList<JSONObject> jsonUserList=new ArrayList<JSONObject>();
			for(UserBean currentUser: listOfUsers)
			{
				JSONObject user=new JSONObject();
				user.put("DISPLAYNAME",currentUser.getDisplayName());
				user.put("PUBLICIDENTITY",currentUser.getPublicIdentity());
				user.put("PRIVATEIDENTITY",currentUser.getPrivateIdentity());
				user.put("DETAILS",currentUser.getPrivateIdentity());
				user.put("EDIT",currentUser.getPrivateIdentity());
				jsonUserList.add(user);
			}
			jsonResponse.accumulate("Records", jsonUserList);
			jsonResponse.put("TotalRecordCount",totalRecordCount);
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

	private JSONObject serviceViewALlLogsRequest(HttpServletRequest request,HttpServletResponse response) 
	{
		JSONObject jsonResponse=new JSONObject();
		AdminDao callLogDao=new AdminDao();
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
		


