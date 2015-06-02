package com.github.aidanPB.aspects.logging;

import java.lang.annotation.*;

/**
 * A flag annotation to indicate to this project's aspects
 * that the annotated type is to be logged.
 * &commat;{@linkplain LoggedMember} and &commat;Logged turn on
 * basic, everyday logging that should be present even in production
 * code.
 * @author aidanPB
 */
@Target(value={ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface Logged {

}
