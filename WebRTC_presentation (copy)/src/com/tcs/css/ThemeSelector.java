package com.tcs.css;

import java.util.HashMap;
import java.util.Map;

public class ThemeSelector {

	public String getTheme(String themeName){
		Themes th=new Themes();
		String selectedTheme=null;
		//System.out.println(themeName);
		
		Map<String, String> theme=new HashMap<String, String>();
		theme=Themes.getTheme();
	
		selectedTheme=theme.get(themeName);
		//System.out.println(selectedTheme);
		
		if(selectedTheme.equalsIgnoreCase(null)){
			selectedTheme="style.css";
		}
		//System.out.println(selectedTheme);
		return selectedTheme;
	}



}
