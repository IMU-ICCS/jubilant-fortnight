@echo off

java -classpath templates gen %1 templates\%2-req-head.txt templates\%2-req-iter.txt templates\%2-req-tail.txt > policies+requests-POL\%2-%1-xacml-request.xml
