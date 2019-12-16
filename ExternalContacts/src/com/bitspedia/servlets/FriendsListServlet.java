package com.bitspedia.servlets;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.FacebookException;
import com.restfb.Parameter;
import com.restfb.types.User;

public class FriendsListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("code");

		String MY_ACCESS_TOKEN = "";
		String authURL = "https://graph.facebook.com/oauth/access_token?client_id=160619387481905&redirect_uri=http://localhost:8080/facebookfriends/FriendsListServlet&client_secret=d00208894f3fae803e9a6282d6c430dc&code="
				+ code;
		URL url = new URL(authURL);
		String result = readURL(url);
		String[] pairs = result.split("&");

		for (String pair : pairs) {
			String[] kv = pair.split("=");
			if (kv[0].equals("access_token")) {
				MY_ACCESS_TOKEN = kv[1];
			}
		} // end of for loop

		FacebookClient facebookClient = new DefaultFacebookClient(
				MY_ACCESS_TOKEN);
		Connection<com.restfb.types.User> friends = null;
		
		try {
			friends = facebookClient.fetchConnection("me/friends", User.class,Parameter.with("fields", "id, name,picture,email"));
		} catch (FacebookException e) {			
			e.printStackTrace();
		}
		
		List<com.restfb.types.User> friendsList = friends.getData();
		request.setAttribute("friendsList",friendsList);
		
		for (User user : friendsList) {
			System.out.println(user.getId() + " : " + user.getName() + " : " + user.getEmail());
		}
		
		getServletConfig().getServletContext().getRequestDispatcher("/FriendsList.jsp").forward(request, response);
	}
		
	private String readURL(URL url) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		InputStream is = url.openStream();
		int r;
		while ((r = is.read()) != -1) {
			baos.write(r);
		}
		return new String(baos.toByteArray());
	}
}
