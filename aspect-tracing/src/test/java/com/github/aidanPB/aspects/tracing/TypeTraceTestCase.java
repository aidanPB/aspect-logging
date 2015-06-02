package com.github.aidanPB.aspects.tracing;

import com.github.aidanPB.aspects.logging.Logged;
import com.github.aidanPB.aspects.logging.LogLevel;
import com.github.aidanPB.aspects.logging.RethrowExceptions;
import com.github.aidanPB.aspects.logging.TracedMember;

@Logged
public class TypeTraceTestCase {

	@TracedMember
	public TypeTraceTestCase(){
		super();
	}
	
	public void doNothing(){
		return;
	}
	
	@RethrowExceptions
	public void throwException(){
		throw new UnsupportedOperationException("This exception deliberately thrown.");
	}
	
	@TracedMember
	public void tracedMethod(){
		doNothing();
	}
	
	@TracedMember(logLevel=LogLevel.WARN)
	public void warnTracedMethod(){
		tracedMethod();
		throwException();
	}
	
	public static void main(String... args) {
		System.out.println("Beginning test case...");
		TypeTraceTestCase tttc = new TypeTraceTestCase();
		tttc.warnTracedMethod();
		System.out.println("Finished with test case.");
	}
}
