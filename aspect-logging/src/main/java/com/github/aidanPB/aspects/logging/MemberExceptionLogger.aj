package com.github.aidanPB.aspects.logging;

public aspect MemberExceptionLogger extends AbstractMemberLoggerAspect {

	before() : anyYendorExec() {
		typeLog.warn("The method or constructor with signature "
				+ thisJoinPointStaticPart.getSignature().toString() + " isn't annotated with "
				+"@RethrowExceptions, but its argument signature makes automatic handling "
				+"impossible. The application should be able to handle exceptions.");
	}

	after() throwing(Exception e) : rethrowingMethodExec() || yendorMethodExec() {
		typeLog.error("Exception thrown from method with signature: "
				+ thisJoinPointStaticPart.getSignature().toString() + ".", e);
	}
	
	after() throwing(Exception e) : rethrowingConstructorExec() || yendorConstructorExec() {
		typeLog.error("Exception thrown from constructor with signature: "
				+ thisJoinPointStaticPart.getSignature().toString() + ".", e);
	}
	
	Object around() : loggedNoArgConstructorExec() || loggedNoArgMethodExec() {
		try{
			return proceed();
		}catch(Exception e){
			typeLog.error("Exception thrown from method or constructor with signature: "
					+ thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	Object around(Object arg) : loggedSingleArgConstructorExec(arg) || loggedSingleArgMethodExec(arg) {
		try{
			return proceed(arg);
		}catch(Exception e){
			typeLog.error("Exception thrown from method or constructor with signature: "
					+ thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	Object around(Object args[]) :
		loggedVarargArrayConstructorExec(args) || loggedVarargArrayMethodExec(args) {
		try{
			return proceed(args);
		}catch(Exception e){
			typeLog.error("Exception thrown from method or constructor with signature: "
					+ thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
}
