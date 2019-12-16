package com.tcs.webrtc.voicemail.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;

import com.tcs.webrtc.voicemail.bean.FriendBean;
import com.tcs.webrtc.voicemail.bean.VoiceMail;

public class VoiceMailDao {
	private static String url = "jdbc:mysql://10.1.5.6:3306/webrtcdb";
	private static String uName = "altanai";
	private static String pwd = "altanai";


	public boolean saveVoiceMail(VoiceMail recordedMessage) {
		int resultOfInsert = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			conn.setAutoCommit(false);
			String countRows = "SELECT SEQUENCE AS COUNT FROM VOICEMAIL order by count asc";
			ps = conn.prepareStatement(countRows);
			int rowCount = 0;
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				rowCount = resultSet.getInt("COUNT");
				System.out.println(rowCount);
			}
			Calendar cal=Calendar.getInstance();
			String uniqueId = "VM"+cal.get(Calendar.YEAR)+ cal.get(Calendar.MONTH) +cal.get(Calendar.DATE) + ++rowCount;
			System.out.println(uniqueId);

			boolean flag=false;
			String Query;
			while(!flag){
				Query = "SELECT ID FROM VOICEMAILSTATUS WHERE ID='"+uniqueId+"'";
				ps = conn.prepareStatement(Query);
				ResultSet resultSet1 = ps.executeQuery();
				if(resultSet1.next()){
					rowCount=rowCount+2;
					flag=false;
				}
				else{
					flag=true;
				}
				uniqueId = "VM"+cal.get(Calendar.YEAR)+ cal.get(Calendar.MONTH) +cal.get(Calendar.DATE) + rowCount;	
			}
			recordedMessage.setVoiceMailId(uniqueId);
			Query = "INSERT INTO VOICEMAIL VALUES(?,?,?,NOW(),?,?)";
			ps = conn.prepareStatement(Query);
			ps.setString(1, recordedMessage.getVoiceMailId());
			ps.setString(2, recordedMessage.getFromUser());
			ps.setString(3, recordedMessage.getToUser());
			ps.setBytes(4, recordedMessage.getVoiceMail());
			ps.setInt(5, rowCount);
			resultOfInsert = ps.executeUpdate();
			if (resultOfInsert > 0) {
				resultOfInsert = 0;
				ps = conn
						.prepareStatement("INSERT INTO VOICEMAILSTATUS (id) VALUES (?)");
				ps.setString(1, recordedMessage.getVoiceMailId());
				resultOfInsert = ps.executeUpdate();
				if (resultOfInsert > 0) {
					conn.commit();
					conn.setAutoCommit(true);
				}
			} else {
				conn.rollback();
				conn.setAutoCommit(true);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return resultOfInsert > 0 ? true : false;
	}

	/*public ArrayList<VoiceMail> getVoiceMailsForSpecificUser(String userId)// for
	// inbox
	// functionality
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<VoiceMail> listOfVoiceMails = new ArrayList<VoiceMail>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT * FROM VOICEMAIL WHERE TOUSER='"
					+ userId
					+ "' AND ID IN  (SELECT ID from VOICEMAILSTATUS WHERE STATUS='unread') order by sequence desc";
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				VoiceMail message = new VoiceMail();
				message.setVoiceMailId(resultSet.getString(1));
				message.setFromUser(resultSet.getString(2));
				message.setToUser(resultSet.getString(3));
				message.setTimeOfMail(resultSet.getString(4));
				message.setVoiceMail(resultSet.getBytes(5));
				listOfVoiceMails.add(message);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return listOfVoiceMails;

	}*/

	public VoiceMail getParticularVoiceMail(String voiceMailId) // TO BE USED
	// WHEN USER
	// REQUESTS FOR
	// OLDER
	// VOICEMAILS
	{
		Connection conn = null;
		PreparedStatement ps = null;
		VoiceMail message = new VoiceMail();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT * FROM VOICEMAIL WHERE ID='" + voiceMailId
					+ "'";
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				message.setVoiceMailId(resultSet.getString(1));
				message.setFromUser(resultSet.getString(2));
				message.setToUser(resultSet.getString(3));
				message.setTimeOfMail(resultSet.getString(4));
				message.setVoiceMail(resultSet.getBytes(5));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return message;
	}

	public FriendBean getFriends(String sipUri) {
		Connection conn = null;
		PreparedStatement ps = null;
		FriendBean friendBean=new FriendBean();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query ="SELECT * FROM FRIENDLISTTABLE WHERE USERSIPURI='"+sipUri+"'";
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			ArrayList<String> friendList= new ArrayList<String>();
			while(resultSet.next()){
				friendList.add(resultSet.getString(2));
			}
			friendBean.setFriendList(friendList);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return friendBean;
	}

