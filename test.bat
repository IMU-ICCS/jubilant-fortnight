@echo off

set TEST_ID=test
set NUM_OF_WORKERS=1
set JAVA_START_DELAY=0
set EVAL_ITER=100000
set PREC=3
set ACTIVE_DIR=policies
set REQ_FILE=.\requests\SimpleRequest.xml
set RESP_FILE=.\Response.xml

java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%" 
rem 2>nul

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=10
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=100
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=200
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=300
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=400
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=500
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=600
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=700
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=800
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=900
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

echo -------------------------------------------------------------------
set NUM_OF_WORKERS=1000
java -classpath "target\classes;target\dependency\*" my.test.balana.App -D%JAVA_START_DELAY% -R%EVAL_ITER% -W%NUM_OF_WORKERS% -c%PREC% -I%TEST_ID% -P%ACTIVE_DIR% "%REQ_FILE%" "%RESP_FILE%"

date /T
time /T