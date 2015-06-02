package com.github.aidanPB.aspects.logging;

import java.lang.annotation.*;

/**
 * A flag annotation indicating to this library's aspects that
 * the annotated field, method, or constructor should be logged.
 * &commat;{@linkplain Logged} and &commat;LoggedMember turn on
 * basic, everyday logging that should be present even in production
 * code.
 * @author aidanPB
 */
@Target(value={ElementType.METHOD, ElementType.CONSTRUCTOR, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface LoggedMember {

}
