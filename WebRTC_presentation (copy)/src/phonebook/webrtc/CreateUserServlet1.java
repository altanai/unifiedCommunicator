package phonebook.webrtc;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import phonebook.webrtc.CreateUserDao;
import phonebook.webrtc.UserProfile;
import presence.beanclass.presence;

/**
 * Servlet implementation class CreateUserServlet
 */

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
	
		String action=request.getParameter("action");
		FileInputStream inputStream=null; 
		if(action.equalsIgnoreCase("ViewList"))
		{
			ArrayList<presence> pslist= (ArrayList<presence>) request.getAttribute("registrationDetails");
			
			ArrayList<UserProfile> profiles=null;
			profiles=new CreateUserDao().getListOfUsers();
			
			if(profiles==null)
			{
				response.setContentType("image/jpeg");
				File image=new File("/home/altanai/altanaiworkspace3/UploadPicsAudioVideo/WebContent/images/thumb-pic.png");
				inputStream =new FileInputStream(image);
				byte[] bytes =IOUtils.toByteArray(inputStream);
				response.getOutputStream().write(bytes);
				return;
			}
			else
			{
				request.setAttribute("List", profiles);
				request.getRequestDispatcher("pageone/phonebookline.jsp").forward(request, response);
			}
		}

		if(action.equalsIgnoreCase("getProfilePic"))
		{
			
			UserProfile person=new CreateUserDao().getUser(request.getParameter("id"));
			if(person==null)
			{
				System.out.println("No Record Found");
				return;
			}
			
			response.setContentType("image/jpeg");
			response.setContentLength(person.getProfilepic().length);
			
			response.getOutputStream().write(person.getProfilepic());
		}

	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int i=0;
		
		//String action=request.getRequestURI().split("/")[request.getRequestURI().split("/").length-1];
		//System.out.println(action);
		//if(action.equalsIgnoreCase("AddUser"))
		//{
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
						String value=item.getString();
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
						
						if(name.equalsIgnoreCase("audio"))
						{
							user.setFavaudio(item.get());
							user.setAudiofile(item.getName());
						}
						if(name.equalsIgnoreCase("video"))
						{
							user.setFavvideo(item.get());
							user.setVideofile(item.getName());
						}
					}
							
				}
				// send the object to dao to be inserted into the database
				/* i=new CreateUserDao().addUser(user);
				 String addResult="";
				 if(i>0)
				 {		
					 addResult="User added successfully";
					 System.out.println("The values were added Successfully");
				 }
				 else
					 addResult="Could not add the user";
				 request.setAttribute("msg",addResult);
				 request.getRequestDispatcher("CreateResult.jsp").forward(request, response);*/
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		}
		
	}

//}
