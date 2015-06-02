/**
 * Contains AspectJ aspects that call Apache Commons Logging methods,
 * and the special-purpose classes they use.
 * 
 * <p>The aspects are designed to automatically apply to any appropriately-annotated
 * type or member declaration, so clients of this library shouldn't need to interact
 * with AspectJ at all except by invoking ajc instead of javac.</p>
 */
package com.github.aidanPB.aspects.logging;