package org.scribe.examples;


import java.util.Scanner;

import org.scribe.builder.ServiceBuilder;
import org.scribe.builder.api.LinkedInApi;
import org.scribe.model.OAuthRequest;
import org.scribe.model.Response;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.model.Verifier;
import org.scribe.oauth.OAuthService;

public class LinkedExample
{
	private static final String AUTHORIZE_URL = "https://api.linkedin.com/uas/oauth/authorize?oauth_token=";
	private static final String PROTECTED_RESOURCE_URL = "http://api.linkedin.com/v1/people/~/connections:(first-name,last-name)";
	
	public static void main(String[] args)
	{
	
		OAuthService service = new ServiceBuilder()
								.provider(LinkedInApi.class)
								.apiKey("75mczb8zn9ubkd")
								.apiSecret("ZU4PZJzHA692vift")
								.scope("r_fullprofile")
								.scope("r_emailaddress")
								.scope("r_network")
								.build();
		
		Scanner in = new Scanner(System.in);
		Token requestToken = service.getRequestToken();
		String authUrl = service.getAuthorizationUrl(requestToken);
		System.out.println("Now go and authorize Scribe here:");
		System.out.println(AUTHORIZE_URL + requestToken.getToken());
		System.out.println("And paste the verifier here");
		System.out.print(">>");
		
		Verifier verifier = new Verifier(in.nextLine());
		System.out.println();
		
		// Trade the Request Token and Verfier for the Access Token
		Token accessToken = service.getAccessToken(requestToken, verifier);
		// Now let's go and ask for a protected resource!
		OAuthRequest request = new OAuthRequest(Verb.GET, PROTECTED_RESOURCE_URL);
		service.signRequest(accessToken, request);
		Response response = request.send();
		System.out.println(response.getBody());
		System.out.println(service.getRequestToken());
	}

}