	public boolean deleteMail(String mailId, String sipUri,String box) {
		System.out.println(sipUri);
		Connection conn = null;
		PreparedStatement ps = null;
		String identity="";
		int result,resultUpdate;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query ="SELECT FROMUSER, TOUSER FROM  VOICEMAIL WHERE ID='"+mailId+"'";
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				if(sipUri.equalsIgnoreCase(rs.getString(1))){
					identity="deletedbysender";
				}
				else{
					identity="deletedbyreciever";
				}
			}
			Query ="UPDATE VOICEMAILSTATUS SET "+identity+"= 'true' WHERE ID='"+mailId+"'";
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			resultUpdate=ps.executeUpdate();
			if(resultUpdate>0){

				//trasfering data to deleted table
				
				Query ="SELECT DELETEDBYSENDER, DELETEDBYRECIEVER FROM VOICEMAILSTATUS WHERE ID='"+mailId+"'";
				System.out.println(Query);
				ps = conn.prepareStatement(Query);
				ResultSet resultSet = ps.executeQuery();
				conn.setAutoCommit(false);
				while(resultSet.next()){
					if("true".equalsIgnoreCase(resultSet.getString(1))&&"true".equalsIgnoreCase(resultSet.getString(2))){
						Query ="INSERT INTO DELETEDVOICEMAILS (SELECT * FROM VOICEMAIL WHERE ID='"+mailId+"')";
						System.out.println(Query);
						ps = conn.prepareStatement(Query);
						result=ps.executeUpdate();
						if(result>0){
							Query ="DELETE FROM VOICEMAIL WHERE ID='"+mailId+"'";
							System.out.println(Query);
							ps = conn.prepareStatement(Query);
							result=ps.executeUpdate();
							if(result>0){
								conn.commit();
								conn.setAutoCommit(true);
								return true;
							}
							else{
								conn.rollback();
								conn.setAutoCommit(true);
							}
						}
					}
				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;

	}
	
	public ArrayList<VoiceMail> getAllVoiceMailsForSpecificUser(String userId,int jtStartIndex, int jtPageSize, String jtSorting)throws ClassNotFoundException,SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<VoiceMail> listOfVoiceMails = new ArrayList<VoiceMail>();
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, uName, pwd);
		String Query ="SELECT A.ID,A.FROMUSER,A.TOUSER,A.MAILTIME,A.VOICEMAIL FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM VOICEMAIL C, (SELECT @ROWNUM:=0)R WHERE TOUSER='"+userId+"' AND ID IN(SELECT ID FROM VOICEMAILSTATUS WHERE  DELETEDBYRECIEVER='false')  ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
		System.out.println(Query);
		ps = conn.prepareStatement(Query);
		ResultSet resultSet = ps.executeQuery();
		while (resultSet.next())
		{
			VoiceMail message = new VoiceMail();
			message.setVoiceMailId(resultSet.getString(1));
			message.setFromUser(resultSet.getString(2));
			message.setToUser(resultSet.getString(3));
			message.setTimeOfMail(resultSet.getString(4));
			message.setVoiceMail(resultSet.getBytes(5));
			listOfVoiceMails.add(message);
		}
		return listOfVoiceMails;

	}
	public ArrayList<VoiceMail> getAllVoiceMailsForSpecificUser(String userId,int jtStartIndex, int jtPageSize, String jtSorting,String searchBy)throws ClassNotFoundException,SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<VoiceMail> listOfVoiceMails = new ArrayList<VoiceMail>();
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, uName, pwd);
		String Query ="SELECT A.ID,A.FROMUSER,A.TOUSER,A.MAILTIME,A.VOICEMAIL FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM VOICEMAIL C, (SELECT @ROWNUM:=0)R WHERE TOUSER='"+userId+"' AND ID IN(SELECT ID FROM VOICEMAILSTATUS WHERE STATUS='"+searchBy+"' AND DELETEDBYRECIEVER='false')  ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
		System.out.println(Query);
		ps = conn.prepareStatement(Query);
		ResultSet resultSet = ps.executeQuery();
		while (resultSet.next())
		{
			VoiceMail message = new VoiceMail();
			message.setVoiceMailId(resultSet.getString(1));
			message.setFromUser(resultSet.getString(2));
			message.setToUser(resultSet.getString(3));
			message.setTimeOfMail(resultSet.getString(4));
			message.setVoiceMail(resultSet.getBytes(5));
			listOfVoiceMails.add(message);
		}
		return listOfVoiceMails;

	}
	
	public ArrayList<VoiceMail> getAllVoiceMailsSentBySpecificUser(String userId,int jtStartIndex, int jtPageSize, String jtSorting)throws ClassNotFoundException,SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<VoiceMail> listOfVoiceMails = new ArrayList<VoiceMail>();
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, uName, pwd);
		String Query ="SELECT A.ID,A.FROMUSER,A.TOUSER,A.MAILTIME,A.VOICEMAIL FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM VOICEMAIL C, (SELECT @ROWNUM:=0)R WHERE FROMUSER='"+userId+"' AND ID IN(SELECT ID FROM VOICEMAILSTATUS WHERE  DELETEDBYSENDER='false')  ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
		System.out.println(Query);
		ps = conn.prepareStatement(Query);
		ResultSet resultSet = ps.executeQuery();
		while (resultSet.next())
		{
			VoiceMail message = new VoiceMail();
			message.setVoiceMailId(resultSet.getString(1));
			message.setFromUser(resultSet.getString(2));
			message.setToUser(resultSet.getString(3));
			message.setTimeOfMail(resultSet.getString(4));
			message.setVoiceMail(resultSet.getBytes(5));
			listOfVoiceMails.add(message);
		}
		return listOfVoiceMails;

	}
	public ArrayList<VoiceMail> getAllVoiceMailsSentBySpecificUser(String userId,int jtStartIndex, int jtPageSize, String jtSorting,String searchBy,String filterVal)throws ClassNotFoundException,SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ArrayList<VoiceMail> listOfVoiceMails = new ArrayList<VoiceMail>();
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, uName, pwd);
		String Query ="SELECT A.ID,A.FROMUSER,A.TOUSER,A.MAILTIME,A.VOICEMAIL FROM(SELECT @ROWNUM:=@ROWNUM+1 ROW, C.* FROM VOICEMAIL C, (SELECT @ROWNUM:=0)R WHERE FROMUSER='"+userId+"' AND ID IN(SELECT ID FROM VOICEMAILSTATUS WHERE DELETEDBYSENDER='false')AND DATEDIFF(MAILTIME,'"+filterVal+"')=0  ORDER BY "+jtSorting +" )A WHERE A.ROW>"+jtStartIndex+" and A.ROW<="+(jtPageSize+jtStartIndex);
		System.out.println(Query);
		ps = conn.prepareStatement(Query);
		ResultSet resultSet = ps.executeQuery();
		while (resultSet.next())
		{
			VoiceMail message = new VoiceMail();
			message.setVoiceMailId(resultSet.getString(1));
			message.setFromUser(resultSet.getString(2));
			message.setToUser(resultSet.getString(3));
			message.setTimeOfMail(resultSet.getString(4));
			message.setVoiceMail(resultSet.getBytes(5));
			listOfVoiceMails.add(message);
		}
		return listOfVoiceMails;
	}
	
	public int getInboxMailCount(String userID) throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM VOICEMAIL WHERE ID IN (SELECT ID FROM VOICEMAILSTATUS WHERE DELETEDBYRECIEVER='false') AND TOUSER='"+userID+"'");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}

	public int getInboxMailCount(String userID,String filterField) throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM VOICEMAIL WHERE ID IN (SELECT ID FROM VOICEMAILSTATUS WHERE DELETEDBYRECIEVER='false' AND STATUS='"+filterField+"')AND TOUSER='"+userID+"'");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}
	
	public int getOutboxMailCount(String userID) throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM VOICEMAIL WHERE ID IN (SELECT ID FROM VOICEMAILSTATUS WHERE DELETEDBYSENDER='false') AND FROMUSER='"+userID+"'");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}

	public int getOutboxMailCount(String userID,String filterField) throws ClassNotFoundException, SQLException 
	{
		Connection conn=null;
		PreparedStatement ps=null;
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url, uName, pwd);
		ps=conn.prepareStatement("SELECT Count(*) AS COUNT FROM VOICEMAIL WHERE ID IN (SELECT ID FROM VOICEMAILSTATUS WHERE DELETEDBYSENDER='false')AND FROMUSER='"+userID+"' AND ID IN(SELECT ID FROM VOICEMAILSTATUS WHERE DELETEDBYSENDER='false')AND DATEDIFF(MAILTIME,'"+filterField+"')=0 ");
		ResultSet resultSet=ps.executeQuery();
		resultSet.next();
		int count=resultSet.getInt("COUNT");
		conn.close();
		return count;
	}
	
	public ArrayList<String> getDataForAutoComplete(String filter) {
		ArrayList<String> userList= new ArrayList<String>();
		Connection conn=null;
		PreparedStatement ps=null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			String Query = "SELECT DISTINCT PRIVATEIDENTITY FROM REGISTRATIONTABLE WHERE PRIVATEIDENTITY like '%"+filter+"%'";
			System.out.println(Query);
			ps = conn.prepareStatement(Query);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				userList.add(resultSet.getString(1));
			}
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				conn.close();
			}catch (SQLException e) {e.printStackTrace();}
		}
		return userList;
	}

	public boolean updateReadStatus(String voiceMailId, String userId) {
		int resultOfUpdate = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		voiceMailId=voiceMailId.replaceAll(".wav", "");
		System.out.println(voiceMailId);
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uName, pwd);
			
			String Query ="UPDATE VOICEMAILSTATUS SET STATUS='READ' WHERE ID='"+voiceMailId+"' AND ID NOT IN (SELECT ID FROM VOICEMAIL WHERE FROMUSER='"+userId+"')";
			System.out.println(Query);
			ps=conn.prepareStatement(Query);
			resultOfUpdate=ps.executeUpdate();
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				conn.close();
			}catch (SQLException e) {e.printStackTrace();}
		}
		return resultOfUpdate>0?true:false;
	}

}
