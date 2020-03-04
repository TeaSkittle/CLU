:: ==================================================================================
:: Author - Travis Dowd
:: Date Started: 2-7-2020 (v0.1)
:: Version 1.0 completed on: 2-26-2020        
:: ==================================================================================
@ECHO OFF
CLS
SETLOCAL EnableDelayedExpansion
::
:: Variables to be changed by user
::
SET defip=192.168.0.x
SET defsub=255.255.255.0
SET defgate=192.168.0.1
SET defdns=8.8.8.8
SET deftime="Mountain Standard Time"
SET dest=C:\CLU\
SET step=3
:: Array of items to be downloaded
SET down[0]=https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US
SET down[1]=https://www.7-zip.org/a/7z1900-x64.exe
SET down[2]=https://ftp.gnu.org/gnu/emacs/windows/emacs-26/emacs-26.3-x86_64.zip
:: Array of apps to be installed
::   - This should be what is downloaded from above array
SET apps[0]=%dest%Firefox Setup 73.0.1.exe
SET apps[1]=%dest%7z1900-x64.exe
SET apps[2]=%dest%emacs-26.3-x86_64.zip
::
:: Variables not to be changed
::
COLOR 0F
SET ver=1.4
TITLE CLU - %ver%
SET log=%dest%CLU_log.txt
IF NOT EXIST %dest% MD %dest%
::
:: Check for admin rights
::
CALL :head
NET SESSION >NUL 2>&1
IF %errorLevel% == 0 (
	CALL :tee [+]Success: Administrative rights confirmed
	ECHO **************************************************** >> %log%
) ELSE (
	COLOR 0C
	CALL :tee [-]Failure: Current rights insufficient
	ECHO **************************************************** >> %log%
	PAUSE
	COLOR 0F
	EXIT /B 0
)
::
:: If user is admin, script begins below
::
ECHO.
ECHO ***************************************************************  
ECHO *                                                             *
ECHO *                         -= CLU =-                           *  
ECHO *  Basics:                                                    *
ECHO *        0.  Exit and stop this script                        *
ECHO *        1.  Restart device                                   *
ECHO *                                                             *
ECHO *  Setup:                                                     *
ECHO *        2.  Force WSUS Updates                               *
ECHO *        3.  Change device's name                             *
ECHO *        4.  Download files                                   *
ECHO *        5.  Install apps                                     *
ECHO *        6.  Remove items pinned to taskbar                   *
ECHO *                                                             *
ECHO *  Network Settings:                                          *
ECHO *        7.  Change IP, Subnet, Gateway, and DNS              *
ECHO *        8.  Test network connection                          *
ECHO *                                                             *
ECHO *  Diagnostics:                                               *
ECHO *        9.  Check disk for errors                            *
ECHO *        10. Delete temp files                                *
ECHO *        11. Defrag C: drive                                  *
ECHO *        12. Display system info                              *
ECHO *        13. View runnings tasks                              *
ECHO *                                                             *
ECHO *  Notes/Logs:                                                *
ECHO *        14. Open log file                                    *
ECHO *        15. Delete Log(s)                                    *
ECHO *                                                             *
ECHO ***************************************************************
ECHO.
SET /P option="Option -> "
IF %option%==0  EXIT /B 0                         || CALL :tee [-]Failed exiting CLU
IF %option%==1  SHUTDOWN /r /t 00                 || CALL :tee [-]Failed device restart
IF %option%==2  CALL :update                      || CALL :tee [-]Force update failed
IF %option%==3  CALL :name                        || CALL :tee [-]Computer name change failed
IF %option%==4  CALL :download                    || CALL :tee [-]File download fail
IF %option%==5  CALL :install                     || CALL :tee [-]install of apps failed
IF %option%==6  CALL :taskbar                     || CALL :tee [-]taskbar failed to clear
IF %option%==7  CALL :network                     || CALL :tee [-]Failed changing network config
IF %option%==8  CALL :test                        || CALL :tee [-]Network test failed
IF %option%==9  CALL :check                       || CALL :tee [-]check disk failed
IF %option%==10 DEL /F /S /Q %temp%               || CALL :tee [-]Failed to deleted temp files
IF %option%==11 DEFRAG C: /U /V                   || CALL :tee [-]defrag C: error
IF %option%==12 SYSTEMINFO                        || CALL :tee [-]systeminfo error
IF %option%==13 TASKLIST | MORE                   || CALL :tee [-]tasklist error
IF %option%==14 NOTEPAD %log%                     || CALL :tee [-]Failed loading log
IF %option%==15 DEL %log%                         && ECHO Deleting log file...
COLOR 0A
ECHO ***************************************
ECHO *               COMPLETE              *
ECHO ***************************************
PAUSE
COLOR 0F
EXIT /B 0
@ECHO ON
::
:: Functions
::
:download
CD %dest%
FOR /l %%n IN (0,1,%step%) DO ( 
   curl -O !down[%%n]!
)
EXIT /B 0
:install
FOR /l %%n IN (0,1,%step%) DO ( 
   !apps[%%n]!
)
EXIT /B 0
:name
SET /P name="Enter a new Computer Name: "
wmic computersystem where caption='%computername%' rename %name% || CALL :tee [-]Computer name change failed
EXIT /B 0
:taskbar
DEL /F /S /Q /A "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" || CALL :tee [-]Failed to delete taskbar items
REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f             || CALL :tee [-]Failed to delete taskbar registry items
EXIT /B 0
:check
WMIC DISKDRIVE GET STATUS || CALL :tee [-]WMIC Error
SFC /SCANNOW              || CALL :tee [-]SFC Error
DEFRAG C: /A /V           || CALL :tee [-]DEFRAG /A Error
EXIT /B 0
:network
SET /P ip="IP address[ %defip% ]: "
SET /P sub="Subnet Mask[ %defsub% ]: "
SET /P gate="Default Gateway[ %defgate% ]: "
SET /P dns="DNS[ %defdns% ]: "
SET adapterName=
FOR /F "tokens=* delims=:" %%a IN ('IPCONFIG ^| FIND /I "ETHERNET ADAPTER"') DO (
	SET adapterName=%%a
	SET adapterName=!adapterName:~17!
	SET adapterName=!adapterName:~0,-1!
	netsh interface ipv4 set address name="!adapterName!" static %ip% %sub% %gate%
	netsh interface ipv4 set dns     name="!adapterName!" static %dns% primary
) || CALL :tee [-]Network settings could not be assigned
EXIT /B 0
:test
nslookup 192.168.10.5  || CALL :tee [-]nslookup failed
ping www.google.com    || CALL :tee [-]ping www.google.com failed
tracert www.google.com || CALL :tee [-]tracert www.google.com failed
EXIT /B 0
:update
CONTROL UPDATE
IPCONFIG /FLUSHDNS                     || CALL :tee "[-]flushdns failed"
NET STOP wuauserv                      || CALL :tee [-]wuauserv net stop failed
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f
WUAUCLT /resetauthorization /detectnow || CALL :tee [-]wuauclt.exe failure
GPUPDATE /force /wait:10               || CALL :tee [-]Group Policy timed out
SC CONFIG WUAUSERV start=auto          || CALL :tee [-]wuauserv service start=auto failed
SC CONFIG W32TIME  start=auto          || CALL :tee [-]W32Time service start=auto failed
SC CONFIG BITS     start=auto          || CALL :tee [-]BITS service start=auto failed
SC CONFIG CRYPTSVC start=auto          || CALL :tee [-]CryptSvc service start=auto failed
NET STOP W32TIME                       || CALL :tee [-]W32Time net stop failed
TZUTIL /S %deftime%                    || CALL :tee [-]Could not assign proper timezone
NET START W32TIME                      || CALL :tee [-]W32Time net start failed
W32TM /RESYNC /REDISCOVER              || CALL :tee [-]Could not sync to w32tm
USOCLIENT StartInteractiveScan         || CALL :tee [-]Could not start UsoClient.exe for windows updates
EXIT /B 0
::
:: Logging Functions
::
:head
ECHO **************************************************** >> %log%
ECHO        -= CLU started =-   >> %log%
ECHO Version: %ver%             >> %log%
ECHO  Device: %USERDOMAIN%      >> %log%
ECHO    User: %USERNAME%        >> %log%
ECHO    Date: %DATE% - %TIME%   >> %log%          
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" >> %log%
EXIT /B 0
:tee
ECHO %* >> "%log%"
ECHO %*
EXIT /B 0
