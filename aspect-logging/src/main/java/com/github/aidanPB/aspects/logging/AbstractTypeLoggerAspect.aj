package com.github.aidanPB.aspects.logging;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public abstract privileged aspect AbstractTypeLoggerAspect pertypewithin(@Logged *) {
	
	protected Log typeLog;

	pointcut staticInit() : staticinitialization(@Logged *);
	
	before() : staticInit() {
		typeLog = LogFactory.getLog(thisJoinPointStaticPart.getSignature().getDeclaringType());
	}
}
