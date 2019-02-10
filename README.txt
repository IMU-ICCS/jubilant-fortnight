
-----------
-- SETUP --
-----------

Init-DB
=======
Edit 'db.pwd' and store MySQL root password
run-example-pdp --init-db
Edit 'db.pwd' clear root password from file

Load data
=========
cd EVAL5/sql
mysql -u PaaSwordUser -p XACMLAttributes < DB-10000-inserts.sql
...Give PaaSwordUser password  (i.e. PaaSword)

Test DB setup
=============
cd ../..
run-example-pdp policies requests/CE-test-xacml-request.xml

If you get an XACML response reporting Permit
then you are ready to go!


--------------------
-- RUN EXPERIMENT --
--------------------

./TEST-ALL.sh > outputs/OUTPUT.txt 2>&1 &

./TEST-ALL-BIG.sh > outputs/OUTPUT-BIG.txt 2>&1 &


-------------
-- CLEANUP --
-------------

Clear-DB
========
Edit 'db.pwd' and store MySQL root password
run-example-pdp --clear-db
Edit 'db.pwd' clear root password from file

