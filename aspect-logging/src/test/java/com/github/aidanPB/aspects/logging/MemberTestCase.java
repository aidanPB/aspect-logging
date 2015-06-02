package com.github.aidanPB.aspects.logging;

public class MemberTestCase {

	private int count;
	private String message;
	
	@LoggedMember
	MemberTestCase(int count){
		this.count = count;
	}
	
	@LoggedMember
	@RethrowExceptions
	MemberTestCase(int count, String message){
		this.count = count;
		this.message = message;
	}
	
	@LoggedMember
	int getCount(){
		return count;
	}
	
	@LoggedMember
	void printMessage(){
		System.out.println(message);
	}
	
	@LoggedMember
	void setFields(int count, String message){
		this.count = count;
		this.message = message;
	}
	
	@LoggedMember
	public static void main(String... args){
		System.out.println("Constructing two MemberTestCases...");
		MemberTestCase m1 = new MemberTestCase(42);
		MemberTestCase m2 = new MemberTestCase(21, "Hello World!");
		System.out.println("The value of m1.count is: " + String.valueOf(m1.getCount()));
		System.out.println("Printing m2.message...");
		m2.printMessage();
	}
}
