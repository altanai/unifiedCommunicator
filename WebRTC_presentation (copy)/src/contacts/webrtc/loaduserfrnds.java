package contacts.webrtc;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;
 
public class loaduserfrnds {
	
	public void FriendsWriteToFile(String user, String[] userfriends) {
		try {
 
			
			String friends[]=new String[18];
			friends=userfriends;
			
			//File file = new File("/home/altanai/strutswkspace/userfriendsfile/"+user+".txt");
		    File friendfile = new File("/home/altanai/altanaiworkspace3/WebRTC_presentation/WebContent/sipml5/allpeople.txt");
			
/*			// if file doesnt exists, then create it
			if (!file.exists()) {
				file.createNewFile();
			}
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);			
			for( int i=0;i<friends.length;i++)
			{
			//bw.write(content);
				bw.write(friends[i]+"\n");
			}			
			bw.close();*/
		    
		    
			//  file exists, rewrite it 
	         //  FileOutputStream fooStream = new FileOutputStream(friendfile, false); // true to append                                                                         // false to overwrite.
	           BufferedWriter outputWriter = null;
	           outputWriter = new BufferedWriter(new FileWriter(friendfile));
	           
	           for(int i=0;i<friends.length;i++){
	        	   outputWriter.write(friends[i]) ;
	        	   outputWriter.newLine();
		           
	           }
	           outputWriter.flush();  
	           outputWriter.close(); 
	           
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
}
