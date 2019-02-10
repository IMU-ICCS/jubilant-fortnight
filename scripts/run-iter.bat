@echo off

rem Usage:
rem   run-iter.bat  <ITERATIONS>  <DELAY-between-iteration-in-seconds>  <EVAL-iterations>  <UC-id-num> 
rem Example:
rem   run-iter.bat  10  5  10  CE-10

set ACTIVE_DIR=active-policies
set JAVA_START_DELAY=5
set PREC=3

if "%SRC_DIR%"=="" (
	set SRC_DIR=policies+requests
)

rem GET number of Iterations
set iterations=%1
shift

rem GET delay between iterations
set iteration_delay=%1
shift

rem GET evaluation iterations (nternal to java app)
set EVAL_ITER=%1
shift

rem clear active-policies directory
del /Q %ACTIVE_DIR%\* 

rem copy UC policy to active-policies directory
echo Copying policy %SRC_DIR%\%1-policy.xml...
copy /Y "%SRC_DIR%\%1-policy.xml" %ACTIVE_DIR%

rem CALL java "iterations" times - Ignore STDERR
for /l %%i in (1,1,%iterations%) do (
	echo Iteration %%i
	java -classpath "..\target\classes;..\target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -c%PREC% -I%1 -P%ACTIVE_DIR% "%SRC_DIR%\%1-xacml-request.xml" "%SRC_DIR%\%1-xacml-response.xml" 2>nul
	echo.
	timeout /T %iteration_delay% /NOBREAK >nul
)
