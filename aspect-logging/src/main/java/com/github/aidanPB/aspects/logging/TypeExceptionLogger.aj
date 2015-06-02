package com.github.aidanPB.aspects.logging;

public privileged aspect TypeExceptionLogger extends AbstractTypeLoggerAspect {

	pointcut simpleGetterExecution() :
		execution(!@RethrowExceptions * *.get*()) ||
		execution(!@RethrowExceptions * *.to*());
	pointcut indexedGetterExecution(int i) :
		(execution(!@RethrowExceptions * *.get*(int)) || 
		execution(!@RethrowExceptions * *.to*(int))) && args(i);
	pointcut mappedGetterExecution(String key) :
		(execution(!@RethrowExceptions * *.get*(String)) ||
		execution(!@RethrowExceptions * *.to*(String))) && args(key);
	pointcut anyGetterExecution() : simpleGetterExecution() || indexedGetterExecution(int)
			|| mappedGetterExecution(String);
	
	pointcut anyNoArgMethodExec() : execution(!@RethrowExceptions * *.*());
	
	pointcut simpleSetterExecution(Object value) :
		execution(!@RethrowExceptions void *.set*(*)) && args(value);
	pointcut fluentSimpleSetter(Object value) :
		execution(!@RethrowExceptions !void *.set*(*)) && args(value);
	pointcut indexedSetterExecution(int i, Object value) :
		execution(!@RethrowExceptions void *.set*(int, *)) && args(i, value);
	pointcut fluentIndexedSetter(int i, Object value) :
		execution(!@RethrowExceptions !void *.set*(int, *)) && args(i, value);
	pointcut mappedSetterExecution(String key, Object value) :
		execution(!@RethrowExceptions void *.set*(String, *)) && args(key, value);
	pointcut fluentMappedSetter(String key, Object value) :
		execution(!@RethrowExceptions !void *.set*(String, *)) && args(key, value);
	pointcut anySetterExecution() : simpleSetterExecution(Object)
			|| indexedSetterExecution(int, Object) || mappedSetterExecution(String, Object)
			|| fluentSimpleSetter(Object) || fluentIndexedSetter(int, Object)
			|| fluentMappedSetter(String, Object);
	
	pointcut noArgConstructorExecution() : execution(!@RethrowExceptions *.new());
	
	pointcut nonBeanExecution() : (execution(* *.*(..)) || execution(*.new(..))) &&
			!(anyGetterExecution() || anySetterExecution() || noArgConstructorExecution());
	
	Object around() : anyNoArgMethodExec() {
		try{
			return proceed();
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	Object around(int i) : indexedGetterExecution(i) {
		try{
			return proceed(i);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	Object around(String key) : mappedGetterExecution(key) {
		try{
			return proceed(key);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	void around(Object value) : simpleSetterExecution(value) {
		try{
			proceed(value);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
		}
	}
	
	void around(int i, Object value) : indexedSetterExecution(i, value) {
		try{
			proceed(i, value);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
		}
	}
	
	void around(String key, Object value) : mappedSetterExecution(key, value) {
		try{
			proceed(key, value);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
		}
	}
	
	Object around(Object value) : fluentSimpleSetter(value) {
		try{
			return proceed(value);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	Object around(int i, Object value) : fluentIndexedSetter(i, value) {
		try{
			return proceed(i, value);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	Object around(String key, Object value) : fluentMappedSetter(key, value) {
		try{
			return proceed(key, value);
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	Object around() : noArgConstructorExecution() {
		try{
			return proceed();
		}catch(Exception e){
			typeLog.error("Exception at join point signature " +
					thisJoinPointStaticPart.getSignature().toString() + ".", e);
			return null;
		}
	}
	
	after() throwing(Exception e) : nonBeanExecution() {
		typeLog.error("Exception at join point signature " +
				thisJoinPointStaticPart.getSignature().toString() + ".", e);
	}
}
