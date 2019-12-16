package newaccount.webrtc;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import setups.presentation_server;

import com.tcs.webrtc.uploadmodule.Dao.CreateUserDao;
import com.tcs.webrtc.uploadmodule.bean.UserProfile;

/**
 * Servlet implementation class CreateUserServlet
 */

public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out = response.getWriter();
		
		String action=request.getParameter("action");
		if(action.equalsIgnoreCase("ViewList"))
		{
			ArrayList<UserProfile> profiles=null;
			profiles=new CreateUserDao().getListOfUsers();
			if(profiles==null)
			{
				return;
			}
			else
			{
				request.setAttribute("List", profiles);
				request.getRequestDispatcher("ViewListOfProfiles.jsp").forward(request, response);
			}
		}
		if(action.equalsIgnoreCase("getUser"))
		{
			String userId=request.getParameter("uri");
			
			System.out.println("----------Create Servlet : getUser()------------");
			System.out.println("sipURI :"+userId);
			
			ArrayList<UserProfile> objlist=new CreateUserDao().getUserprofiledetails(userId);
			UserProfile obj= new CreateUserDao().getUser(userId);
			
			if(objlist==null)
			{
				request.setAttribute("error", "Sorry the requested user could not be fetched");
				RequestDispatcher view = request.getRequestDispatcher("/pageone/ViewUserProfile.jsp");
				view.forward(request, response);
			}
			else
			{
				request.setAttribute("userlist", objlist);
				request.setAttribute("user", obj);
				
				System.out.println("userlist:"+ objlist.size());
				System.out.println("user:"+ obj);
/*				
				out.println("<%@include file='header.jsp' %>");
				out.println("<table width='500px' align='center' border='0' bordercolor='blue'> ");
				out.println("<tr><td><img src='../CreateUserServlet?id=<%=userlist.get(0).getName()%>&action=getProfilePic' width='180' height='210'></td> <td><%=userlist.get(0).getName() %></td></tr>");						
				out.println("<tr><td> Audio Track:	</td><td><a href='../CreateUserServlet?id=<%=userlist.get(0).getName()%>&action=audio' title='Click this link to download a copy of this Audio' target='_blank'> <%=user.getAudiofile() %></a>	</td>	</tr>");						
				out.println("<tr><td> Video Track:</td>	<td><a href='../CreateUserServlet?id=<%=userlist.get(0).getName()%>&action=video' title='Click this link to download a copy of this Video' target='_blank'><%=user.getVideofile() %></a>	</td>	</tr>");
				out.println("</table>");
				out.println("<%@include file='footer.jsp'%>");*/
				RequestDispatcher view = request.getRequestDispatcher("/pageone/ViewUserProfile.jsp");
				view.forward(request, response);
				//request.getRequestDispatcher("/pageone/ViewUserProfile.jsp").forward(request, response);		
			}
		}
		if(action.equalsIgnoreCase("getProfilePic"))
		{
			
			UserProfile person=new CreateUserDao().getUser(request.getParameter("id"));
			if(person==null)
			{
				System.out.println("No Record Found in crea user servlet 1 - Get method for " + person.getName());
				return;
			}
			response.setContentType("image/jpeg");
			response.setContentLength(person.getProfilepic().length);
			response.getOutputStream().write(person.getProfilepic());
		}
		if(action.equalsIgnoreCase("audio"))
		{
			
			UserProfile person=new CreateUserDao().getUser(request.getParameter("id"));
			if(person==null)
			{
				System.out.println("No Record Found");
				return;
			}
				/*FileOutputStream fos=new FileOutputStream("F:/"+person.getAudiofile());
				fos.write(person.getFavaudio()); //MAKE A COPY OF THE AUDIO AT THE SPECIFIED LOCATION
				fos.flush();
				fos.close();*/
				response.setContentType("audio/mp3");
				response.setHeader("Content-Disposition", "attachment; filename=\"" +person.getAudiofile()+"\"");//FORCE DOWNLOAD AS AN ATTACHMENT
				response.setContentLength(person.getFavaudio().length);
				response.getOutputStream().write(person.getFavaudio());
				
		
		}
		
		if(action.equalsIgnoreCase("video"))
		{
			UserProfile person=new CreateUserDao().getUser(request.getParameter("id"));
			if(person==null)
			{
				System.out.println("No Record Found");
				return;
			}
				String filename=person.getVideofile();
				System.out.println(filename);
				/*FileOutputStream fos=new FileOutputStream("F:/"+person.getVideofile());
				fos.write(person.getFavvideo());//MAKE A COPY OF THE VIDEO AT THE SPECIFIED LOCATION
				fos.flush();
				fos.close();*/
				response.setContentType("video/mp4");
				response.setHeader("Content-Disposition", "attachment; filename=\"" +person.getVideofile()+"\"");//FORCE DOWNLOAD AS AN ATTACHMENT
				response.setContentLength(person.getFavvideo().length);
				response.getOutputStream().write(person.getFavvideo());			
		
		}
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		 String sipuri=request.getParameter("name");
			String dName=request.getParameter("displayName");
			
		int i=0;
		FileInputStream inputStream = null;
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
					}
					else
					{
						String name=item.getFieldName();
						if(name.equalsIgnoreCase("picture"))
						{
							user.setProfilepic(item.get());
							user.setPicfile(item.getName());
						}
						
						if(name.equalsIgnoreCase("picture")&& item.get().length==0)
						{
							System.out.println("when image is default ");
							//File image = new File("UploadPicsAudioVideo/images/thumb-pic.png"); 
							File image = new File("/home/altanai/altanaiworkspace3/WebRTC_presentation/WebContent/pageone/images/thumb-pic.png");
							inputStream = new FileInputStream(image); 
							byte[] bytes = IOUtils.toByteArray(inputStream);
							user.setProfilepic(bytes);
							user.setPicfile("default");
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
				 i=new CreateUserDao().addUser(user);
				 String addResult="";
				 
				 if(i>0)
				 {		
					 addResult="User added successfully";
					 System.out.println("The values were added Successfully");
				 }
				 else
				 {
					 addResult="Could not add the user";
				 }
				// request.setAttribute("msg",addResult);
					//--------------------------------presentation server
					presentation_server ps=new presentation_server();
					String rdarr[]=new String[1];
					rdarr=ps.read_presentation_server_file();
					String serverip=rdarr[0];
			
					HttpSession session=request.getSession();
					
					 if( session.getAttribute("name")!=null)
					 {
					response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/home.jsp");
				// request.getRequestDispatcher("pageone/CreateResult.jsp").forward(request, response);
					 }
					 else{
						 /*response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/CreateResult.jsp?msg="+addResult);*/
						 response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/addmoredetails.jsp?privateIdentity="+sipuri+"&displayName="+dName);

					 }
					 
/*					 if( session.getAttribute("name")!=null)
					 {
						 response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/CreateResult.jsp?msg="+addResult);
				//	response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/home.jsp");
				// request.getRequestDispatcher("pageone/CreateResult.jsp").forward(request, response);
					 }
					 else{
						 response.sendRedirect("http://"+serverip+":8080/WebRTC_presentation/pageone/CreateResult.jsp?msg="+addResult);

					 }*/
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		}
		
	}

//}