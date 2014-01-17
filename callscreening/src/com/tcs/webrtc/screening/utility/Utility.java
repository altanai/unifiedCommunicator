package com.tcs.webrtc.screening.utility;

import java.text.DateFormat;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import com.tcs.webrtc.screening.bean.ScreenedUserBean;

public class Utility {
	
	public Date concatenatedTime(String time)
	{
		Date currentdate=new Date();
		Date parsedDate=null;
		DateFormat df=DateFormat.getDateInstance(DateFormat.MEDIUM);
		String dateTime=df.format(currentdate);
		System.out.println(dateTime);
		dateTime=dateTime+" "+time;
		try {
			DateFormat df1=DateFormat.getDateTimeInstance();
			 parsedDate=df1.parse(dateTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println(parsedDate.toString());
		return parsedDate;
	}
	
	public boolean chkDndValues()
	{
		boolean userIsGrey=false;
		Map<String,String> greyUser=ScreenedUserBean.getGreyUsers();
		Calendar calendar=Calendar.getInstance();
		int dayOfCall=calendar.get(Calendar.DAY_OF_WEEK);
		dayOfCall=dayOfCall-1;
		String [][] month={{"Sun_Strt","Sun_End"},{"Mon_Strt","Mon_End"},{"Tue_Strt","Tue_End"},{"Wed_Strt","Wed_End"},{"Thu_Strt","Thu_End"},{"Fri_Strt","Fri_End"},{"Sat_Strt","Sat_End"}};
		Calendar startTime=Calendar.getInstance();
		Calendar endTime=Calendar.getInstance();
		Calendar currentTime=Calendar.getInstance();
		if(!(greyUser.get(month[dayOfCall][0])==null)&&!(greyUser.get(month[dayOfCall][0]).equalsIgnoreCase(""))){
			startTime.setTime(concatenatedTime(greyUser.get(month[dayOfCall][0])));
			endTime.setTime(concatenatedTime(greyUser.get(month[dayOfCall][1])));
			if((currentTime.after(startTime))&&(currentTime.before(endTime)))
			{
				userIsGrey=true;
			}
		}
		return userIsGrey;
	}
	
	

}
