@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------


echo !-======Hotspot Script======-!
echo !             AV             !
echo !____________________________!
setlocal EnableDelayedExpansion
echo 1. Start Hotspot
echo 2. Stop Hotspot
echo 3. Settings
SET /p ch="Choose option [1-3]:"
IF %ch%==1 (netsh wlan start hostednetwork
)ELSE IF %ch%==2 (netsh wlan stop hostednetwork
)ELSE (echo ..
SET /p name="Enter Hotspot name [SSID]: "
SET /p pwd="Enter Password: "
netsh wlan set hostednetwork mode=allow ssid="!name!" key="!pwd!"
)
pause
