package com.tcs.webrtc.adminpanel.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.tcs.webrtc.adminpanel.bean.UserProfile;
import com.tcs.webrtc.adminpanel.dao.AdminDao;


/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet("/CreateUserServlet1")
public class CreateUserServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateUserServlet1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
			boolean isMultipart=ServletFileUpload.isMultipartContent(request);
			if(!isMultipart)
			{
				System.out.println("This is not a multi-part request");
				return;
			}
			try
			{
				System.out.println("User-Creation");
				UserProfile user=new UserProfile();
				DiskFileItemFactory factory=new DiskFileItemFactory();
				ServletFileUpload upload=new ServletFileUpload(factory);
				/*@SuppressWarnings("unchecked");*/
				List<FileItem> items=upload.parseRequest(request);
				Iterator<FileItem> iterator=items.iterator();
				while(iterator.hasNext())    //reading the contents of the form
				{
					FileItem item=iterator.next();
					if(item.isFormField())
					{
						String name=item.getFieldName();
						String value=item.getString();
						if(name.equalsIgnoreCase("userdisplayName"))
							user.setDisplayName(value);
						else if(name.equalsIgnoreCase("userpublicUri"))
							user.setPublicIdentity(value);
						else if(name.equalsIgnoreCase("userSipUri"))
							user.setPrivateIdentity(value);
						else if(name.equalsIgnoreCase("userWsUri"))
							user.setWsUri(value);
						else if(name.equalsIgnoreCase("userRealm"))
							user.setRealm(value);
					}
					else
					{
						String name=item.getFieldName();
						if(name.equalsIgnoreCase("userPic"))
						{
							if(item.getName()=="")
							{
								FileInputStream fileInputStream=null;
						      /*  File file = new File("C:\\Users\\678215\\Downloads\\Default.jpg");*/
								File file = new File(getServletContext().getRealPath("Images\\Default.jpg"));
						        byte[] bFile = new byte[(int) file.length()];
						        try 
						        {
						        	fileInputStream = new FileInputStream(file);
						        	fileInputStream.read(bFile);
						        	fileInputStream.close();
						        	user.setProfilepic(bFile);
						        }
						        catch(Exception e){e.printStackTrace();}
							}
							else
							{
								user.setProfilepic(item.get());
								user.setPicfile(item.getName());
							}
						}
					}
				}
				
				boolean resultOfInsert;
				resultOfInsert=new AdminDao().createUserProfile(user);
				 String addResult="";
				 if(resultOfInsert)
				 {		
					 addResult="User added successfully";
					 System.out.println("The values were added Successfully");
				 }
				 else
					 addResult="Could not add the user";
				 request.setAttribute("msg",addResult);
				 request.getRequestDispatcher("CreateResult.jsp").forward(request, response);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
	}
			
}		
		


