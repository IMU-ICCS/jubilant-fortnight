#!/bin/bash

#@echo off
#setlocal

SRC_DIR=policies+requests-CE
export SRC_DIR
echo "SRC_DIR=$SRC_DIR"
# rm -rf policies+requests-CE/*response.xml
date
echo -----------------------------------------------------------------------------
./run-iter.sh 5 5 100 CE-10000		> outputs/CE-10000-output.txt
echo -----------------------------------------------------------------------------
# ./run-iter.sh 5 5 10 CE-50000		> outputs/CE-50000-output.txt
# echo -----------------------------------------------------------------------------
# ./run-iter.sh 1 5 10 CE-100000	> outputs/CE-100000-output.txt
# echo -----------------------------------------------------------------------------
date

# ==================================================================================

SRC_DIR=policies+requests-RULE
export SRC_DIR
echo "SRC_DIR=$SRC_DIR"
# rm -rf policies+requests-RULE/*response.xml
date
echo -----------------------------------------------------------------------------
./run-iter.sh 5 5 100 RULE-10000	> outputs/RULE-10000-output.txt
echo -----------------------------------------------------------------------------
# ./run-iter.sh 5 5 10 RULE-50000	> outputs/RULE-50000-output.txt
# echo -----------------------------------------------------------------------------
# ./run-iter.sh 1 5 10 RULE-100000	> outputs/RULE-100000-output.txt
# echo -----------------------------------------------------------------------------
date

# ==================================================================================

SRC_DIR=policies+requests-POL
export SRC_DIR
echo "SRC_DIR=$SRC_DIR"
# rm -rf policies+requests-POL/*response.xml
rm -rf active-policies/*
date
echo -----------------------------------------------------------------------------
./run-iter-pol.sh 5 5 100 POL 10000	> outputs/POL-10000-output.txt
echo -----------------------------------------------------------------------------
date

#endlocal
