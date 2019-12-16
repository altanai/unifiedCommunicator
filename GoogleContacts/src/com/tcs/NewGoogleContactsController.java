package com.tcs;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gdata.client.contacts.ContactsService;
import com.google.gdata.data.contacts.ContactEntry;
import com.google.gdata.data.contacts.ContactFeed;
import com.google.gdata.data.extensions.Email;
import com.google.gdata.util.AuthenticationException;
import com.google.gdata.util.ServiceException;

/**
 * Servlet implementation class NewGoogleContactsController
 */

public class NewGoogleContactsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewGoogleContactsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String EmailAddress = request.getParameter("emailAddress");
		System.out.println("email" + EmailAddress);
		String password = request.getParameter("password");
		System.out.println("pass" + password);
				
		HttpSession session = request.getSession();
		
		ContactsService myService = new ContactsService("contactsclientapp");
		try {
			myService.setUserCredentials((String) session.getAttribute("EmailAddress"), (String) session.getAttribute("password"));

			printAllContacts(myService, (String) session.getAttribute("EmailAddress"));

			ArrayList<String> strlist = printAllContacts(myService,
					(String) session.getAttribute("EmailAddress"));
			/*
			 * for( int i=0;i<strlist.size();i++)
			 * out.println(strlist.get(i).toString());
			 */
			request.setAttribute("details", strlist);
			request.getRequestDispatcher("contacts.jsp").forward(request,
					response);
		} catch (AuthenticationException e) {
			e.printStackTrace();
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<String> printAllContacts(ContactsService myService,
			String EmailAddress) throws ServiceException, IOException {
		String returnstr = null;
		ArrayList<String> str = new ArrayList<String>();
		URL feedUrl = new URL("http://www.google.com/m8/feeds/contacts/default/full");
		ContactFeed resultFeed = myService.getFeed(feedUrl, ContactFeed.class);
			
		System.out.println(resultFeed.getTitle().getPlainText());
		for (int i = 0; i < resultFeed.getEntries().size(); i++) {
			
			ContactEntry entry = resultFeed.getEntries().get(i);
			// out.println("\t" + entry.getTitle().getPlainText());
			// System.out.println("Email addresses:");
			for (Email email : entry.getEmailAddresses()) {
				// System.out.print(" " + email.getAddress());
				returnstr = email.getAddress();
				// System.out.print("\n");
						}
			
			/*//for profile picture
			URL feedUrl1 = new URL("http://www.google.com/m8/feeds/photos/media/"+returnstr+"/full");
			ContactFeed resultFeed1 = myService.getFeed(feedUrl1, ContactFeed.class);
			ContactEntry entry1 = resultFeed1.getEntries().get(i);
			//
*/			
			String photoLink = entry.getContactPhotoLink().getHref();
				// System.out.println("Photo Link: " + photoLink);
			returnstr = returnstr + "*" + photoLink;
			str.add(returnstr);
		}
		return str;
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
