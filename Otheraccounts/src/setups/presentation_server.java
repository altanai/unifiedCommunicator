package setups;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;

public class presentation_server {
public String[] read_presentation_server_file(){
	String ip=null;
	String arr[]= new String[1];
	  try{

		  FileInputStream fstream = new FileInputStream("/home/altanai/altanaiworkspace3/presentation_server_config.txt");

		  DataInputStream in = new DataInputStream(fstream);
		  BufferedReader br = new BufferedReader(new InputStreamReader(in));
		  String strLine;

		  while ((strLine = br.readLine()) != null)   {
		  //System.out.println ("ip :"+strLine);
		  ip=strLine;
		  System.out.println("ip:"+ip);
		  }

		  in.close();
		    }
		  
		  catch (Exception e){
		  System.err.println("Error: " + e.getMessage());
		  }

	arr[0]=ip;
	return arr;
}

public static void main(String args[]){
	presentation_server ps=new presentation_server();
	String rdarr[]=new String[1];
	rdarr=ps.read_presentation_server_file();
	System.out.println(rdarr[0]);
}

}
