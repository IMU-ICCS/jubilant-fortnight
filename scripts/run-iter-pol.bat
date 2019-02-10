@echo off

rem Usage:
rem   run-iter-pol.bat  <ITERATIONS>  <DELAY-between-iteration-in-seconds>  <EVAL-iteration>  <UC-id-num>  <num-of-policies>
rem Example:
rem   run-iter-pol.bat  10  5  10  POL  100

set ACTIVE_DIR=active-policies
set JAVA_START_DELAY=5
set PREC=3

if "%SRC_DIR%"=="" (
	set SRC_DIR=policies+requests-POL
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
rem del /Q %ACTIVE_DIR%\* 

rem copy UC policy to active-policies directory
echo Copying %2 %1 policies...
set /a end=%2-1
for /l %%i in (0,1,%end%) do (
	copy /Y "%SRC_DIR%\%1-policy-%%i.xml" %ACTIVE_DIR%  >nul 2>&1
)

rem CALL java "iterations" times - Ignore STDERR
for /l %%i in (1,1,%iterations%) do (
	echo Iteration %%i
	java -classpath "..\target\classes;..\target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -c%PREC% -I%1 -P%ACTIVE_DIR% "%SRC_DIR%\%1-%2-xacml-request.xml" "%SRC_DIR%\%1-%2-xacml-response.xml" 2>nul
	echo.
	timeout /T %iteration_delay% /NOBREAK >nul
)
