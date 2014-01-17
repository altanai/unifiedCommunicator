package com.tcs.css;

import java.util.HashMap;
import java.util.Map;

public class Themes {
	
	private static Map<String, String> theme= new HashMap<String, String>();
	
	public Themes(){
		
		theme.put("default", "style.css");
		theme.put("black", "style_black.css");
		theme.put("blue", "style_blue.css");
		
	}
	
	public static Map<String, String> getTheme() {
		return theme;
	}

	public static void setTheme(Map<String, String> theme) {
		Themes.theme = theme;
	}
		
		
		


}
