package com.tcs.webrtc.voicemail.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.tcs.webrtc.voicemail.bean.FriendBean;
import com.tcs.webrtc.voicemail.bean.VoiceMail;
import com.tcs.webrtc.voicemail.dao.VoiceMailDao;

import java.io.*;
import java.util.ArrayList;

/**
 * Servlet implementation class VoiceMailServlet
 */
@WebServlet("/VoiceMailServlet")
public class VoiceMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VoiceMailServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("action"));
		if("recordVoiceMail".equalsIgnoreCase(request.getParameter("action")))
		{
			if("audio".equalsIgnoreCase(request.getParameter("type")))
			{
				System.out.println("recording audio");
				InputStream inputStream=request.getInputStream();
				String from=request.getParameter("from").replace(":", "_");
				from=from.replace(".", "_");
				from=from.replace("@", "_");
				String to=request.getParameter("to").replace(":", "_");
				to=to.replace(".", "_");
				to=to.replace("@", "_");
				String fileName=from+"to"+to+".wav";
				System.out.println(fileName);
				FileOutputStream fout=new FileOutputStream(fileName);
				byte[] buffer = new byte[1024 * 1024];
				int data;
				while ((data = inputStream.read(buffer)) != -1){
					fout.write(buffer, 0, data);
				}
				fout.close();
				inputStream.close();
			}
			else if("video".equalsIgnoreCase(request.getParameter("type")))
			{
				System.out.println("recording video");
				InputStream inputStream=request.getInputStream();
				String from=request.getParameter("from").replace(":", "_");
				from=from.replace(".", "_");
				from=from.replace("@", "_");
				String to=request.getParameter("to").replace(":", "_");
				to=to.replace(".", "_");
				to=to.replace("@", "_");
				String fileName=from+"to"+to+".wav";
				System.out.println(fileName);
				FileOutputStream fout=new FileOutputStream(fileName);
				byte[] buffer = new byte[1024 * 1024];
				int data;
				while ((data = inputStream.read(buffer)) != -1){
					fout.write(buffer, 0, data);
				}
				fout.close();
				inputStream.close();
			}
			response.getWriter().println("Voice Mail Recorded Successfully");
		}

		else if("saveVoiceMail".equalsIgnoreCase(request.getParameter("action")))
		{
			String fileName=request.getParameter("fileName");
			FileInputStream fin=null;
			try
			{
				File file = new File(fileName);
				byte[] bFile = new byte[(int) file.length()];
				fin=new FileInputStream(file);
				fin.read(bFile);
				fin.close();
				VoiceMail recordedMsg=new VoiceMail();
				recordedMsg.setFromUser(request.getParameter("from"));
				recordedMsg.setToUser(request.getParameter("to"));
				recordedMsg.setVoiceMailFile(fileName);
				recordedMsg.setVoiceMail(bFile);
				if(new VoiceMailDao().saveVoiceMail(recordedMsg))
				{
					if(file.exists()){
						file.delete();
					}
					System.out.println("Success");
					response.getWriter().println("Voice Mail Saved Successfully");
				}
				else response.getWriter().println("Voice Mail Couldn't be Saved Successfully");	
			}
			catch(FileNotFoundException e)
			{
				e.printStackTrace();
			}

		}
		else if("discardVoiceMail".equalsIgnoreCase(request.getParameter("action")))
		{
			File file = new File(request.getParameter("fileName"));
			if(file.exists()){
				file.delete();
				response.getWriter().println("Voice Mail Has Been Discarded.");
			}
		}
		else if("getVoiceMails".equalsIgnoreCase(request.getParameter("action")))
		{
			JSONObject jsonResponse=null;
			jsonResponse=serviceViewVoiceMails(request,response);	
			response.setHeader("content-application", "text/json");
			response.getWriter().println(jsonResponse.toString());
		}
		else if("getParticularVoiceMail".equalsIgnoreCase(request.getParameter("action")))
		{
			VoiceMail particularMail=new VoiceMail();
			particularMail=new VoiceMailDao().getParticularVoiceMail(request.getParameter("id"));
			response.setContentType("video/mp4");
			response.getOutputStream().write(particularMail.getVoiceMail());
		}
		
		else if("record".equalsIgnoreCase(request.getParameter("action")))
		{
			VoiceMailDao mailDao= new VoiceMailDao();
			FriendBean friendList=mailDao.getFriends(request.getParameter("id"));
			request.setAttribute("friendList", friendList);
			request.getRequestDispatcher("RecordVoiceMail.jsp").forward(request, response);
		}
		else if("deleteVoiceMail".equalsIgnoreCase(request.getParameter("action")))
		{
			boolean flag=false;
			VoiceMailDao mailDao= new VoiceMailDao();
			String userId=(String)request.getSession().getAttribute("privateIdentity");
			System.out.println(request.getParameter("MAILID")+" AND" +userId+""+request.getParameter("delFrom"));
			flag=mailDao.deleteMail(request.getParameter("MAILID"), userId,request.getParameter("delFrom"));
			if(flag){
				String listData="{\"Result\":\"OK\"}";       
				response.getWriter().print(listData);

			}
			else{
				String listData="{\"Error\":\"Some Error Occured\"}";       
				response.getWriter().print(listData);
			}
		}
		else if("updateReadStatus".equalsIgnoreCase(request.getParameter("action")))
		{
			String []arr=request.getParameter("mailId").split("/");
			String voiceMailId=arr[arr.length-1];
			String userId=(String)request.getSession().getAttribute("privateIdentity");
			boolean result=new VoiceMailDao().updateReadStatus(voiceMailId,userId);
			response.setContentType("text/html");
			response.getWriter().println(result);
		}
		else if("autoComplete".equalsIgnoreCase(request.getParameter("action")))
		{
			System.out.println("Code for autoSuggest");
	    	String query=request.getParameter("query");
	    	System.out.println(query);
	    	ArrayList<String> listOfFriends=new VoiceMailDao().getDataForAutoComplete(query);
	    	JSONObject jsonResponse=new JSONObject();
	    	ArrayList<JSONObject> jsonArray=new ArrayList<JSONObject>();
	    	try 
	    	{
				jsonResponse.put("query", query);
				for(String str:listOfFriends)
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
	}
	private JSONObject serviceViewVoiceMails(HttpServletRequest request,HttpServletResponse response) {
		JSONObject jsonResponse=new JSONObject();
		VoiceMailDao voiceMailDao=new VoiceMailDao();
		String userId=(String)request.getSession().getAttribute("privateIdentity");
		String userId1=(String)request.getSession().getAttribute("privateIdentity");
		userId=userId.replace(".", "_");
		userId=userId.replace(":", "_");
		userId=userId.replace("@", "_");
		String searchIn=request.getParameter("searchIn");
		String searchBy=request.getParameter("searchBy");
		String filterVal=request.getParameter("field");
		System.out.println("searchIn:"+ searchIn+" searchby:"+ searchBy +" field:"+ filterVal);
		String path=request.getServletContext().getRealPath("VoiceMails");
		File directory=new File(path+"/"+userId);
		boolean error=false;
		try
		{
			ArrayList<VoiceMail> listOfVoiceMails= new ArrayList<VoiceMail>();
			int totalRecordCount=-1;
			jsonResponse.put("Result","OK");
			
			if((searchIn.equals("INBOX"))&&((searchBy.equalsIgnoreCase("Select"))||(searchBy.equalsIgnoreCase("ALL")))&&filterVal==null)
			{
				listOfVoiceMails=voiceMailDao.getAllVoiceMailsForSpecificUser(userId1,Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"));
				totalRecordCount=voiceMailDao.getInboxMailCount(userId1);
			}
			 else if((searchIn.equals("INBOX"))&&!(searchBy.equalsIgnoreCase("Select"))&&(filterVal==null))
			{
				listOfVoiceMails=voiceMailDao.getAllVoiceMailsForSpecificUser(userId1, Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"),searchBy);
				totalRecordCount=voiceMailDao.getInboxMailCount(userId1, searchBy);
			}
			else if((searchIn.equals("SENTBOX"))&&(searchBy.equalsIgnoreCase("ALL"))&&((filterVal==null)||(filterVal=="")))
			{
				listOfVoiceMails=voiceMailDao.getAllVoiceMailsSentBySpecificUser(userId1, Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"));
				totalRecordCount=voiceMailDao.getOutboxMailCount(userId1);
			}
			else if((searchIn.equals("SENTBOX"))&&(searchBy.equalsIgnoreCase("DATE"))&&filterVal!=null)
			{
				listOfVoiceMails=voiceMailDao.getAllVoiceMailsSentBySpecificUser(userId1, Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"),searchBy,filterVal);
				totalRecordCount=voiceMailDao.getOutboxMailCount(userId1,filterVal);
			}
			else if((searchIn.equals("SENTBOX"))&&(searchBy.equalsIgnoreCase("Select"))&&filterVal=="")
			{
				listOfVoiceMails=voiceMailDao.getAllVoiceMailsSentBySpecificUser(userId1, Integer.parseInt(request.getParameter("jtStartIndex")),
						Integer.parseInt(request.getParameter("jtPageSize")),
						request.getParameter("jtSorting"));
				totalRecordCount=voiceMailDao.getOutboxMailCount(userId1);
			}
			ArrayList<JSONObject> jsonVoiceMailList=new ArrayList<JSONObject>();
			for(VoiceMail currentMail: listOfVoiceMails){
				JSONObject mail=new JSONObject();
				mail.put("FROMUSER",currentMail.getFromUser());
				mail.put("TOUSER", currentMail.getToUser());
				mail.put("MAILTIME",currentMail.getTimeOfMail());
				mail.put("MAILID", currentMail.getVoiceMailId());
				jsonVoiceMailList.add(mail);
				if (directory.exists())
				{
					System.out.println("inside exists");
					File voiceMessage = new File(directory,currentMail.getVoiceMailId() + ".wav");
					FileOutputStream fout = new FileOutputStream(voiceMessage);
					fout.write(currentMail.getVoiceMail());
					fout.flush();
					fout.close();
				} else {
					System.out.println("Inside doesnt exists");
					directory.mkdir();
					File voiceMessage = new File(directory,
							currentMail.getVoiceMailId() + ".wav");
					FileOutputStream fout = new FileOutputStream(voiceMessage);
					fout.write(currentMail.getVoiceMail());
					fout.flush();
					fout.close();
				}
			}
			jsonResponse.accumulate("Records", jsonVoiceMailList);
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

}
