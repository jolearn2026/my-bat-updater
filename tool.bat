@echo off
setlocal EnableExtensions
title AUTO UPDATE CHECKER ...
color 0e

set CURRENT_VERSION=2.6

set VERSION_URL=https://raw.githubusercontent.com/jolearn2026/my-bat-updater/main/version.txt
set UPDATE_URL=https://raw.githubusercontent.com/jolearn2026/my-bat-updater/main/tool.bat

set TMP_VERSION=%TEMP%\latest_version.txt
set TMP_UPDATE=%TEMP%\tool_update.bat

echo         ============================
echo              CHECK FOR UPDATE
echo         ============================
echo Current version: %CURRENT_VERSION%
echo.

:: ======================
:: GET LATEST VERSION
:: ======================
powershell -NoProfile -Command "Invoke-WebRequest '%VERSION_URL%' -UseBasicParsing -OutFile '%TMP_VERSION%'" 2>nul

if not exist "%TMP_VERSION%" (
    echo ERROR: Cannot check update
    goto run
)

set /p LATEST_VERSION=<"%TMP_VERSION%"

if "%LATEST_VERSION%"=="%CURRENT_VERSION%" (
    echo You already have latest version.
    goto run
)

echo New version found: %LATEST_VERSION%
echo Updating...

:: ======================
:: DOWNLOAD UPDATE
:: ======================
powershell -NoProfile -Command "Invoke-WebRequest '%UPDATE_URL%' -UseBasicParsing -OutFile '%TMP_UPDATE%'" 2>nul

if not exist "%TMP_UPDATE%" (
    echo ERROR: Update failed
    goto run
)

copy /y "%TMP_UPDATE%" "%~f0" >nul

echo Update complete. Restarting...
timeout /t 2 >nul

cmd /c start "" "%~f0"
exit

:run
echo.


