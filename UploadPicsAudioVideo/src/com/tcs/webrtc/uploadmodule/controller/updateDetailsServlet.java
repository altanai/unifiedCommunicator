package com.tcs.webrtc.uploadmodule.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import com.tcs.webrtc.uploadmodule.Dao.CreateUserDao;
import com.tcs.webrtc.uploadmodule.Dao.updateDetailsDao;
import com.tcs.webrtc.uploadmodule.bean.UserProfile;

/**
 * Servlet implementation class updateDetailsServlet
 */

public class updateDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static String url="jdbc:mysql://10.1.5.15:3306/webrtcdb";
	private static String uName="altanai";
	private static String pwd="altanai";
	
	
	
    public updateDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn=null;
		PreparedStatement ps=null;
		PreparedStatement ps1=null;
		PreparedStatement ps2=null;
		PreparedStatement ps3=null;
		
		
		String privateIdentity =request.getParameter("privateIdentity");
		System.out.println("++++++"+privateIdentity);
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, uName, pwd);
			
			conn.setAutoCommit(false);
			ps=conn.prepareStatement("update registrationtable set DisplayName=?,PublicIdentity=?,Password=?,WSUri=?,Realm=? where privateIdentity='"+privateIdentity+"'");
		//	ps.setString(1, user.getId());
			UserProfile user=new UserProfile();
			
			ps.setString(1, request.getParameter("displayName"));
			ps.setString(2, request.getParameter("publicIdentity"));
			ps.setString(3, request.getParameter("password"));
			ps.setString(4, request.getParameter("wsUri"));
			ps.setString(5, request.getParameter("realm"));
		int w =ps.executeUpdate();
			
			
		ps1=conn.prepareStatement("update forgotpwd set username=?,PublicIdentity=?,Realm=? where PrivateIdentity='"+privateIdentity+"'");
			ps1.setString(1,request.getParameter("displayName"));
			ps1.setString(2, request.getParameter("publicIdentity"));
			ps1.setString(3,request.getParameter("realm"));
			
			int x=ps1.executeUpdate();
			ps2 = conn.prepareStatement("update login set username=?,password=? where privateIdentity='"+privateIdentity+"'");
			ps2.setString(1,request.getParameter("displayName"));
			ps2.setString(2,request.getParameter("password"));
			int y = ps2.executeUpdate();
			
			ps3 = conn.prepareStatement("update siptable set username=? where privateIdentity='"+privateIdentity+"'");
			ps3.setString(1,request.getParameter("displayName"));

			int z = ps3.executeUpdate();
			if(w>0&&x>0&&y>0&&z>0){
				conn.commit();
				
		}
			else{
				conn.rollback();
			}
			response.sendRedirect("http://localhost:8080/UploadPicsAudioVideo/CreateUserServlet?action=getUser&id="+privateIdentity);
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int i=0;
		FileInputStream inputStream = null;
		
		
			boolean isMultipart=ServletFileUpload.isMultipartContent(request);
			if(!isMultipart)
			{
				System.out.println("This is not a multi-part request");
				return;
			}
			try
			{
				UserProfile user=new UserProfile();
				DiskFileItemFactory factory=new DiskFileItemFactory();
				ServletFileUpload upload=new ServletFileUpload(factory);
				@SuppressWarnings("unchecked")
				List<FileItem> items=upload.parseRequest(request);
				Iterator<FileItem> iterator=items.iterator();
				while(iterator.hasNext())    //reading the contents of the form
				{
					FileItem item=iterator.next();
					if(item.isFormField())
					{
						String name=item.getFieldName();
						System.out.println("++++++"+name);
						String value=item.getString();
						System.out.println("++++++++++"+value);
						if(name.equalsIgnoreCase("name"))
							user.setName(value);
/*						if(name.equalsIgnoreCase("userid"))
							user.setId(value);*/
					}
					else
					{
						String name=item.getFieldName();
						if(name.equalsIgnoreCase("picture"))
						{
							
							user.setProfilepic(item.get());
							user.setPicfile(item.getName());
						}
						
					/*if(name.equalsIgnoreCase("picture")&& item.get().length==0)
						{
							System.out.println("when image is default ");
							//File image = new File("UploadPicsAudioVideo/images/thumb-pic.png"); 
							File image = new File("C:/altanai/thumb-pic.png");
							inputStream = new FileInputStream(image); 
							byte[] bytes = IOUtils.toByteArray(inputStream);
							user.setProfilepic(bytes);
							user.setPicfile("default");
						}
						*/
						
						
					}
			}		
				
				// send the object to dao to be inserted into the database
				 i=new updateDetailsDao().addUser(user);
				 String addResult="";
				 if(i>0)
				 {		
					 addResult="Updated successfully";
					 System.out.println("The values were added Successfully");
					 
				 }
				 else
					 addResult="Could not update";
				/* request.setAttribute("msg",addResult);
				 request.getRequestDispatcher("ViewResult.jsp").forward(request, response);*/

                  response.sendRedirect("http://localhost:8080/UploadPicsAudioVideo/CreateUserServlet?action=getUser&id="+user.getName());
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		}
		
	}
