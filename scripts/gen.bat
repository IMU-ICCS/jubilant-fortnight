@echo off
java -classpath templates gen %1 templates\%2-req-head.txt templates\%2-req-iter.txt templates\%2-req-tail.txt > policies+requests-%2\%2-%1-xacml-request.xml
java -classpath templates gen %1 templates\%2-pol-head.txt templates\%2-pol-iter.txt templates\%2-pol-tail.txt > policies+requests-%2\%2-%1-policy.xml