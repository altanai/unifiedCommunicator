import java.io.File;

/**
 *
 * @author santoshk
 */
public class ListFiles_bckup {

     File mainFolder = new File("/home/altanai/altanaiworkspace3/Interest/WebContent/images");
     String[] filesindirectory=new String[50];
     int j=0;
    String resultfilepath;
     
     public static void main(String[] args)
     {
         ListFiles_bckup lf = new ListFiles_bckup();
         lf.getFiles(lf.mainFolder);
     }
    
     public String[] getFiles(File f){
         File files[];
         if(f.isFile())
         {
        	 System.out.println(f.getAbsolutePath());
        	 filesindirectory[j++]=f.getAbsolutePath();
         }
         else{
             files = f.listFiles();
             for (int i = 0; i < files.length; i++) {
                 getFiles(files[i]);
             }
         }
         
         return filesindirectory;
         
     }
     
     public String matchfilename(String objectname){
    	 
         ListFiles_bckup lf = new ListFiles_bckup();
         lf.getFiles(lf.mainFolder);
         
         for (int i = 0; i < filesindirectory.length; i++) {
             if(filesindirectory[i].contains(objectname)){
            	 resultfilepath=filesindirectory[i];
             }
         }
		return resultfilepath;
     }
     
     
}