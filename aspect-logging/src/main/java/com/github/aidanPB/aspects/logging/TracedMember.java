package com.github.aidanPB.aspects.logging;

import java.lang.annotation.*;

/**
 * A flag annotation indicating that the annotated constructor or method
 * should be logged to a much finer degree than usual.
 * <p>This annotation doesn't actually do anything unless it's annotating
 * a &commat;{@linkplain LoggedMember} constructor or method, or a member
 * of a &commat;{@linkplain Logged} type.</p>
 * <p>The mechanism that looks for this annotation actually resides in a
 * separate jarfile, so as to make it easy to take resource-intensive
 * tracing out of production/distribution versions of the code.</p>
 * @author aidanPB
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(value={ElementType.CONSTRUCTOR, ElementType.METHOD})
public @interface TracedMember {

	LogLevel logLevel() default LogLevel.DEBUG;
}
