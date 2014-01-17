
import java.io.IOException;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phonebook.presenceDao;

/**
 * Servlet implementation class SipCallLogServlet
 */

public class PresenceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PresenceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.println(" Inside Servlet 1 -> get");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String values[][]=new String[20][2];
		
				int i=0;
			
				values[i][0]=request.getParameter("friend1");
				values[i][1]=request.getParameter("friend1status");
				
			System.out.println("-----------------Writing presence ------------------------user is "+values[i][0]+" || status is"+values[i][1]);

			presenceDao pd=new presenceDao();
			pd.writepresence(values[i][0],values[i][1]);			
			
			i++;

	}
	

}