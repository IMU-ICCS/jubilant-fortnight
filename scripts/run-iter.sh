#!/bin/bash

#@echo off

# Usage:
#   run-iter.sh  <ITERATIONS>  <DELAY-between-iteration-in-seconds>  <EVAL-iterations>  <UC-id-num> 
# Example:
#   run-iter.sh  10  5  10  CE-10

ACTIVE_DIR=active-policies
JAVA_START_DELAY=5
PREC=3

#echo "ACTIVE_DIR=$ACTIVE_DIR"
#echo "JAVA_START_DELAY=$JAVA_START_DELAY"
#echo "PREC=$PREC"

if [ -z $SRC_DIR ]; then 
	SRC_DIR=policies+requests 
fi

# GET number of Iterations
iterations=$1
shift

# GET delay between iterations
iteration_delay=$1
shift

# GET evaluation iterations (nternal to java app)
EVAL_ITER=$1
shift

#echo "iterations=$iterations"
#echo "iteration_delay=$iteration_delay"
#echo "EVAL_ITER=$EVAL_ITER"

#rem clear active-policies directory
rm -rf $ACTIVE_DIR/* 

# copy UC policy to active-policies directory
echo "Copying policy $SRC_DIR/$1-policy.xml..."
cp -f "$SRC_DIR/$1-policy.xml" $ACTIVE_DIR

# CALL java "iterations" times - Ignore STDERR
for (( c=1; c<=$iterations; c++ )); do
	echo Iteration $c
	date
	#echo "java -classpath \"../target/classes:../target/dependency/*\" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -c$PREC -I$1 -P$ACTIVE_DIR \"$SRC_DIR/$1-xacml-request.xml\" \"$SRC_DIR/$1-xacml-response.xml\" "
	java -classpath "../target/classes:../target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -c$PREC -I$1 -P$ACTIVE_DIR "$SRC_DIR/$1-xacml-request.xml" "$SRC_DIR/$1-xacml-response.xml" 2>/dev/null
	echo .
	#timeout /T %iteration_delay% /NOBREAK >nul
	sleep $iteration_delay
done

