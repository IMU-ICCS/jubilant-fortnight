@echo off

set /a end=%1-1
for /l %%i in (0,1,%end%) do (
	java -classpath templates gen %%i templates\%2-pol-head.txt templates\%2-pol-iter.txt templates\%2-pol-tail.txt > policies+requests-POL\%2-policy-%%i.xml
)
