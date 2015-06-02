package com.github.aidanPB.aspects.logging;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public abstract privileged aspect AbstractMemberLoggerAspect pertypewithin(*) {

	public pointcut loggedNoArgConstructorCall() : call(@LoggedMember !@RethrowExceptions *.new());
	public pointcut loggedSingleArgConstructorCall(Object arg) :
		call(@LoggedMember !@RethrowExceptions *.new(..)) && args(arg) && if(!arg.getClass().isArray());
	public pointcut loggedVarargArrayConstructorCall(Object[] args) :
		(call(@LoggedMember !@RethrowExceptions *.new(*...))
				|| call(@LoggedMember !@RethrowExceptions *.new(*[]))) && args(args);
	public pointcut loggedNoArgMethodCall() : call(@LoggedMember !@RethrowExceptions * *.*());
	public pointcut loggedSingleArgMethodCall(Object arg) :
		call(@LoggedMember !@RethrowExceptions * *.*(..)) && args(arg) && if(!arg.getClass().isArray());
	public pointcut loggedVarargArrayMethodCall(Object[] args) :
		(call(@LoggedMember !@RethrowExceptions * *.*(*...))
				|| call(@LoggedMember !@RethrowExceptions * *.*(*[]))) && args(args);
	public pointcut rethrowingConstructorCall() : call(@LoggedMember @RethrowExceptions *.new(..));
	public pointcut rethrowingMethodCall() : call(@LoggedMember @RethrowExceptions * *.*(..));
	protected pointcut anySimpleCall() :
		loggedNoArgConstructorCall() || loggedSingleArgConstructorCall(Object)
		|| loggedVarargArrayConstructorCall(Object[]) || loggedNoArgMethodCall()
		|| loggedSingleArgMethodCall(Object) || loggedVarargArrayMethodCall(Object[])
		|| rethrowingConstructorCall() || rethrowingMethodCall();
	
	public pointcut loggedNoArgConstructorExec() : execution(@LoggedMember !@RethrowExceptions *.new());
	public pointcut loggedSingleArgConstructorExec(Object arg) :
		execution(@LoggedMember !@RethrowExceptions *.new(..)) && args(arg) && if(!arg.getClass().isArray());
	public pointcut loggedVarargArrayConstructorExec(Object[] args) :
		(execution(@LoggedMember !@RethrowExceptions *.new(*...))
				|| execution(@LoggedMember !@RethrowExceptions *.new(*[]))) && args(args);
	public pointcut loggedNoArgMethodExec() : execution(@LoggedMember !@RethrowExceptions * *.*());
	public pointcut loggedSingleArgMethodExec(Object arg) :
		execution(@LoggedMember !@RethrowExceptions * *.*(..)) && args(arg) && if(!arg.getClass().isArray());
	public pointcut loggedVarargArrayMethodExec(Object[] args) :
		(execution(@LoggedMember !@RethrowExceptions * *.*(*...))
				|| execution(@LoggedMember !@RethrowExceptions * *.*(*[]))) && args(args);
	public pointcut rethrowingConstructorExec() : execution(@LoggedMember @RethrowExceptions *.new(..));
	public pointcut rethrowingMethodExec() : execution(@LoggedMember @RethrowExceptions * *.*(..));
	protected pointcut anySimpleExecution() :
		loggedNoArgConstructorExec() || loggedSingleArgConstructorExec(Object)
		|| loggedVarargArrayConstructorExec(Object[]) || loggedNoArgMethodExec()
		|| loggedSingleArgMethodExec(Object) || loggedVarargArrayMethodExec(Object[])
		|| rethrowingConstructorExec() || rethrowingMethodExec();
	
	/**
	 * The yendor pointcuts are so named because, like The Amulet of Yendor from NetHack,
	 * they can't be put into "containers".
	 */
	public pointcut yendorConstructorExec() :
		execution(@LoggedMember !@RethrowExceptions *.new(..)) && !args() && !args(*)
		&& !args(Object+[]) && !args(boolean[]) && !args(char[]) && !args(short[]) && !args(int[])
		&& !args(long[]) && !args(float[]) && !args(double[]);
	public pointcut yendorMethodExec() :
		execution(@LoggedMember !@RethrowExceptions * *.*(..)) && !args() && !args(*)
		&& !args(Object+[]) && !args(boolean[]) && !args(char[]) && !args(short[]) && !args(int[])
		&& !args(long[]) && !args(float[]) && !args(double[]);
	protected pointcut anyYendorExec() : yendorConstructorExec() || yendorMethodExec();
	
	protected pointcut anyPointcut() : anySimpleExecution() || anyYendorExec();
	
	protected Log typeLog = null;
	protected boolean uninitialized = true;
	
	before() : anyPointcut() {
		if(uninitialized || typeLog == null){
			typeLog = LogFactory.getLog(thisJoinPointStaticPart.getSignature().getDeclaringType());
			uninitialized = false;
		}
	}
}
