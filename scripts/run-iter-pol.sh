#!/bin/bash

#@echo off

# Usage:
#   run-iter-pol.sh  <ITERATIONS>  <DELAY-between-iteration-in-seconds>  <EVAL-iteration>  <UC-id-num>  <num-of-policies>
# Example:
#   run-iter-pol.sh  10  5  10  POL  100

ACTIVE_DIR=active-policies
JAVA_START_DELAY=5
PREC=3

#echo "ACTIVE_DIR=$ACTIVE_DIR"
#echo "JAVA_START_DELAY=$JAVA_START_DELAY"
#echo "PREC=$PREC"

if [ -z $SRC_DIR ]; then
	SRC_DIR=policies+requests-POL
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

# clear active-policies directory
# rm -rf $ACTIVE_DIR/* 

# copy UC policy to active-policies directory
echo "Copying $2 $1 policies..."
end=$[$2 - 1]
for (( c=0; c<=$end; c++ )); do
	#echo "cp -f \"$SRC_DIR/$1-policy-$c.xml\" $ACTIVE_DIR  >nul 2>&1"
	cp -f "$SRC_DIR/$1-policy-$c.xml" $ACTIVE_DIR  >/dev/null 2>&1
done

# CALL java "iterations" times - Ignore STDERR
for (( c=1; c<=$iterations; c++ )); do
	echo Iteration $c
	date
	#echo "java -classpath \"../target/classes:../target/dependency/*\" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -c$PREC -I$1-$2 -P$ACTIVE_DIR \"$SRC_DIR/$1-$2-xacml-request.xml\" \"$SRC_DIR/$1-$2-xacml-response.xml\" "
	java -classpath "../target/classes:../target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -c$PREC "-I$1-$2" -P$ACTIVE_DIR "$SRC_DIR/$1-$2-xacml-request.xml" "$SRC_DIR/$1-$2-xacml-response.xml" 2>/dev/null
	echo .
	#timeout /T %iteration_delay% /NOBREAK >nul
	sleep $iteration_delay
done

