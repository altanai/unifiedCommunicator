package setups;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;

public class database_server {
public String[] read_database_server_file(){
	  String dbip=null,uname=null, pass=null;
	String arr[]= new String[3];
	  try{

		  FileInputStream fstream = new FileInputStream("/home/altanai/altanaiworkspace3/database_server_config.txt");


		  DataInputStream in = new DataInputStream(fstream);
		  BufferedReader br = new BufferedReader(new InputStreamReader(in));
		  String strLine;

		  int i=0;
		 
		  while ((strLine = br.readLine()) != null)   {
			  i++;
		  if(i==1)dbip=strLine;
		  if(i==2)uname=strLine;
		  if(i==3)pass=strLine;
		  }

		  in.close();
		  
		//  System.out.println("dbip: "+dbip+ " uname: "+uname+" pass: "+pass);
		  
		    }
		  
		  catch (Exception e){
		  System.err.println("Error: " + e.getMessage());
		  }

		arr[0]=dbip;arr[1]=uname;arr[2]=pass;
		
		return arr;
}


public static void main(String args[]){
	database_server ps=new database_server();
	String rdarr[]=new String[3];
	rdarr=ps.read_database_server_file();
	System.out.println(rdarr[0]+rdarr[1]+rdarr[2]);
}

}
