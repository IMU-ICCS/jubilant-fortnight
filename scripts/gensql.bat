@echo off

set filename=sql\DB-%1-inserts.sql

echo INSERT INTO roles (subjectId,role) > %filename%
echo VALUES >> %filename%

set /a end=%1-2
set /a end2=%1-1
setlocal EnableDelayedExpansion
for /l %%i in (0,1,%end%) do (
	set "formattedValue=000000%%i"
	set attrid=!formattedValue:~-6!
	echo ('attr-db-!attrid!','attr-value-!attrid!'^^^) , >> %filename%
)
set "formattedValue=000000%end2%"
set attrid=!formattedValue:~-6!
echo ('attr-db-!attrid!','attr-value-!attrid!'^^^) ; >> %filename%
