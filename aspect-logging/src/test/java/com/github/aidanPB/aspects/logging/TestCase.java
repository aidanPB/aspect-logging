package com.github.aidanPB.aspects.logging;

import java.util.HashMap;

@Logged
public class TestCase {

	String thisAsString;
	int count, distance;
	int[] sizes;
	String[] ordinals;
	HashMap<String, String> longStrings;
	HashMap<String, Object> namedItem;
	
	public TestCase(){
		count = 0;
		distance = 0;
		sizes = new int[]{1, 2, 3, 4, 5, 6};
		ordinals = new String[]{"zeroth", "first", "second", "third", "fourth", "fifth"};
		longStrings = new HashMap<String, String>();
		longStrings.put(ordinals[0], "Computers start counting at zero.");
		longStrings.put(ordinals[1], "A Partridge");
		longStrings.put(ordinals[2], "Two Turtledoves");
		longStrings.put(ordinals[3], "Three French Hens");
		namedItem = new HashMap<String, Object>();
		thisAsString = this.toString();
	}
	
	public void setCount(int count){
		this.count = count;
	}
	
	public int getCount(){
		return count;
	}
	
	public int setDistance(int distance){
		int scratch = this.distance;
		this.distance = distance;
		return scratch;
	}
	
	public int setSize(int i, int size){
		int scratch = sizes[i];
		sizes[i] = size;
		return scratch;
	}
	
	public void setOrdinal(int i, String value){
		ordinals[i] = value;
	}
	
	public String getOrdinal(int i){
		return ordinals[i];
	}
	
	public String setLongString(String key, String value){
		return longStrings.put(key, value);
	}
	
	public String getLongString(String key){
		return longStrings.get(key);
	}
	
	public Object getNamedItem(String key){
		return namedItem.get(key);
	}
	
	public void setNamedItem(String key, Object item){
		namedItem.put(key, item);
	}
	
	public int toInt(){
		//obvious source of exceptions is obvious
		return Integer.parseInt(thisAsString);
	}
	
	@RethrowExceptions
	public int toIntNoisily(){
		//obvious source of exceptions is obvious
		return Integer.parseInt(thisAsString);
	}
	
	public static void main(String[] args) {
		System.out.println("Constructing TestCase tc...");
		TestCase tc = new TestCase();
		System.out.println("The value of tc as an integer is: " + tc.toInt());
		try{
			System.out.println("The value of tc as an integer is: " + tc.toIntNoisily());
		}catch(NumberFormatException nfe){
			System.out.println("Object tc's value as a string can't be parsed as an integer.");
		}
	}

}
