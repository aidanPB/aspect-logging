package com.github.aidanPB.aspects.tracing;

import com.github.aidanPB.aspects.logging.AbstractTypeLoggerAspect;
import com.github.aidanPB.aspects.logging.LogLevel;
import com.github.aidanPB.aspects.logging.TracedMember;

public aspect TypeTraceLogger extends AbstractTypeLoggerAspect {

	pointcut tracedMethodExec(TracedMember tm) : execution(@TracedMember * *.*(..)) && @annotation(tm);
	pointcut tracedConstructorExec(TracedMember tm) :
		execution(@TracedMember *.new(..)) && @annotation(tm);
	
	before(TracedMember tm) : tracedMethodExec(tm) || tracedConstructorExec(tm) {
		String message = "Entering method or constructor with signature: "
				+ thisJoinPointStaticPart.getSignature().toString();
		LogLevel lev = tm.logLevel();
		switch(lev){
		case DEBUG:
			typeLog.debug(message);
			break;
		case TRACE:
			typeLog.trace(message);
			break;
		case ERROR:
			typeLog.error(message);
			break;
		case FATAL:
			typeLog.fatal(message);
			break;
		case INFO:
			typeLog.info(message);
			break;
		case WARN:
			typeLog.warn(message);
			break;
		}
	}
	
	after(TracedMember tm) : tracedMethodExec(tm) || tracedConstructorExec(tm) {
		String message = "Leaving method or constructor with signature: "
				+ thisJoinPointStaticPart.getSignature().toString();
		LogLevel lev = tm.logLevel();
		switch(lev){
		case DEBUG:
			typeLog.debug(message);
			break;
		case TRACE:
			typeLog.trace(message);
			break;
		case ERROR:
			typeLog.error(message);
			break;
		case FATAL:
			typeLog.fatal(message);
			break;
		case INFO:
			typeLog.info(message);
			break;
		case WARN:
			typeLog.warn(message);
			break;
		}
	}
}
