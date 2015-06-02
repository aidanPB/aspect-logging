package com.github.aidanPB.aspects.logging;

import java.lang.annotation.*;

/**
 * A flag annotation indicating that any exceptions that the annotated
 * method or constructor throws should <em>not</em> be swallowed, but
 * instead rethrown.
 * @author aidanPB
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(value={ElementType.CONSTRUCTOR, ElementType.METHOD})
public @interface RethrowExceptions {

}
