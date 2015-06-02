# aspect-logging
### Logging with AspectJ.
These aspects and annotations are intended to ease logging. The intent is to make logging as simple as:

1. Annotate classes with `@Logged` or methods/constructors with `@LoggedMember`,
2. Have aspect-logging.jar on the classpath,
3. Compile with ajc instead of javac, and
4. Logs will happen.
