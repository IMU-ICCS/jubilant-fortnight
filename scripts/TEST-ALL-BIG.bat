@echo off
setlocal

set SRC_DIR=policies+requests-CE
rem del /Q policies+requests-CE\*response.xml
time /T
echo -----------------------------------------------------------------------------
call run-iter.bat 10 5 10 CE-10000	> outputs\CE-10000-output.txt
echo -----------------------------------------------------------------------------
rem call run-iter.bat 5 5 10 CE-50000	> outputs\CE-50000-output.txt
rem echo -----------------------------------------------------------------------------
rem call run-iter.bat 1 5 10 CE-100000	> outputs\CE-100000-output.txt
rem echo -----------------------------------------------------------------------------
time /T

rem ==================================================================================

set SRC_DIR=policies+requests-RULE
rem del /Q policies+requests-RULE\*response.xml
time /T
echo -----------------------------------------------------------------------------
call run-iter.bat 10 5 10 RULE-10000	> outputs\RULE-10000-output.txt
echo -----------------------------------------------------------------------------
rem call run-iter.bat 5 5 10 RULE-50000	> outputs\RULE-50000-output.txt
rem echo -----------------------------------------------------------------------------
rem call run-iter.bat 1 5 10 RULE-100000	> outputs\RULE-100000-output.txt
rem echo -----------------------------------------------------------------------------
time /T

rem ==================================================================================

set SRC_DIR=policies+requests-POL
rem del /Q policies+requests-POL\*response.xml
del /Q active-policies\*
time /T
echo -----------------------------------------------------------------------------
call run-iter-pol.bat 10 5 10 POL 10000	> outputs\POL-10000-output.txt
echo -----------------------------------------------------------------------------
time /T

rem ==================================================================================

set SRC_DIR=policies+requests-CE
rem del /Q policies+requests-CE\*response.xml
time /T
echo -----------------------------------------------------------------------------
call run-iter.bat 5 5 10 CE-50000	> outputs\CE-50000-output.txt
echo -----------------------------------------------------------------------------
rem call run-iter.bat 1 5 10 CE-100000	> outputs\CE-100000-output.txt
rem echo -----------------------------------------------------------------------------
time /T

rem ==================================================================================

set SRC_DIR=policies+requests-RULE
rem del /Q policies+requests-RULE\*response.xml
time /T
echo -----------------------------------------------------------------------------
call run-iter.bat 5 5 10 RULE-50000	> outputs\RULE-50000-output.txt
echo -----------------------------------------------------------------------------
rem call run-iter.bat 1 5 10 RULE-100000	> outputs\RULE-100000-output.txt
rem echo -----------------------------------------------------------------------------
time /T

set SRC_DIR=policies+requests-RULE
rem del /Q policies+requests-RULE\*response.xml
time /T
echo -----------------------------------------------------------------------------
call run-iter.bat 5 5 1000 RULE-50000	> outputs\RULE-50000-output.txt
echo -----------------------------------------------------------------------------
rem call run-iter.bat 1 5 10 RULE-100000	> outputs\RULE-100000-output.txt
rem echo -----------------------------------------------------------------------------
time /T

endlocal