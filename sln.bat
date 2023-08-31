@ECHO OFF
Title "2tb Bud formater, Developed by Haruko"
cls
color a

REM Check if running as administrator
NET SESSION >NUL 2>NUL
IF %ERRORLEVEL% NEQ 0 (
  ECHO This script must be run as administrator. Please run this script again with administrator privileges.
  CHOICE /T 5 /D Y /M "You would not see this screen if you had read the file name!Did you read the file name?: "
  IF %ERRORLEVEL% NEQ 1 (
    powershell Start-Process '%0' -Verb runAs
  )
  EXIT
)

:GET_NUMBER
ECHO "*********************************************************"
ECHO "*                                                       *"
ECHO "*            How many Bud do you have there ?           *"
ECHO "*         Enter 0 to retrieve disk information          *"
ECHO "*             Enter e to exit the script                *"
ECHO "*                                                       *"
ECHO "*********************************************************"
SET /P N="I have: "

REM Check if input is a number or 0
SET /A num=%N% 2>NUL
IF %ERRORLEVEL% NEQ 0 (
  color 06
  ECHO Invalid input. Please enter a number or 0.
  color 0a
  GOTO GET_NUMBER
)

IF %N% EQU help (
  ECHO "*************************************************************************"
  ECHO "*                                                                       *"
  ECHO "*                   Developed by Willam "Haruko" Le                     *"
  ECHO "*     This script is used to format 2tb bud to mbr and auto name it     *"
  ECHO "*                                                                       *"
  ECHO "*************************************************************************"
  PAUSE
  cls
  GOTO GET_NUMBER
)

IF %N% EQU e (
  EXIT
)

IF %N% EQU 0 (
  WMIC DISKDRIVE GET Name, Model, SerialNumber, Size, Manufacturer
  PAUSE
  GOTO GET_NUMBER
)

REM Check if file exists
IF NOT EXIST "%APPDATA%\c%N%.txt" (
  color 0c
  ECHO Error: script not found, Please make sure you running the script from V:IT DRIVE and enter correct amount!
  color 0a
  GOTO GET_NUMBER
)

ECHO "**************************************************************"
ECHO "*                                                            *"
ECHO "*          Verify you have %N% Bud online.                     *"
ECHO "*     Do you want to proceed with disk formatting? (y/n)     *"
ECHO "*                                                            *"
ECHO "**************************************************************"
SET /P proceed="Y/N: "
IF /I "%proceed%"=="y" (
  ECHO Formatting disks...
  diskpart.exe /s "%APPDATA%\c%N%.txt"
  ECHO Completed, return to the main menu!
  TIMEOUT 3
  cls
  GOTO GET_NUMBER
) ELSE (
  ECHO Disk formatting cancelled.
  TIMEOUT 3
  cls
  GOTO GET_NUMBER
)
