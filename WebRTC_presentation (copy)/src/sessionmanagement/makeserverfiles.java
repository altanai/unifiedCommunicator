package sessionmanagement;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

import setups.presentation_server;

import contacts.webrtc.loaduserfrnds;

public class makeserverfiles {
	public void WriteServeripFile() {
		try {
			System.out.println("-------------make server files at sipml5 and pageone------------------ ");
			//--------------------------------presentation server
			presentation_server ps=new presentation_server();
			String rdarr[]=new String[1];
			rdarr=ps.read_presentation_server_file();
			String serverip=rdarr[0];
			//--------------------------pr4esentation server			
			
			File filereadip = new File("/home/altanai/altanaiworkspace3/presentation_server_config.txt");
			String contents = new Scanner(filereadip).useDelimiter("\n").next();
			
			System.out.println(" content ip "+ contents);
			          
           
           
           
			//  file exists, rewrite it in sipml5 folder
           System.out.println("----------------> writing to sipml5 local file ");
           
           File serverfilesipml5 = new File("/home/altanai/altanaiworkspace3/WebRTC_presentation/WebContent/sipml5/presentation_server_config.txt");
           FileOutputStream fooStream = new FileOutputStream(serverfilesipml5, false); // true to append                                                                         // false to overwrite.
           byte[] myBytes = serverip.getBytes() ;
           fooStream.write(myBytes);
           fooStream.close();
           
           //reda to confirm from file 
			System.out.println("reading from sipml5 local file ");
			File filereadip2 = new File("/home/altanai/altanaiworkspace3/WebRTC_presentation/WebContent/sipml5/presentation_server_config.txt");
			String contents2 = new Scanner(filereadip2).useDelimiter("\n").next();			
			System.out.println(" ip "+ contents2);
			
			
			
			
			
		//  file exists, rewrite it in pageone folder
	       System.out.println("----------------> writing to pageone local file ");
			
		    File serverfilepageone = new File("/home/altanai/altanaiworkspace3/WebRTC_presentation/WebContent/pageone/presentation_server_config.txt");
           FileOutputStream fooStream2 = new FileOutputStream(serverfilepageone, false); // true to append                                                                         // false to overwrite.
           byte[] myBytes2 = serverip.getBytes() ;
           fooStream2.write(myBytes);
           fooStream2.close();
           
           //reading to confirm from file 
			System.out.println("reading from pageone local file ");
			File filereadip3 = new File("/home/altanai/altanaiworkspace3/WebRTC_presentation/WebContent/pageone/presentation_server_config.txt");
			String contents3 = new Scanner(filereadip3).useDelimiter("\n").next();			
			System.out.println(" ip "+ contents3);
           
           
 
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//-------------------------------------------

	public static void main( String args[]){
		makeserverfiles lf=new makeserverfiles();
		lf.WriteServeripFile();
	}
}
