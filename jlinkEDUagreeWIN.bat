::Author: Lucas C. Jun 2021
::Description:
::Disables the J-Link EDU & Mini EDU License Agreement Pop-Ups.
::Updates the date in the J-Link settings Registry.
::Installation
::Use Windows Task Scheduler to run every day automatically at midnight or at login.

@echo off
::Generate new date value
set year=%Date:~6,4%
set mon=%Date:~3,2%
set day=%Date:~0,2%

::Use PS to convert to hex and build date hex string
for /f %%i in ('powershell -command "'{0:x4}' -f" %year%') do set new=%%i
for /f %%i in ('powershell -command "'{0:x2}' -f" %mon%') do set new=%new%%%i
for /f %%i in ('powershell -command "'{0:x2}' -f" %day%') do set new=%new%%%i

::Replace old value with the new value
reg add "HKEY_CURRENT_USER\Software\SEGGER\J-Link" /f /v "LicenseEDU_DontShowAgainToday" /t REG_DWORD /d "0x%new%"
reg add "HKEY_CURRENT_USER\Software\SEGGER\J-Link" /f /v "LicenseEDUMini_DontShowAgainToday" /t REG_DWORD /d "0x%new%"
reg add "HKEY_CURRENT_USER\Software\SEGGER\J-Link" /f /v "LicenseLPCLink2_DontShowAgainToday" /t REG_DWORD /d "0x%new%"
