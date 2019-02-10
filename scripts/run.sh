#!/bin/bash

#@echo off
rm -rf active-policies/*

echo "Copying policy $1-policy.xml..."
#rem >nul 2>&1

cp -f "policies+requests/$1-policy.xml" active-policies 
#rem >nul 2>&1

java -classpath "../target/classes:../target/dependency/*" my.test.balana.App -I$1 -Pactive-policies "policies+requests/$1-xacml-request.xml" "policies+requests/$1-xacml-response.xml" 
#rem 2>nul
