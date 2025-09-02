[INFO] Downloaded from central: https://repo.maven.apache.org/maven2/com/github/luben/zstd-jni/1.5.5-11/zstd-jni-1.5.5-11.jar (6.8 MB at 39 MB/s)
[INFO] There are 3 errors reported by Checkstyle 10.25.0 with src/checkstyle/nohttp-checkstyle.xml ruleset.
Error:  Docs/Logs.md:[1,149] (extension) NoHttp: http:// URLs are not allowed but got 'http://pypi.python.org/pypi/pip'. Use https:// instead.
Error:  Docs/Logs.md:[2,149] (extension) NoHttp: http:// URLs are not allowed but got 'http://pypi.python.org/pypi/setuptools'. Use https:// instead.
Error:  Docs/Logs.md:[15,19] (extension) NoHttp: http:// URLs are not allowed but got 'http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException'. Use https:// instead.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  24.594 s
[INFO] Finished at: 2025-09-02T18:57:07Z
[INFO] ------------------------------------------------------------------------
Error:  Failed to execute goal org.apache.maven.plugins:maven-checkstyle-plugin:3.6.0:check (nohttp-checkstyle-validation) on project spring-petclinic: You have 3 Checkstyle violations. -> [Help 1]
Error:  
Error:  To see the full stack trace of the errors, re-run Maven with the -e switch.
Error:  Re-run Maven using the -X switch to enable full debug logging.
Error:  
Error:  For more information about the errors and possible solutions, please read the following articles:
Error:  [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoFailureException
Error: Process completed with exit code 1.