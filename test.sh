#!/usr/bin/env bash

TEST_ID=test
NUM_OF_WORKERS=1
JAVA_START_DELAY=0
EVAL_ITER=100000
PREC=3
ACTIVE_DIR=policies/POL-10-test-policies
#ACTIVE_DIR=policies/POL-10-test-policies
REQ_FILE=./requests/SimpleRequest.xml
RESP_FILE=./Response.xml

date
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE" 
rem 2>nul

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=10
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=100
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=200
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=300
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=400
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=500
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=600
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=700
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=800
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=900
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

echo -------------------------------------------------------------------
date
set NUM_OF_WORKERS=1000
java -classpath "target/classes:target/dependency/*" my.test.balana.App -D$JAVA_START_DELAY -R$EVAL_ITER -W$NUM_OF_WORKERS -c$PREC -I$TEST_ID -P$ACTIVE_DIR "$REQ_FILE" "$RESP_FILE"

date
