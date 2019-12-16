package com.tcs.webrtc.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Comparing {
	
	public static void main(String[] args) {
		
		List<String> aList = new ArrayList<String>();
		aList.add("a");
		aList.add("b");
		aList.add("c");
		aList.add("d");
		aList.add("e");

		List<String> bList = new ArrayList<String>();
		bList.add("b");
		bList.add("e");
		bList.add("d");

		aList.removeAll(bList);
		
		//aList.retainAll(bList);
		
		Iterator<String> iterator = aList.iterator();
		
		while(iterator.hasNext())
		{
			System.out.println(iterator.next());
		}
		
		
		
	}

}
