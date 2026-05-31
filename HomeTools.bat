@echo off
:: ============================================================
::  HOME TOOLS  |  OSINT Launcher  |  v3.0
::  A self-installing OSINT toolkit launcher for Windows.
::
::  Tools clone and install automatically on first launch.
::  Each tool runs in its own Python virtual environment.
::  Updates are checked and applied on every startup.
::
::  Requirements: Windows 10/11, Python 3.10+, git (in PATH)
::  Install locations: C:\OSINT\   and   C:\Tools\exiftool\
::  Made with love by vortexdq.com
:: ============================================================
if "%~1"=="-k" goto :INIT
start "HOME TOOLS" cmd.exe /k %~f0 -k
exit /b
:INIT

setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title HOME TOOLS v3.0

:: ============================================================
::  ANSI COLORS
:: ============================================================
for /f "delims=" %%E in ('powershell -NoProfile -Command "[char]27"') do set "E=%%E"
set "R=%E%[0m"
set "CY=%E%[96m"
set "CB=%E%[1;96m"
set "GN=%E%[92m"
set "GB=%E%[1;92m"
set "YW=%E%[93m"
set "YB=%E%[1;93m"
set "RD=%E%[91m"
set "MB=%E%[1;95m"
set "BB=%E%[1;94m"
set "DG=%E%[90m"
set "WH=%E%[97m"
set "WB=%E%[1;97m"
set "MGB=%E%[1;35m"
set "ORB=%E%[1;33m"

:: ============================================================
::  TOOL PATHS
::  Edit paths below if your tools live somewhere different.
:: ============================================================
set "P_JLT=%USERPROFILE%\Desktop\Stuff\JLT EDGE WIRLESS (2)"
set "P_SCAN=%USERPROFILE%\Desktop\Stuff\Scanners"
set "P_SPIDER=C:\OSINT\spiderfoot"
set "P_EXIF=C:\Tools\exiftool"
set "P_SHERL=C:\OSINT\sherlock"
set "P_OGRAM=C:\OSINT\osintgram"
set "P_HARV=C:\OSINT\theHarvester"
set "P_HOLE=C:\OSINT\holehe"
set "P_MAIG=C:\OSINT\maigret"
set "P_PHOT=C:\OSINT\Photon"
set "P_SQLM=C:\OSINT\sqlmap"
set "P_SCAV=C:\OSINT\scavenger"
set "P_LINK=C:\OSINT\linkedin-gatherer"
set "P_PWND=C:\OSINT\pwnedornot"

:: ============================================================
::  FIRST RUN CHECK
:: ============================================================
if not exist "C:\OSINT"  mkdir "C:\OSINT"  >nul 2>&1
if not exist "C:\Tools"  mkdir "C:\Tools"   >nul 2>&1
set "SETUP_MARKER=C:\OSINT\.hometools_setup"
if not exist "!SETUP_MARKER!" goto ONBOARDING
goto STARTUP


:: ============================================================
::  ONBOARDING  -  First-time setup wizard
:: ============================================================
:ONBOARDING
cls
echo.
echo  %CB%  =======================================================%R%
echo  %CB%           HOME TOOLS v3.0  -  First Launch             %R%
echo  %CB%       Self-installing OSINT Toolkit for Windows         %R%
echo  %CB%  =======================================================%R%
echo.
echo  %WB%  Welcome! This toolkit automatically installs and manages:%R%
echo.
echo  %DG%   SpiderFoot    Automated OSINT framework (web UI)%R%
echo  %DG%   ExifTool      File metadata reader, writer and stripper%R%
echo  %DG%   Sherlock      Username hunting across 400+ sites%R%
echo  %DG%   Osintgram     Instagram OSINT collector%R%
echo  %DG%   theHarvester  Email, domain and subdomain recon%R%
echo  %DG%   Holehe        Find accounts linked to an email address%R%
echo  %DG%   Maigret       Deep username OSINT with HTML reports%R%
echo  %DG%   Photon        Web crawler - extracts emails, URLs, keys%R%
echo  %DG%   SQLMap        Automated SQL injection scanner%R%
echo.
echo  %WH%  Tools install to:  %CY%C:\OSINT\%R%
echo  %WH%  ExifTool to:       %CY%C:\Tools\exiftool\%R%
echo.
echo  %DG%  --------------------------------------------------------%R%
echo  %YW%  LEGAL NOTICE - READ BEFORE CONTINUING%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %YW%  These tools are for authorized security research ONLY.%R%
echo  %YW%  Only test systems you own or have explicit written%R%
echo  %YW%  permission to test. Unauthorized use is illegal.%R%
echo  %YW%  The author accepts no responsibility for misuse.%R%
echo  %DG%  --------------------------------------------------------%R%
echo.
echo  %WH%  Type %GN%AGREE%WH% and press ENTER to accept and continue:%R%
echo.
set "OB_IN="
set /p "OB_IN=   >> "
if /i not "!OB_IN!"=="AGREE" (
  echo.
  echo  %RD%  You must type AGREE to use this toolkit. Closing.%R%
  timeout /t 3 /nobreak >nul
  exit /b 1
)

:: Prerequisite check
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%  Checking Prerequisites                                %R%
echo  %CB%  =======================================================%R%
echo.
set "HAS_GIT=0"
set "HAS_PY=0"
where git    >nul 2>&1 && set "HAS_GIT=1"
where python >nul 2>&1 && set "HAS_PY=1"

if "!HAS_GIT!"=="1" (echo  %GN%  [OK]  git found in PATH%R%) else (echo  %RD%  [!!]  git NOT found  ^|  Get it at: https://git-scm.com/download/win%R%)
if "!HAS_PY!"=="1"  (echo  %GN%  [OK]  Python found in PATH%R%) else (echo  %RD%  [!!]  Python NOT found  ^|  Get it at: https://python.org/downloads%R%)
echo.
if "!HAS_GIT!"=="0" goto :OB_WARN
if "!HAS_PY!"=="0"  goto :OB_WARN
goto :OB_READY
:OB_WARN
echo  %YW%  WARNING: One or more prerequisites are missing.%R%
echo  %YW%  Install them, add to PATH, then restart HOME TOOLS.%R%
echo  %YW%  Continuing anyway - affected tools will show [--].%R%
echo.
:OB_READY
echo  %WH%  HOME TOOLS will now install all OSINT tools.%R%
echo  %DG%  First install takes 5-20 min depending on connection.%R%
echo  %DG%  Subsequent launches are fast - only update checks run.%R%
echo.
echo  %WH%  Press any key to begin installing...%R%
pause >nul
echo %date% %time% > "!SETUP_MARKER!"
goto STARTUP


:: ============================================================
::  STARTUP  -  Check, install and update all tools
:: ============================================================
:STARTUP
cls
echo.
echo  %CB%  ___  ___  ___  ___  ___     ___  ___  ___  __  ___   %R%
echo  %CB% ^| . \^| . \^| . \^| . \^| . \   ^|_ _^|^| . \^| . \^| .^|^|_ _^|  %R%
echo  %CB% ^|  _/^|  _/^|  _/^|___/^|   /     ^| ^| ^|   /^|   /^| . ^|^| ^|   %R%
echo  %CB% ^|_^|  ^|_^|  ^|_^|  ^|    ^|_^|\_\    ^|_^| ^|_^|\_\^|_^|\_\^|_^|^|^|_^|   %R%
echo.
echo  %CY%  =======================================================%R%
echo  %WB%       Checking tools  -  please wait...%R%
echo  %CY%  =======================================================%R%
echo.

set "HAS_GIT=0"
set "HAS_PY=0"
set "HAS_NET=0"
where git    >nul 2>&1 && set "HAS_GIT=1"
where python >nul 2>&1 && set "HAS_PY=1"
ping -n 1 -w 2000 8.8.8.8 >nul 2>&1 && set "HAS_NET=1"

if "!HAS_GIT!"=="0" echo  %RD%  [WARN] git not found - git tools cannot install/update.%R%
if "!HAS_PY!"=="0"  echo  %RD%  [WARN] Python not found - Python tools cannot install.%R%
if "!HAS_NET!"=="0" echo  %YW%  [WARN] No internet - installs and updates skipped.%R%

call :SC_SPIDER
call :SC_EXIF
call :SC_SHERL
call :SC_OGRAM
call :SC_HARV
call :SC_HOLE
call :SC_MAIG
call :SC_PHOT
call :SC_SQLM
call :SC_SCAV
call :SC_LINK
call :SC_PWND
call :FIX_OSINTGRAM

echo.
echo  %GB%  =======================================================%R%
echo  %GN%  All checks complete.%R%
echo  %GB%  =======================================================%R%
echo.
timeout /t 2 /nobreak >nul
goto MENU


:: ============================================================
::  MAIN MENU
:: ============================================================
:MENU
cls
echo.
echo  %CB%  ___  ___  ___  ___  ___     ___  ___  ___  __  ___   %R%
echo  %CB% ^| . \^| . \^| . \^| . \^| . \   ^|_ _^|^| . \^| . \^| .^|^|_ _^|  %R%
echo  %CB% ^|  _/^|  _/^|  _/^|___/^|   /     ^| ^| ^|   /^|   /^| . ^|^| ^|   %R%
echo  %CB% ^|_^|  ^|_^|  ^|_^|  ^|    ^|_^|\_\    ^|_^| ^|_^|\_\^|_^|\_\^|_^|^|^|_^|   %R%
echo.
echo  %CY%  =======================================================%R%
echo  %WB%              HOME TOOLS  ^|  v3.0%R%
echo  %CY%  =======================================================%R%
echo.

set "S1=%GN% [OK] %R%"
set "S2=%GN% [OK] %R%"
set "S3=%RD% [--] %R%"
set "S4=%RD% [--] %R%"
set "S5=%RD% [--] %R%"
set "S6=%RD% [--] %R%"
set "S7=%RD% [--] %R%"
set "S8=%RD% [--] %R%"
set "S9=%RD% [--] %R%"
set "S10=%RD%[--] %R%"
set "S11=%RD%[--] %R%"
set "S12=%RD%[--] %R%"
set "S13=%RD%[--] %R%"
set "S14=%RD%[--] %R%"

if not exist "%P_JLT%\OemDrv.exe"               set "S1=%RD% [!!] %R%"
if not exist "%P_SCAN%"                          set "S2=%RD% [!!] %R%"
if exist "%P_SPIDER%\sf.py"                      set "S3=%GN% [OK] %R%"
if exist "%P_EXIF%\exiftool.exe"                 set "S4=%GN% [OK] %R%"
if exist "%P_SHERL%\sherlock_project"            set "S5=%GN% [OK] %R%"
if exist "%P_OGRAM%\main.py"                     set "S6=%GN% [OK] %R%"
if exist "%P_HARV%\theHarvester\__main__.py"     set "S7=%GN% [OK] %R%"
if exist "%P_HOLE%\holehe"                       set "S8=%GN% [OK] %R%"
if exist "%P_MAIG%\maigret"                      set "S9=%GN% [OK] %R%"
if exist "%P_PHOT%\photon.py"                    set "S10=%GN%[OK] %R%"
if exist "%P_SQLM%\sqlmap.py"                    set "S11=%GN%[OK] %R%"
if exist "%P_SCAV%\scavenger.py"                 set "S12=%GN%[OK] %R%"
if exist "%P_LINK%\linkedin_gatherer.py"         set "S13=%GN%[OK] %R%"
if exist "%P_PWND%\pwnedornot.py"                set "S14=%GN%[OK] %R%"

echo  %WB%  DEVICE / LOCAL%R%
echo  %DG%  --------------------------------------------------------%R%
echo  !S1!%CB% [1]%R%  %WH%JLT Edge Wireless         %DG%OemDrv device manager%R%
echo  !S2!%CB% [2]%R%  %WH%Scanners                  %DG%ESET / F-Secure / HitmanPro%R%
echo.
echo  %WB%  OSINT TOOLS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  !S3!%BB% [3]%R%  %WH%SpiderFoot                %DG%Automated OSINT framework (web UI)%R%
echo  !S4!%MB% [4]%R%  %WH%ExifTool                  %DG%File metadata reader / writer%R%
echo  !S5!%YB% [5]%R%  %WH%Sherlock                  %DG%Username hunt across 400+ sites%R%
echo  !S6!%GB% [6]%R%  %WH%Osintgram                 %DG%Instagram OSINT collector%R%
echo  !S7!%ORB% [7]%R%  %WH%theHarvester              %DG%Email / domain / subdomain recon%R%
echo  !S8!%MGB% [8]%R%  %WH%Holehe                    %DG%Email to social accounts%R%
echo  !S9!%CY% [9]%R%  %WH%Maigret                   %DG%Deep username OSINT with reports%R%
echo  !S10!%WB%[10]%R%  %WH%Photon                    %DG%Web crawler / data extractor%R%
echo  !S11!%RD%[11]%R%  %WH%SQLMap                    %DG%SQL injection scanner%R%
echo  !S12!%CB%[12]%R%  %WH%Scavenger                 %DG%Pastebin leak and credential monitor%R%
echo  !S13!%BB%[13]%R%  %WH%LinkedIn Gatherer          %DG%LinkedIn profile and network OSINT%R%
echo  !S14!%YB%[14]%R%  %WH%pwnedOrNot                %DG%Email breach checker with passwords%R%
echo.
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  [R]%R% Repair   %CY%[C]%R% Commands   %CY%[H]%R% Help   %CY%[I]%R% Instagram setup   %CY%[Q]%R% Quit
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%             Made with love by vortexdq.com%R%
echo.
set "CHO="
set /p "CHO=   >> "
if not defined CHO goto MENU
if /i "%CHO%"=="1"         goto LAUNCH_JLT
if /i "%CHO%"=="2"         goto MENU_SCANNERS
if /i "%CHO%"=="3"         goto LAUNCH_SPIDER
if /i "%CHO%"=="4"         goto LAUNCH_EXIF
if /i "%CHO%"=="5"         goto LAUNCH_SHERL
if /i "%CHO%"=="6"         goto LAUNCH_OGRAM
if /i "%CHO%"=="7"         goto LAUNCH_HARV
if /i "%CHO%"=="8"         goto LAUNCH_HOLE
if /i "%CHO%"=="9"         goto LAUNCH_MAIG
if /i "%CHO%"=="10"        goto LAUNCH_PHOT
if /i "%CHO%"=="11"        goto LAUNCH_SQLM
if /i "%CHO%"=="12"        goto LAUNCH_SCAV
if /i "%CHO%"=="13"        goto LAUNCH_LINK
if /i "%CHO%"=="14"        goto LAUNCH_PWND
if /i "%CHO%"=="R"         goto REPAIR
if /i "%CHO%"=="repair"    goto REPAIR
if /i "%CHO%"=="C"         goto COMMAND_CENTER
if /i "%CHO%"=="commands"  goto COMMAND_CENTER
if /i "%CHO%"=="H"         goto HELP
if /i "%CHO%"=="help"      goto HELP
if /i "%CHO%"=="I"         goto OGRAM_SETUP_MENU
if /i "%CHO%"=="instagram" goto OGRAM_SETUP_MENU
if /i "%CHO%"=="creds"     goto OGRAM_SETUP_MENU
if /i "%CHO%"=="Q"         goto QUIT
if /i "%CHO%"=="quit"      goto QUIT
if /i "%CHO%"=="exit"      goto QUIT
echo  %RD%  Unknown option. Type 1-14, R, C, H, I, or Q.%R%
timeout /t 1 /nobreak >nul
goto MENU


:: ============================================================
::  SCANNERS SUBMENU
:: ============================================================
:MENU_SCANNERS
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%              SCANNERS  ^|  Choose one%R%
echo  %CB%  =======================================================%R%
echo.
set "T1=%RD% [!!] %R%"
set "T2=%RD% [!!] %R%"
set "T3=%RD% [!!] %R%"
if exist "%P_SCAN%\esetonlinescanner.exe"     set "T1=%GN% [OK] %R%"
if exist "%P_SCAN%\F-SecureOnlineScanner.exe" set "T2=%GN% [OK] %R%"
if exist "%P_SCAN%\HitmanPro_x64.exe"         set "T3=%GN% [OK] %R%"
echo  !T1!%CB%[1]%R%  ESET Online Scanner
echo  !T2!%BB%[2]%R%  F-Secure Online Scanner
echo  !T3!%MB%[3]%R%  HitmanPro x64
echo.
echo  %DG%  [B] Back%R%
echo.
set "SCHO="
set /p "SCHO=   >> "
if not defined SCHO goto MENU_SCANNERS
if /i "%SCHO%"=="1"    goto LAUNCH_ESET
if /i "%SCHO%"=="2"    goto LAUNCH_FSECURE
if /i "%SCHO%"=="3"    goto LAUNCH_HITMAN
if /i "%SCHO%"=="B"    goto MENU
if /i "%SCHO%"=="back" goto MENU
goto MENU_SCANNERS


:: ============================================================
::  LAUNCHERS
:: ============================================================

:LAUNCH_JLT
cls
echo.
echo  %CB%  Launching JLT Edge Wireless...%R%
echo.
if not exist "%P_JLT%\OemDrv.exe" goto :LAUNCH_JLT_NF
start "" "%P_JLT%\OemDrv.exe"
echo  %GN%  Launched.%R%
timeout /t 2 /nobreak >nul
goto MENU
:LAUNCH_JLT_NF
echo  %RD%  OemDrv.exe not found at: %P_JLT%%R%
echo  %DG%  Check the JLT EDGE WIRLESS (2) folder exists in Desktop\Stuff%R%
echo.
pause
goto MENU

:LAUNCH_ESET
cls
echo  %CB%  Launching ESET Online Scanner...%R%
if not exist "%P_SCAN%\esetonlinescanner.exe" echo  %RD%  Not found.%R% & pause & goto MENU_SCANNERS
start "" "%P_SCAN%\esetonlinescanner.exe"
timeout /t 2 /nobreak >nul
goto MENU

:LAUNCH_FSECURE
cls
echo  %CB%  Launching F-Secure Online Scanner...%R%
if not exist "%P_SCAN%\F-SecureOnlineScanner.exe" echo  %RD%  Not found.%R% & pause & goto MENU_SCANNERS
start "" "%P_SCAN%\F-SecureOnlineScanner.exe"
timeout /t 2 /nobreak >nul
goto MENU

:LAUNCH_HITMAN
cls
echo  %CB%  Launching HitmanPro...%R%
if not exist "%P_SCAN%\HitmanPro_x64.exe" echo  %RD%  Not found.%R% & pause & goto MENU_SCANNERS
start "" "%P_SCAN%\HitmanPro_x64.exe"
timeout /t 2 /nobreak >nul
goto MENU

:LAUNCH_SPIDER
cls
echo.
echo  %BB%  =======================================================%R%
echo  %WB%  SpiderFoot  ^|  Automated OSINT Framework%R%
echo  %BB%  =======================================================%R%
echo.
if not exist "%P_SPIDER%\sf.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_SPIDER%" & set "HV_REQS=%P_SPIDER%\requirements.txt"
call :HEALTH_VENV
echo  %DG%  Starting web server...%R%
start "SpiderFoot" powershell -NoExit -Command "Set-Location 'C:\OSINT\spiderfoot'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  SpiderFoot  |  OSINT Framework' -ForegroundColor Cyan; Write-Host '  Server starting - open browser at http://127.0.0.1:5001' -ForegroundColor Green; Write-Host '  Wait about 5 seconds before opening the URL.' -ForegroundColor DarkGray; Write-Host '  Close this window to stop the server.' -ForegroundColor DarkGray; Write-Host; & $p sf.py -l 127.0.0.1:5001"
echo  %GN%  SpiderFoot starting in a new window.%R%
echo  %CY%  Open your browser at: http://127.0.0.1:5001%R%
echo  %DG%  Wait ~5 seconds for the server to start, then open the URL.%R%
echo  %DG%  Press any key here to return to menu (server keeps running).%R%
pause >nul
goto MENU

:LAUNCH_EXIF
cls
echo.
echo  %MB%  =======================================================%R%
echo  %WB%  ExifTool  ^|  File Metadata Reader / Writer%R%
echo  %MB%  =======================================================%R%
echo.
if not exist "%P_EXIF%\exiftool.exe" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
start "ExifTool" powershell -NoExit -Command "Set-Location 'C:\Tools\exiftool'; Write-Host '  ExifTool  |  File Metadata Reader/Writer' -ForegroundColor Magenta; Write-Host '  Type a file path, or drag a file onto this window to paste its path.' -ForegroundColor DarkGray; Write-Host '  Blank = exit loop.' -ForegroundColor DarkGray; Write-Host; do { $f=Read-Host '  File/folder'; if($f){ .\exiftool.exe $f } } while($f)"
echo  %GN%  ExifTool shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU

:LAUNCH_SHERL
cls
echo.
echo  %YB%  =======================================================%R%
echo  %WB%  Sherlock  ^|  Username OSINT%R%
echo  %YB%  =======================================================%R%
echo.
if not exist "%P_SHERL%\sherlock_project" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_SHERL%" & set "HV_REQS=" & set "HV_PKG=sherlock-project"
call :HEALTH_VENV
start "Sherlock" powershell -NoExit -Command "Set-Location 'C:\OSINT\sherlock'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  Sherlock  |  Username Hunt across 400+ Sites' -ForegroundColor Yellow; Write-Host '  Type a username and press Enter. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host '  Tip: try variations - john, john123, j0hn, john_doe, johndoe' -ForegroundColor DarkGray; Write-Host; do { $u=Read-Host '  Username'; if($u){ & $p -m sherlock_project $u } } while($u)"
echo  %GN%  Sherlock shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU


:: ============================================================
::  OSINTGRAM  -  Three-stage flow:
::  LAUNCH_OGRAM  -> checks installed + creds
::  OGRAM_SETUP   -> collects Instagram credentials (masked pw)
::  OGRAM_LAUNCH  -> health check + start PS loop
:: ============================================================
:LAUNCH_OGRAM
cls
echo.
echo  %GB%  =======================================================%R%
echo  %WB%  Osintgram  ^|  Instagram OSINT%R%
echo  %GB%  =======================================================%R%
echo.
if not exist "%P_OGRAM%\main.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "OGCRED=0"
powershell -NoProfile -Command "if((Get-Content 'C:\OSINT\osintgram\config\credentials.ini' -EA SilentlyContinue) -match 'username\s*=\s*\S+' -and (Get-Content 'C:\OSINT\osintgram\config\credentials.ini' -EA SilentlyContinue) -match 'password\s*=\s*\S+'){exit 0}else{exit 1}" >nul 2>nul && set "OGCRED=1"
if "!OGCRED!"=="1" goto OGRAM_LAUNCH
goto OGRAM_SETUP

:OGRAM_SETUP_MENU
:: Called from main menu [I] - show setup, offer to launch after
set "OGRAM_FROM_MENU=1"
goto OGRAM_SETUP

:OGRAM_SETUP
cls
echo.
echo  %GB%  =======================================================%R%
echo  %WB%  Osintgram  ^|  Instagram Account Setup%R%
echo  %GB%  =======================================================%R%
echo.
echo  %WH%  Osintgram needs an Instagram account to operate.%R%
echo  %YW%  Use a secondary / burner account - NOT your main one.%R%
echo  %YW%  The account must NOT have 2FA (two-factor auth) enabled.%R%
echo.
echo  %DG%  Credentials are stored locally only in:%R%
echo  %DG%  C:\OSINT\osintgram\config\credentials.ini%R%
echo  %DG%  They are never sent anywhere by this launcher.%R%
echo.
set "IG_USER="
set /p "IG_USER=   Instagram Username >> "
if not defined IG_USER goto :OG_SETUP_CANCEL
echo.
echo  %DG%  Password input is hidden while typing...%R%
for /f "delims=" %%P in ('powershell -NoProfile -Command "$s=Read-Host -Prompt ''   Instagram Password'' -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($s))"') do set "IG_PASS=%%P"
if not defined IG_PASS goto :OG_SETUP_CANCEL
if not exist "%P_OGRAM%\config" mkdir "%P_OGRAM%\config" >nul 2>&1
(echo [Credentials]
echo username = !IG_USER!
echo password = !IG_PASS!
echo hikerapi_token = ) > "%P_OGRAM%\config\credentials.ini"
set "IG_PASS="
echo.
echo  %GN%  Credentials saved.%R%
echo  %DG%  To change them later: press [I] on the main menu.%R%
timeout /t 2 /nobreak >nul
if defined OGRAM_FROM_MENU goto :OG_SETUP_ASK_LAUNCH
set "OGRAM_FROM_MENU="
goto OGRAM_LAUNCH

:OG_SETUP_ASK_LAUNCH
set "OGRAM_FROM_MENU="
echo.
echo  %WH%  Launch Osintgram now? [Y/N]%R%
echo.
set "OGOL="
set /p "OGOL=   >> "
if /i "!OGOL!"=="Y" goto OGRAM_LAUNCH
goto MENU

:OG_SETUP_CANCEL
set "IG_PASS="
set "OGRAM_FROM_MENU="
echo.
echo  %YW%  Setup cancelled.%R%
timeout /t 1 /nobreak >nul
goto MENU

:OGRAM_LAUNCH
set "HV_PATH=%P_OGRAM%" & set "HV_REQS=%P_OGRAM%\requirements.txt"
call :HEALTH_VENV
start "Osintgram" powershell -NoExit -Command "Set-Location 'C:\OSINT\osintgram'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  Osintgram  |  Instagram OSINT' -ForegroundColor Green; Write-Host '  Type a target Instagram username. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host '  After target loads, type commands like: info, followers, photos' -ForegroundColor DarkGray; Write-Host '  Press C on the HOME TOOLS menu for the full command list.' -ForegroundColor DarkGray; Write-Host; do { $t=Read-Host '  Target username'; if($t){ & $p main.py $t } } while($t)"
echo  %GN%  Osintgram shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU


:LAUNCH_HARV
cls
echo.
echo  %ORB%  =======================================================%R%
echo  %WB%  theHarvester  ^|  Email / Domain Recon%R%
echo  %ORB%  =======================================================%R%
echo.
if not exist "%P_HARV%\theHarvester\__main__.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_HARV%" & set "HV_REQS=" & set "HV_PKG=theHarvester"
call :HEALTH_VENV
start "theHarvester" powershell -NoExit -Command "Set-Location 'C:\OSINT\theHarvester'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  theHarvester  |  Email / Domain / Subdomain Recon' -ForegroundColor Yellow; Write-Host '  Type a domain (e.g. example.com) and press Enter. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host '  Results: emails, subdomains, employee names, IPs.' -ForegroundColor DarkGray; Write-Host; do { $d=Read-Host '  Domain'; if($d){ & $p -m theHarvester -d $d -b google,bing,yahoo,duckduckgo } } while($d)"
echo  %GN%  theHarvester shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU

:LAUNCH_HOLE
cls
echo.
echo  %MGB%  =======================================================%R%
echo  %WB%  Holehe  ^|  Email to Accounts%R%
echo  %MGB%  =======================================================%R%
echo.
if not exist "%P_HOLE%\holehe" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_HOLE%" & set "HV_REQS=%P_HOLE%\requirements.txt"
call :HEALTH_VENV
start "Holehe" powershell -NoExit -Command "Set-Location 'C:\OSINT\holehe'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  Holehe  |  Email to Social Accounts (120+ sites)' -ForegroundColor Green; Write-Host '  Type an email and press Enter. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host '  Green [+] = account found  |  Red [-] = not found' -ForegroundColor DarkGray; Write-Host; do { $e=Read-Host '  Email'; if($e){ & $p -m holehe $e } } while($e)"
echo  %GN%  Holehe shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU

:LAUNCH_MAIG
cls
echo.
echo  %CY%  =======================================================%R%
echo  %WB%  Maigret  ^|  Deep Username OSINT%R%
echo  %CY%  =======================================================%R%
echo.
if not exist "%P_MAIG%\maigret" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_MAIG%" & set "HV_REQS=%P_MAIG%\requirements.txt" & set "HV_PKG=maigret"
call :HEALTH_VENV
start "Maigret" powershell -NoExit -Command "Set-Location 'C:\OSINT\maigret'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  Maigret  |  Deep Username OSINT (3000+ sites)' -ForegroundColor Cyan; Write-Host '  Discovers and links accounts across platforms.' -ForegroundColor DarkGray; Write-Host '  Add --html for an interactive HTML report with network graph.' -ForegroundColor DarkGray; Write-Host '  Type a username and press Enter. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host; do { $u=Read-Host '  Username'; if($u){ & $p -m maigret $u --html } } while($u)"
echo  %GN%  Maigret shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU

:LAUNCH_PHOT
cls
echo.
echo  %WB%  =======================================================%R%
echo  %WB%  Photon  ^|  Web Crawler / OSINT Spider%R%
echo  %WB%  =======================================================%R%
echo.
if not exist "%P_PHOT%\photon.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_PHOT%" & set "HV_REQS=%P_PHOT%\requirements.txt"
call :HEALTH_VENV
start "Photon" powershell -NoExit -Command "Set-Location 'C:\OSINT\Photon'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  Photon  |  Web Crawler / OSINT Spider' -ForegroundColor White; Write-Host '  Extracts emails, URLs, API keys, phone numbers and more.' -ForegroundColor DarkGray; Write-Host '  Type a URL (https://...) and press Enter. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host; do { $u=Read-Host '  URL'; if($u){ & $p photon.py -u $u --level 2 --threads 5 } } while($u)"
echo  %GN%  Photon shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU

:LAUNCH_SQLM
cls
echo.
echo  %RD%  =======================================================%R%
echo  %WB%  SQLMap  ^|  SQL Injection Scanner%R%
echo  %RD%  =======================================================%R%
echo.
echo  %YW%  REMINDER: Only test systems you own or have permission to test.%R%
echo.
if not exist "%P_SQLM%\sqlmap.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
if "!HAS_PY!"=="0" echo  %RD%  Python not in PATH. SQLMap needs Python.%R% & pause & goto MENU
start "SQLMap" powershell -NoExit -Command "Set-Location 'C:\OSINT\sqlmap'; Write-Host '  SQLMap  |  SQL Injection Scanner' -ForegroundColor Red; Write-Host '  Automatically detects and exploits SQL injection.' -ForegroundColor DarkGray; Write-Host '  Example target: http://site.com/page.php?id=1' -ForegroundColor DarkGray; Write-Host '  Type a target URL and press Enter. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host; do { $u=Read-Host '  Target URL'; if($u){ python sqlmap.py -u $u --batch } } while($u)"
echo  %GN%  SQLMap shell opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU


:: ============================================================
::  LAUNCHERS  12-14
:: ============================================================

:LAUNCH_SCAV
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%  Scavenger  ^|  Pastebin Leak Monitor%R%
echo  %CB%  =======================================================%R%
echo.
if not exist "%P_SCAV%\scavenger.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_SCAV%" & set "HV_REQS=%P_SCAV%\requirements.txt"
call :HEALTH_VENV
echo  %DG%  Scavenger monitors Pastebin for leaked credentials and API keys.%R%
echo  %DG%  Choose a mode in the new window:%R%
echo  %DG%  1 = Archive scrape   2 = Track user   3 = Scan local folder%R%
echo.
start "Scavenger" powershell -NoExit -Command "Set-Location 'C:\OSINT\scavenger'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  Scavenger  |  Pastebin Leak Monitor' -ForegroundColor Cyan; Write-Host '  Scans Pastebin for leaked credentials, API keys, RSA keys.' -ForegroundColor DarkGray; Write-Host '  Modes: [1] Archive scrape  [2] Track user  [3] Scan local folder' -ForegroundColor DarkGray; Write-Host; $m=Read-Host '  Mode (1/2/3)'; if($m -eq '1'){ & $p pbincomArchiveScrape.py } elseif($m -eq '2'){ $u=Read-Host '  Pastebin username to track'; if($u){ & $p pbincomTrackUser.py $u } } elseif($m -eq '3'){ $f=Read-Host '  Local folder path to scan'; if($f){ & $p findSensitiveData.py $f } } else { Write-Host '  Invalid choice.' -ForegroundColor Red }"
echo  %GN%  Scavenger opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU

:LAUNCH_LINK
cls
echo.
echo  %BB%  =======================================================%R%
echo  %WB%  LinkedIn Gatherer  ^|  LinkedIn OSINT%R%
echo  %BB%  =======================================================%R%
echo.
if not exist "%P_LINK%\linkedin_gatherer.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
echo  %YW%  NOTE: This tool was written for Python 2. It may fail on Python 3.%R%
echo  %YW%  If it crashes with NameError: raw_input, it needs a Python 2 fix.%R%
echo  %DG%  Edit credentials first: C:\OSINT\linkedin-gatherer\config.py%R%
echo.
set "HV_PATH=%P_LINK%" & set "HV_REQS=%P_LINK%\requirements.txt"
call :HEALTH_VENV
start "LinkedIn Gatherer" powershell -NoExit -Command "Set-Location 'C:\OSINT\linkedin-gatherer'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  LinkedIn Gatherer  |  LinkedIn Profile OSINT' -ForegroundColor Blue; Write-Host '  Scrapes LinkedIn profiles and network connections.' -ForegroundColor DarkGray; Write-Host '  NOTE: Edit config.py with your LinkedIn credentials first.' -ForegroundColor Yellow; Write-Host '  Type a company name or LinkedIn URL. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host; do { $t=Read-Host '  Target company/URL'; if($t){ & $p linkedin_gatherer.py $t } } while($t)"
echo  %GN%  LinkedIn Gatherer opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU

:LAUNCH_PWND
cls
echo.
echo  %YB%  =======================================================%R%
echo  %WB%  pwnedOrNot  ^|  Email Breach Checker%R%
echo  %YB%  =======================================================%R%
echo.
if not exist "%P_PWND%\pwnedornot.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_PWND%" & set "HV_REQS=%P_PWND%\requirements.txt"
call :HEALTH_VENV
:: Check for API key in config
set "PWND_KEY=0"
powershell -NoProfile -Command "if(Test-Path '%USERPROFILE%\.config\pwnedornot\config.json'){$c=Get-Content '%USERPROFILE%\.config\pwnedornot\config.json' -Raw -EA SilentlyContinue; if($c -match '\"api_key\"\s*:\s*\"[^\"]{5,}\"'){exit 0}else{exit 1}}else{exit 1}" >nul 2>nul && set "PWND_KEY=1"
if "!PWND_KEY!"=="0" goto PWND_SETUP
goto PWND_LAUNCH

:PWND_SETUP
cls
echo.
echo  %YB%  =======================================================%R%
echo  %WB%  pwnedOrNot  ^|  API Key Required%R%
echo  %YB%  =======================================================%R%
echo.
echo  %WH%  pwnedOrNot requires a HaveIBeenPwned API key.%R%
echo  %DG%  Get yours (free tier available) at:%R%
echo  %CY%  https://haveibeenpwned.com/API/Key%R%
echo.
set "HIBP_KEY="
set /p "HIBP_KEY=   Paste your API key >> "
if not defined HIBP_KEY goto MENU
if not exist "%USERPROFILE%\.config\pwnedornot" mkdir "%USERPROFILE%\.config\pwnedornot" >nul 2>&1
(echo {"api_key": "!HIBP_KEY!"}) > "%USERPROFILE%\.config\pwnedornot\config.json"
echo.
echo  %GN%  API key saved.%R%
timeout /t 2 /nobreak >nul

:PWND_LAUNCH
start "pwnedOrNot" powershell -NoExit -Command "Set-Location 'C:\OSINT\pwnedornot'; $p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'}; Write-Host '  pwnedOrNot  |  Email Breach Checker' -ForegroundColor Yellow; Write-Host '  Checks HaveIBeenPwned and searches public dumps for passwords.' -ForegroundColor DarkGray; Write-Host '  Type an email and press Enter. Blank = exit loop.' -ForegroundColor DarkGray; Write-Host; do { $e=Read-Host '  Email'; if($e){ & $p pwnedornot.py -e $e } } while($e)"
echo  %GN%  pwnedOrNot opened in a new window.%R%
echo  %DG%  Switch to it, then press any key here to return to menu.%R%
pause >nul
goto MENU


:: ============================================================
::  COMMAND CENTER  -  Full reference for every tool
:: ============================================================
:COMMAND_CENTER
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%           COMMAND CENTER  ^|  Tool Reference Guide%R%
echo  %CB%  =======================================================%R%
echo.
echo  %DG%  Pick a tool to see all its commands and tips:%R%
echo.
echo  %DG%  --------------------------------------------------------%R%
echo  %MB% [1]%R%  ExifTool        %DG%Read, write, strip file metadata%R%
echo  %YB% [2]%R%  Sherlock        %DG%Hunt usernames across 400+ sites%R%
echo  %ORB% [3]%R%  theHarvester    %DG%Email, subdomain and domain recon%R%
echo  %MGB% [4]%R%  Holehe          %DG%Find accounts linked to an email%R%
echo  %CY% [5]%R%  Maigret         %DG%Deep username OSINT with reports%R%
echo  %WB% [6]%R%  Photon          %DG%Web crawler - extract everything%R%
echo  %BB% [7]%R%  SpiderFoot      %DG%Automated OSINT framework (web UI)%R%
echo  %GB% [8]%R%  Osintgram       %DG%Instagram OSINT interactive session%R%
echo  %RD% [9]%R%  SQLMap          %DG%SQL injection testing and exploitation%R%
echo  %CB%[10]%R%  Scavenger       %DG%Pastebin credential and leak monitor%R%
echo  %BB%[11]%R%  LinkedIn        %DG%LinkedIn profile and network OSINT%R%
echo  %YB%[12]%R%  pwnedOrNot      %DG%Email breach and password lookup%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  [B]%R% Back to menu
echo.
set "CCHO="
set /p "CCHO=   >> "
if not defined CCHO goto COMMAND_CENTER
if /i "%CCHO%"=="1"    goto CMD_EXIF
if /i "%CCHO%"=="2"    goto CMD_SHERL
if /i "%CCHO%"=="3"    goto CMD_HARV
if /i "%CCHO%"=="4"    goto CMD_HOLE
if /i "%CCHO%"=="5"    goto CMD_MAIG
if /i "%CCHO%"=="6"    goto CMD_PHOT
if /i "%CCHO%"=="7"    goto CMD_SPIDER
if /i "%CCHO%"=="8"    goto CMD_OGRAM
if /i "%CCHO%"=="9"    goto CMD_SQLM
if /i "%CCHO%"=="10"   goto CMD_SCAV
if /i "%CCHO%"=="11"   goto CMD_LINK
if /i "%CCHO%"=="12"   goto CMD_PWND
if /i "%CCHO%"=="B"    goto MENU
if /i "%CCHO%"=="back" goto MENU
goto COMMAND_CENTER


:CMD_EXIF
cls
echo.
echo  %MB%  =======================================================%R%
echo  %WB%  ExifTool  ^|  Full Command Reference%R%
echo  %MB%  =======================================================%R%
echo.
echo  %WB%  READ METADATA%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  .\exiftool.exe photo.jpg%R%
echo  %DG%    Show every metadata tag in the file%R%
echo.
echo  %CY%  .\exiftool.exe -Author -DateTimeOriginal -Make -Model photo.jpg%R%
echo  %DG%    Show only specific tags (author, date taken, camera make/model)%R%
echo.
echo  %CY%  .\exiftool.exe -gps:all photo.jpg%R%
echo  %DG%    Show GPS latitude, longitude, altitude and direction%R%
echo.
echo  %CY%  .\exiftool.exe -json photo.jpg%R%
echo  %DG%    Output all metadata as JSON (great for scripting)%R%
echo.
echo  %CY%  .\exiftool.exe -csv -r C:\Photos\%R%
echo  %DG%    Scan entire folder recursively and export all metadata as CSV%R%
echo.
echo  %WB%  WRITE / EDIT METADATA%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  .\exiftool.exe -Author="John Doe" photo.jpg%R%
echo  %DG%    Set the author/creator field%R%
echo.
echo  %CY%  .\exiftool.exe -GPSLatitude=51.5074 -GPSLongitude=-0.1278 photo.jpg%R%
echo  %DG%    Inject GPS coordinates (London example)%R%
echo.
echo  %CY%  .\exiftool.exe -Comment="My comment" photo.jpg%R%
echo  %DG%    Add a text comment to the file%R%
echo.
echo  %WB%  STRIP METADATA  (Privacy / OPSEC)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  .\exiftool.exe -all= photo.jpg%R%
echo  %DG%    STRIP ALL metadata - safe to share after this%R%
echo.
echo  %CY%  .\exiftool.exe -gps:all= photo.jpg%R%
echo  %DG%    Remove GPS data only, keep everything else%R%
echo.
echo  %CY%  .\exiftool.exe -all= -r C:\Photos\ -overwrite_original%R%
echo  %DG%    Strip all files in folder recursively, no backup created%R%
echo.
echo  %WB%  TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Original is backed up as filename_original by default%R%
echo  %DG%  - Add -overwrite_original to skip backup%R%
echo  %DG%  - Supports: JPG PNG TIFF PDF MP4 MOV RAW and 200+ more%R%
echo  %DG%  - Drag files onto the PS window to paste the full path%R%
echo.
pause
goto COMMAND_CENTER


:CMD_SHERL
cls
echo.
echo  %YB%  =======================================================%R%
echo  %WB%  Sherlock  ^|  Full Command Reference%R%
echo  %YB%  =======================================================%R%
echo.
echo  %WB%  BASIC SEARCH%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m sherlock_project username%R%
echo  %DG%    Search for username across 400+ social media sites%R%
echo.
echo  %CY%  python -m sherlock_project user1 user2 user3%R%
echo  %DG%    Search multiple usernames simultaneously%R%
echo.
echo  %WB%  SAVE OUTPUT%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m sherlock_project username --output results.txt%R%
echo  %DG%    Save found links to a text file%R%
echo.
echo  %CY%  python -m sherlock_project username --csv%R%
echo  %DG%    Save results as a CSV spreadsheet (username.csv)%R%
echo.
echo  %CY%  python -m sherlock_project username --xlsx%R%
echo  %DG%    Save results as Excel file%R%
echo.
echo  %CY%  python -m sherlock_project username --folderoutput C:\Reports\%R%
echo  %DG%    Save all output files to a specific folder%R%
echo.
echo  %WB%  FILTER OUTPUT%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m sherlock_project username --print-found%R%
echo  %DG%    Only show sites WHERE account was found (cleaner)%R%
echo.
echo  %CY%  python -m sherlock_project username --print-all%R%
echo  %DG%    Show all sites checked including not-found%R%
echo.
echo  %WB%  PERFORMANCE%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m sherlock_project username --timeout 5%R%
echo  %DG%    5 second timeout per site - faster but may miss slow sites%R%
echo.
echo  %CY%  python -m sherlock_project username --timeout 60%R%
echo  %DG%    60 second timeout - thorough but slower%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Try variations: john, john123, j0hn, john_doe, johndoe%R%
echo  %DG%  - Results auto-saved to username.txt in current folder%R%
echo  %DG%  - Sites: Twitter/X, GitHub, Reddit, TikTok, Instagram,%R%
echo  %DG%    LinkedIn, Steam, Twitch, YouTube, Pinterest, 390+ more%R%
echo  %DG%  - Green = found  |  Red = not found  |  Yellow = uncertain%R%
echo.
pause
goto COMMAND_CENTER


:CMD_HARV
cls
echo.
echo  %ORB%  =======================================================%R%
echo  %WB%  theHarvester  ^|  Full Command Reference%R%
echo  %ORB%  =======================================================%R%
echo.
echo  %WB%  BASIC SEARCH%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m theHarvester -d example.com -b google%R%
echo  %DG%    Harvest emails and subdomains via Google%R%
echo.
echo  %CY%  python -m theHarvester -d example.com -b bing%R%
echo  %DG%    Same but using Bing (finds different results)%R%
echo.
echo  %CY%  python -m theHarvester -d example.com -b google,bing,yahoo,duckduckgo%R%
echo  %DG%    Multiple sources at once - more coverage%R%
echo.
echo  %CY%  python -m theHarvester -d example.com -b all%R%
echo  %DG%    ALL available sources - most thorough scan%R%
echo.
echo  %WB%  CONTROL RESULTS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m theHarvester -d example.com -b google -l 200%R%
echo  %DG%    Limit to 200 results per source (default 500)%R%
echo.
echo  %CY%  python -m theHarvester -d example.com -b google -S 100%R%
echo  %DG%    Skip first 100, start from result 101%R%
echo.
echo  %WB%  SAVE REPORTS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m theHarvester -d example.com -b all -f report%R%
echo  %DG%    Save as report.html and report.xml%R%
echo.
echo  %WB%  AVAILABLE SOURCES  (use with -b)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  google  bing  yahoo  duckduckgo  linkedin  twitter%R%
echo  %DG%  virustotal  crtsh  dnsdumpster  rapiddns  urlscan%R%
echo  %DG%  baidu  hunter  anubis  sublist3r  all%R%
echo.
echo  %WB%  WHAT IT FINDS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Email addresses at the domain%R%
echo  %DG%  Subdomains and virtual hosts%R%
echo  %DG%  Employee names and LinkedIn profiles%R%
echo  %DG%  IP addresses and ASN information%R%
echo  %DG%  Linked social media accounts%R%
echo.
pause
goto COMMAND_CENTER


:CMD_HOLE
cls
echo.
echo  %MGB%  =======================================================%R%
echo  %WB%  Holehe  ^|  Full Command Reference%R%
echo  %MGB%  =======================================================%R%
echo.
echo  %WB%  BASIC USAGE%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m holehe target@email.com%R%
echo  %DG%    Check if this email is registered on 120+ websites%R%
echo.
echo  %WB%  FILTER OUTPUT%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m holehe target@email.com --only-used%R%
echo  %DG%    Only print sites where an account WAS found (cleaner)%R%
echo.
echo  %WB%  OPTIONS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m holehe target@email.com --no-color%R%
echo  %DG%    Disable ANSI colors%R%
echo.
echo  %CY%  python -m holehe target@email.com --timeout 15%R%
echo  %DG%    Per-request timeout in seconds (default 7)%R%
echo.
echo  %WB%  SITES CHECKED (120+)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Instagram  Twitter  TikTok  Snapchat  LinkedIn%R%
echo  %DG%  Pinterest  Reddit   Twitch  Steam     Spotify%R%
echo  %DG%  Netflix    Adobe    Dropbox GitHub    GitLab%R%
echo  %DG%  WordPress  Tumblr   Imgur   Flickr    + 100 more%R%
echo.
echo  %WB%  READING RESULTS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Green  [+] = Account EXISTS on that site%R%
echo  %DG%  Red    [-] = No account found%R%
echo  %DG%  Yellow [~] = Used but result uncertain or rate-limited%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Works best with real active email addresses%R%
echo  %DG%  - Use --only-used for a clean list of confirmed accounts%R%
echo  %DG%  - Combine with Sherlock: Holehe = email, Sherlock = username%R%
echo.
pause
goto COMMAND_CENTER


:CMD_MAIG
cls
echo.
echo  %CY%  =======================================================%R%
echo  %WB%  Maigret  ^|  Full Command Reference%R%
echo  %CY%  =======================================================%R%
echo.
echo  %WB%  BASIC SEARCH%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m maigret username%R%
echo  %DG%    Search on 3000+ sites with auto account linking%R%
echo.
echo  %CY%  python -m maigret username1 username2%R%
echo  %DG%    Search multiple usernames at once%R%
echo.
echo  %WB%  REPORTS  (auto-saved to reports/ folder)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m maigret username --html%R%
echo  %DG%    HTML report with interactive network graph - BEST option%R%
echo.
echo  %CY%  python -m maigret username --pdf%R%
echo  %DG%    PDF report (requires weasyprint)%R%
echo.
echo  %CY%  python -m maigret username -j%R%
echo  %DG%    JSON report for programmatic use%R%
echo.
echo  %CY%  python -m maigret username --folderoutput C:\Reports\%R%
echo  %DG%    Save all reports to a specific folder%R%
echo.
echo  %WB%  SPEED AND SCOPE%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python -m maigret username --top-sites 500%R%
echo  %DG%    Only check top 500 sites (faster)%R%
echo.
echo  %CY%  python -m maigret username --top-sites 1500%R%
echo  %DG%    Top 1500 sites - good balance%R%
echo.
echo  %CY%  python -m maigret username -a%R%
echo  %DG%    Aggressive mode - more detection techniques%R%
echo.
echo  %CY%  python -m maigret username --timeout 30%R%
echo  %DG%    Increase timeout for slow connections%R%
echo.
echo  %CY%  python -m maigret username --no-recursion%R%
echo  %DG%    Disable automatic following of linked accounts%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - --html gives the best output with a visual network graph%R%
echo  %DG%  - Auto-discovers linked accounts on other platforms%R%
echo  %DG%  - Extracts full name, bio, and profile pictures from finds%R%
echo  %DG%  - Check the reports/ folder after scan for saved results%R%
echo.
pause
goto COMMAND_CENTER


:CMD_PHOT
cls
echo.
echo  %WB%  =======================================================%R%
echo  %WB%  Photon  ^|  Full Command Reference%R%
echo  %WB%  =======================================================%R%
echo.
echo  %WB%  BASIC CRAWL%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python photon.py -u https://target.com%R%
echo  %DG%    Crawl website at default depth level 2%R%
echo.
echo  %WB%  CRAWL DEPTH%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python photon.py -u https://target.com --level 1%R%
echo  %DG%    Surface pages only - very fast%R%
echo.
echo  %CY%  python photon.py -u https://target.com --level 3%R%
echo  %DG%    Good balance of depth vs speed%R%
echo.
echo  %CY%  python photon.py -u https://target.com --level 10%R%
echo  %DG%    Maximum depth - can take a long time on large sites%R%
echo.
echo  %WB%  PERFORMANCE%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python photon.py -u https://target.com --threads 10%R%
echo  %DG%    10 parallel threads (default 2) - much faster%R%
echo.
echo  %CY%  python photon.py -u https://target.com --delay 1%R%
echo  %DG%    Wait 1 second between requests to avoid rate limits%R%
echo.
echo  %CY%  python photon.py -u https://target.com --timeout 10%R%
echo  %DG%    Per-request timeout in seconds%R%
echo.
echo  %WB%  WHAT TO EXTRACT%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python photon.py -u https://target.com --keys%R%
echo  %DG%    Find API keys, tokens and secrets in page source%R%
echo.
echo  %CY%  python photon.py -u https://target.com --dns%R%
echo  %DG%    Extract DNS information about the domain%R%
echo.
echo  %CY%  python photon.py -u https://target.com --headers%R%
echo  %DG%    Capture HTTP response headers from every page%R%
echo.
echo  %CY%  python photon.py -u https://target.com --only-urls%R%
echo  %DG%    Extract URLs only, skip everything else%R%
echo.
echo  %WB%  SAVE OUTPUT%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python photon.py -u https://target.com -o C:\output\%R%
echo  %DG%    Save all extracted data to a folder%R%
echo.
echo  %WB%  WHAT IT FINDS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  URLs, emails, phone numbers, social media links%R%
echo  %DG%  API keys and tokens, JavaScript files, external links%R%
echo  %DG%  Subdomains, form fields, source code comments%R%
echo.
pause
goto COMMAND_CENTER


:CMD_SPIDER
cls
echo.
echo  %BB%  =======================================================%R%
echo  %WB%  SpiderFoot  ^|  How To Use Guide%R%
echo  %BB%  =======================================================%R%
echo.
echo  %WB%  STEP-BY-STEP: RUNNING A SCAN%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %GN%  1.%R%  Press [3] on the menu to launch SpiderFoot%R%
echo  %GN%  2.%R%  Open your browser: %CY%http://127.0.0.1:5001%R%
echo  %GN%  3.%R%  Wait ~5 seconds for the page to load%R%
echo  %GN%  4.%R%  Click %WB%"New Scan"%R%
echo  %GN%  5.%R%  Enter a target (types listed below)%R%
echo  %GN%  6.%R%  Choose a scan mode (Passive = stealthy, All = full)%R%
echo  %GN%  7.%R%  Click %WB%"Run Scan"%R% - results stream in real-time%R%
echo  %GN%  8.%R%  Done: click your scan ^> Browse tab ^> Export%R%
echo.
echo  %WB%  SUPPORTED TARGET TYPES%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  Domain name%R%      %DG%example.com%R%
echo  %CY%  IP / subnet%R%      %DG%192.168.1.1  or  10.0.0.0/8%R%
echo  %CY%  Email address%R%    %DG%person@example.com%R%
echo  %CY%  Person name%R%      %DG%John Smith%R%
echo  %CY%  Username%R%         %DG%john_doe%R%
echo  %CY%  Phone number%R%     %DG%+12025551234%R%
echo  %CY%  Bitcoin address%R%  %DG%1A2B3C...%R%
echo.
echo  %WB%  SCAN MODES%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  Passive%R%  %DG%No direct contact. Uses public OSINT only. Stealthy.%R%
echo  %CY%  Active%R%   %DG%Contacts target directly. More data, detectable.%R%
echo  %CY%  All%R%      %DG%Every module. Maximum data. Target may detect.%R%
echo.
echo  %WB%  EXPORT FORMATS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  CSV, JSON, GEXF (Gephi graph), PDF, TIE (graph format)%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Passive mode alone finds a huge amount of data%R%
echo  %DG%  - The graph view shows connections between found entities%R%
echo  %DG%  - You can run multiple scans and compare%R%
echo  %DG%  - Module list: Settings ^> Modules to enable/disable sources%R%
echo.
pause
goto COMMAND_CENTER


:CMD_OGRAM
cls
echo.
echo  %GB%  =======================================================%R%
echo  %WB%  Osintgram  ^|  Full Command Reference%R%
echo  %GB%  =======================================================%R%
echo.
echo  %WB%  SETUP (one-time)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Press [I] on the HOME TOOLS main menu%R%
echo  %DG%  OR type 'creds' at the main menu prompt%R%
echo  %DG%  Enter your Instagram username and password%R%
echo  %DG%  Use a SECONDARY account - not your personal one%R%
echo  %DG%  2FA must be DISABLED on that account%R%
echo.
echo  %WB%  LAUNCHING%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python main.py targetusername%R%
echo  %DG%    Start an interactive OSINT session for that target%R%
echo.
echo  %WB%  INTERACTIVE COMMANDS  (type inside the session)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  info%R%               %DG%Full profile: bio, followers, verified, private%R%
echo  %CY%  followers%R%          %DG%List ALL followers with profile links%R%
echo  %CY%  followings%R%         %DG%List everyone the target follows%R%
echo  %CY%  fwingsnfollowers%R%   %DG%Follows them but they don't follow back%R%
echo  %CY%  total followers%R%    %DG%Follower count only%R%
echo  %CY%  propic%R%             %DG%Download full-size profile picture%R%
echo  %CY%  photos%R%             %DG%Download ALL posted photos%R%
echo  %CY%  stories%R%            %DG%View and download current stories%R%
echo  %CY%  highlights%R%         %DG%Download all story highlights%R%
echo  %CY%  tagged%R%             %DG%Photos the target has been tagged in%R%
echo  %CY%  wtagged%R%            %DG%Who has tagged the target in photos%R%
echo  %CY%  comments%R%           %DG%Scrape all comments from posts%R%
echo  %CY%  captions%R%           %DG%All post captions and text content%R%
echo  %CY%  hashtags%R%           %DG%Most-used hashtags (reveals interests)%R%
echo  %CY%  addrs%R%              %DG%Locations / addresses tagged in posts%R%
echo  %CY%  mediatype%R%          %DG%Ratio of photos vs videos posted%R%
echo  %CY%  similar_accounts%R%   %DG%Instagram accounts similar to target%R%
echo  %CY%  exit%R%               %DG%Exit the session%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Private accounts: only basic info is visible%R%
echo  %DG%  - Combine hashtags + addrs to map real-world locations%R%
echo  %DG%  - followers + comments reveals who interacts most%R%
echo  %DG%  - Downloaded content saved to output/ folder%R%
echo.
pause
goto COMMAND_CENTER


:CMD_SQLM
cls
echo.
echo  %RD%  =======================================================%R%
echo  %WB%  SQLMap  ^|  Full Command Reference%R%
echo  %RD%  =======================================================%R%
echo.
echo  %WB%  BASIC DETECTION%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python sqlmap.py -u "http://site.com/page.php?id=1"%R%
echo  %DG%    Auto-detect SQL injection on that URL parameter%R%
echo.
echo  %CY%  python sqlmap.py -u "http://site.com/page.php?id=1" --batch%R%
echo  %DG%    Same but auto-answers all prompts (non-interactive)%R%
echo.
echo  %WB%  ENUMERATE DATABASES%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python sqlmap.py -u "URL?id=1" --dbs%R%
echo  %DG%    List all databases on the server%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" --current-db%R%
echo  %DG%    Show which database the app is using%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" --current-user%R%
echo  %DG%    Show which database user the app runs as%R%
echo.
echo  %WB%  EXTRACT DATA%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python sqlmap.py -u "URL?id=1" -D shopdb --tables%R%
echo  %DG%    List all tables in the "shopdb" database%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" -D shopdb -T users --columns%R%
echo  %DG%    List all columns in the "users" table%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" -D shopdb -T users --dump%R%
echo  %DG%    Dump the entire users table%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" -D shopdb -T users -C "user,pass" --dump%R%
echo  %DG%    Dump only specific columns%R%
echo.
echo  %WB%  INCREASE POWER%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python sqlmap.py -u "URL?id=1" --level 5 --risk 3%R%
echo  %DG%    Maximum detection - slow but finds everything%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" --dbms=mysql%R%
echo  %DG%    Target a specific DB type: mysql mssql oracle postgresql sqlite%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" -p id%R%
echo  %DG%    Test only the "id" parameter specifically%R%
echo.
echo  %WB%  POST FORMS / LOGIN PAGES%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python sqlmap.py -u "http://site.com/login" --data="user=x^&pass=y"%R%
echo  %DG%    Test a POST form (replace field names as needed)%R%
echo.
echo  %CY%  python sqlmap.py -r request.txt --batch%R%
echo  %DG%    Load a saved HTTP request from Burp Suite%R%
echo.
echo  %WB%  ADVANCED%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python sqlmap.py -u "URL?id=1" --cookie="session=abc123"%R%
echo  %DG%    Include session cookie to test while authenticated%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" --headers="Authorization: Bearer TOKEN"%R%
echo  %DG%    Add custom HTTP header (API tokens, auth headers)%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" --proxy=http://127.0.0.1:8080%R%
echo  %DG%    Route through Burp Suite to see all requests%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" --os-shell%R%
echo  %DG%    Attempt OS shell if DB user has FILE privilege%R%
echo.
echo  %CY%  python sqlmap.py -u "URL?id=1" --tor --check-tor%R%
echo  %DG%    Route all traffic through Tor for anonymity%R%
echo.
echo  %YW%  Only test systems you own or have written permission to test.%R%
echo.
pause
goto COMMAND_CENTER


:CMD_SCAV
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%  Scavenger  ^|  Full Command Reference%R%
echo  %CB%  =======================================================%R%
echo.
echo  %WB%  WHAT IT DOES%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Monitors Pastebin.com and scans for leaked credentials,%R%
echo  %DG%  API keys, RSA private keys, database dumps and .onion links.%R%
echo.
echo  %WB%  MODE 1 - ARCHIVE SCRAPE%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python pbincomArchiveScrape.py%R%
echo  %DG%    Continuously crawls the Pastebin archive for sensitive data%R%
echo  %DG%    Stores pastes and flags matches to your search terms%R%
echo  %DG%    Archives after 48,000 pastes and starts fresh%R%
echo.
echo  %WB%  MODE 2 - TRACK A USER%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python pbincomTrackUser.py username%R%
echo  %DG%    Monitors a specific Pastebin user's posts in real-time%R%
echo  %DG%    Useful for tracking known leak accounts%R%
echo.
echo  %WB%  MODE 3 - SCAN LOCAL FOLDER%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python findSensitiveData.py C:\path\to\folder%R%
echo  %DG%    Scans text files on disk for credentials / sensitive patterns%R%
echo.
echo  %WB%  CONFIGURE SEARCH TERMS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Edit: C:\OSINT\scavenger\configs\searchterms.txt%R%
echo  %DG%  Default terms: passwords, database credentials, RSA keys, API keys%R%
echo  %DG%  Add your own keywords - one per line%R%
echo.
echo  %WB%  OUTPUT%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Matching pastes saved to: C:\OSINT\scavenger\data\%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Add company names or domain names to searchterms.txt%R%
echo  %DG%  - Run archive scrape continuously for live monitoring%R%
echo  %DG%  - Check the data\ folder for collected hits%R%
echo.
pause
goto COMMAND_CENTER


:CMD_LINK
cls
echo.
echo  %BB%  =======================================================%R%
echo  %WB%  LinkedIn Gatherer  ^|  Full Command Reference%R%
echo  %BB%  =======================================================%R%
echo.
echo  %WB%  SETUP FIRST (one time)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Edit: C:\OSINT\linkedin-gatherer\config.py%R%
echo  %DG%  Add your LinkedIn username and password to the file%R%
echo  %DG%  Optionally add a proxy to avoid LinkedIn rate limits%R%
echo.
echo  %WB%  PYTHON 2 WARNING%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %YW%  This tool was written for Python 2 and uses raw_input().%R%
echo  %YW%  It may crash on Python 3 with NameError: raw_input%R%
echo  %YW%  Fix: open linkedin_gatherer.py and replace raw_input with input%R%
echo.
echo  %WB%  BASIC USAGE%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python linkedin_gatherer.py%R%
echo  %DG%    Interactive session - prompts for company name or LinkedIn URL%R%
echo.
echo  %CY%  python linkedin_gatherer.py -c "Company Name"%R%
echo  %DG%    Search for employees at a specific company%R%
echo.
echo  %WB%  WHAT IT FINDS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  First and last names of company employees%R%
echo  %DG%  LinkedIn profile URLs%R%
echo  %DG%  Job titles and roles%R%
echo  %DG%  Network connection data%R%
echo  %DG%  Output saved as CSV file%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Pair with theHarvester: HARV finds emails, LINK maps names%R%
echo  %DG%  - Use a secondary LinkedIn account - not your personal one%R%
echo  %DG%  - Add a proxy in config.py if you hit rate limits%R%
echo  %DG%  - LinkedIn ToS prohibits scraping - use responsibly%R%
echo.
pause
goto COMMAND_CENTER


:CMD_PWND
cls
echo.
echo  %YB%  =======================================================%R%
echo  %WB%  pwnedOrNot  ^|  Full Command Reference%R%
echo  %YB%  =======================================================%R%
echo.
echo  %WB%  SETUP (one time)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Get a free API key from: https://haveibeenpwned.com/API/Key%R%
echo  %DG%  Enter it when prompted by the tool on first launch%R%
echo  %DG%  Key stored at: %USERPROFILE%\.config\pwnedornot\config.json%R%
echo.
echo  %WB%  BASIC USAGE%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python pwnedornot.py -e target@email.com%R%
echo  %DG%    Check one email against all known data breaches%R%
echo.
echo  %CY%  python pwnedornot.py -f emails.txt%R%
echo  %DG%    Check a list of emails from a text file (one per line)%R%
echo.
echo  %WB%  OUTPUT OPTIONS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  python pwnedornot.py -e email@target.com -s%R%
echo  %DG%    Save results to output file%R%
echo.
echo  %CY%  python pwnedornot.py -e email@target.com --list%R%
echo  %DG%    List ALL known breaches (no email required)%R%
echo.
echo  %WB%  WHAT IT FINDS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Which data breaches the email appears in%R%
echo  %DG%  Breach name, domain, date and data types exposed%R%
echo  %DG%  Searches public password dumps for leaked passwords%R%
echo  %DG%  Pastebin mentions of the email address%R%
echo.
echo  %WB%  PRO TIPS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  - Run on every email you find with theHarvester or Holehe%R%
echo  %DG%  - Found passwords can reveal password patterns the target uses%R%
echo  %DG%  - Use -f to batch-check a whole list of discovered emails%R%
echo  %DG%  - Combine: HARV finds emails, pwnedOrNot checks each one%R%
echo.
pause
goto COMMAND_CENTER


:: ============================================================
::  REPAIR
:: ============================================================
:REPAIR
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%  REPAIR / UPDATE TOOLS%R%
echo  %CB%  =======================================================%R%
echo.
echo  %WH%  This will re-run all install and update checks.%R%
echo  %DG%  Missing tools will be cloned. Installed tools will be updated.%R%
echo  %DG%  Broken venvs will be rebuilt automatically.%R%
echo.
echo  %WH%  Continue? [Y/N]%R%
echo.
set "CFM="
set /p "CFM=   >> "
if not defined CFM goto MENU
if /i not "%CFM%"=="Y" goto MENU
goto STARTUP


:: ============================================================
::  HELP
:: ============================================================
:HELP
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%  HELP  ^|  HOME TOOLS v3.0%R%
echo  %CB%  =======================================================%R%
echo.
echo  %WB%  HOW TO USE%R%
echo  %DG%  Type a number 1-11 and press ENTER to launch a tool.%R%
echo  %DG%  Tools install automatically on first launch.%R%
echo  %DG%  Type [C] for the Command Center - full commands for every tool.%R%
echo  %DG%  Type [I] to set or update your Instagram credentials.%R%
echo.
echo  %WB%  TOOLS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CB%  1%R%   JLT Edge Wireless   %DG%OemDrv device manager%R%
echo  %CB%  2%R%   Scanners            %DG%ESET / F-Secure / HitmanPro submenu%R%
echo  %BB%  3%R%   SpiderFoot          %DG%OSINT web UI at http://127.0.0.1:5001%R%
echo  %MB%  4%R%   ExifTool            %DG%Read/write/strip file metadata%R%
echo  %YB%  5%R%   Sherlock            %DG%Username hunt across 400+ sites%R%
echo  %GB%  6%R%   Osintgram           %DG%Instagram OSINT (requires burner account)%R%
echo  %ORB%  7%R%   theHarvester        %DG%Email/subdomain recon for a domain%R%
echo  %MGB%  8%R%   Holehe              %DG%Check email against 120+ sites%R%
echo  %CY%  9%R%   Maigret             %DG%Deep username OSINT with HTML reports%R%
echo  %WB% 10%R%   Photon              %DG%Web crawler: emails, URLs, API keys%R%
echo  %RD% 11%R%   SQLMap              %DG%SQL injection scanner%R%
echo.
echo  %WB%  MENU OPTIONS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  C%R%   Command Center - every command for every tool
echo  %CY%  R%R%   Repair - force reinstall and update all tools
echo  %CY%  I%R%   Instagram - set or update Osintgram credentials
echo  %CY%  Q%R%   Quit
echo.
echo  %WB%  REQUIREMENTS%R%
echo  %DG%  Python 3.10+  and  git  must both be in PATH.%R%
echo  %DG%  Internet access needed for first install and updates.%R%
echo.
echo  %WB%  INSTALL LOCATIONS%R%
echo  %DG%  OSINT tools:  C:\OSINT\%R%
echo  %DG%  ExifTool:     C:\Tools\exiftool\%R%
echo.
echo  %WB%  STATUS INDICATORS%R%
echo  %DG%  %GN%[OK]%DG% = Tool ready to use%R%
echo  %DG%  %RD%[--]%DG% = Not installed yet (runs at startup / use Repair)%R%
echo  %DG%  %RD%[!!]%DG% = Local file missing (check your Stuff folder)%R%
echo.
pause
goto MENU


:: ============================================================
::  QUIT
:: ============================================================
:QUIT
cls
echo.
echo  %CY%  Goodbye.%R%
echo  %DG%  Made with love by vortexdq.com%R%
echo.
timeout /t 1 /nobreak >nul
exit /b 0


:: ============================================================
::  STARTUP CHECK SUBROUTINES  (one per tool)
:: ============================================================

:SC_SPIDER
echo.
echo  %BB%  [3] SpiderFoot%R%
if exist "%P_SPIDER%\sf.py" goto :SC_SPIDER_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_SPIDER_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_SPIDER_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_SPIDER_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_SPIDER_FUNC
goto :SC_SPIDER_END
:SC_SPIDER_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_SPIDER_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_SPIDER_END)
set "GIT_PATH=%P_SPIDER%" & set "GIT_NAME=SpiderFoot" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_SPIDER_END
if exist "%P_SPIDER%\sf.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_EXIF
echo.
echo  %MB%  [4] ExifTool%R%
if exist "%P_EXIF%\exiftool.exe" goto :SC_EXIF_UPD
if "!HAS_NET!"=="0" (echo  %RD%    Offline - cannot download.%R%  & goto :SC_EXIF_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_EXIF_FUNC
goto :SC_EXIF_END
:SC_EXIF_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_EXIF_END)
call :UPDATE_EXIF_FUNC
:SC_EXIF_END
if exist "%P_EXIF%\exiftool.exe" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_SHERL
echo.
echo  %YB%  [5] Sherlock%R%
if exist "%P_SHERL%\sherlock_project" goto :SC_SHERL_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_SHERL_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_SHERL_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_SHERL_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_SHERL_FUNC
goto :SC_SHERL_END
:SC_SHERL_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_SHERL_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_SHERL_END)
set "GIT_PATH=%P_SHERL%" & set "GIT_NAME=Sherlock" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_SHERL_END
if exist "%P_SHERL%\sherlock_project" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_OGRAM
echo.
echo  %GB%  [6] Osintgram%R%
if exist "%P_OGRAM%\main.py" goto :SC_OGRAM_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_OGRAM_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_OGRAM_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_OGRAM_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_OGRAM_FUNC
goto :SC_OGRAM_END
:SC_OGRAM_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_OGRAM_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_OGRAM_END)
set "GIT_PATH=%P_OGRAM%" & set "GIT_NAME=Osintgram" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_OGRAM_END
if exist "%P_OGRAM%\main.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_HARV
echo.
echo  %ORB%  [7] theHarvester%R%
if exist "%P_HARV%\theHarvester\__main__.py" goto :SC_HARV_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_HARV_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_HARV_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_HARV_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_HARV_FUNC
goto :SC_HARV_END
:SC_HARV_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_HARV_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_HARV_END)
set "GIT_PATH=%P_HARV%" & set "GIT_NAME=theHarvester" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_HARV_END
if exist "%P_HARV%\theHarvester\__main__.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_HOLE
echo.
echo  %MGB%  [8] Holehe%R%
if exist "%P_HOLE%\holehe" goto :SC_HOLE_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_HOLE_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_HOLE_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_HOLE_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_HOLE_FUNC
goto :SC_HOLE_END
:SC_HOLE_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_HOLE_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_HOLE_END)
set "GIT_PATH=%P_HOLE%" & set "GIT_NAME=Holehe" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_HOLE_END
if exist "%P_HOLE%\holehe" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_MAIG
echo.
echo  %CY%  [9] Maigret%R%
if exist "%P_MAIG%\maigret" goto :SC_MAIG_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_MAIG_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_MAIG_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_MAIG_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_MAIG_FUNC
goto :SC_MAIG_END
:SC_MAIG_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_MAIG_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_MAIG_END)
set "GIT_PATH=%P_MAIG%" & set "GIT_NAME=Maigret" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_MAIG_END
if exist "%P_MAIG%\maigret" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_PHOT
echo.
echo  %WB%  [10] Photon%R%
if exist "%P_PHOT%\photon.py" goto :SC_PHOT_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_PHOT_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_PHOT_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_PHOT_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_PHOT_FUNC
goto :SC_PHOT_END
:SC_PHOT_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_PHOT_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_PHOT_END)
set "GIT_PATH=%P_PHOT%" & set "GIT_NAME=Photon" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_PHOT_END
if exist "%P_PHOT%\photon.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_SQLM
echo.
echo  %RD%  [11] SQLMap%R%
if exist "%P_SQLM%\sqlmap.py" goto :SC_SQLM_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_SQLM_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_SQLM_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_SQLM_FUNC
goto :SC_SQLM_END
:SC_SQLM_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_SQLM_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_SQLM_END)
set "GIT_PATH=%P_SQLM%" & set "GIT_NAME=SQLMap" & set "GIT_REQS=0"
call :GIT_CHECK_UPDATE
:SC_SQLM_END
if exist "%P_SQLM%\sqlmap.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_SCAV
echo.
echo  %CB%  [12] Scavenger%R%
if exist "%P_SCAV%\scavenger.py" goto :SC_SCAV_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_SCAV_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_SCAV_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_SCAV_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_SCAV_FUNC
goto :SC_SCAV_END
:SC_SCAV_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_SCAV_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_SCAV_END)
set "GIT_PATH=%P_SCAV%" & set "GIT_NAME=Scavenger" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_SCAV_END
if exist "%P_SCAV%\scavenger.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_LINK
echo.
echo  %BB%  [13] LinkedIn Gatherer%R%
if exist "%P_LINK%\linkedin_gatherer.py" goto :SC_LINK_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_LINK_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_LINK_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_LINK_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_LINK_FUNC
goto :SC_LINK_END
:SC_LINK_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_LINK_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed. (Python 2 tool - may need fixes)%R% & goto :SC_LINK_END)
set "GIT_PATH=%P_LINK%" & set "GIT_NAME=LinkedIn Gatherer" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_LINK_END
if exist "%P_LINK%\linkedin_gatherer.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_PWND
echo.
echo  %YB%  [14] pwnedOrNot%R%
if exist "%P_PWND%\pwnedornot.py" goto :SC_PWND_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_PWND_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_PWND_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_PWND_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_PWND_FUNC
goto :SC_PWND_END
:SC_PWND_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_PWND_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_PWND_END)
set "GIT_PATH=%P_PWND%" & set "GIT_NAME=pwnedOrNot" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
:SC_PWND_END
if exist "%P_PWND%\pwnedornot.py" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF


:: ============================================================
::  GIT UPDATE HELPER
::  Set GIT_PATH, GIT_NAME, GIT_REQS (1=has reqs, 0=no reqs)
:: ============================================================
:GIT_CHECK_UPDATE
echo  %DG%    Checking for updates...%R%
git -C "%GIT_PATH%" pull --ff-only > "%TEMP%\ht_gp.txt" 2>&1
if errorlevel 1 goto :GCU_FAIL
findstr /I "Already up to date" "%TEMP%\ht_gp.txt" >nul 2>&1
del "%TEMP%\ht_gp.txt" 2>nul
if not errorlevel 1 goto :GCU_OK
goto :GCU_UPDATED
:GCU_OK
echo  %GN%    Up to date.%R%
goto :EOF
:GCU_UPDATED
echo  %YW%    Updated - refreshing dependencies...%R%
del "%GIT_PATH%\venv\.health" 2>nul
if not "%GIT_REQS%"=="1" goto :EOF
if exist "%GIT_PATH%\requirements.txt"  if exist "%GIT_PATH%\venv\Scripts\python.exe" "%GIT_PATH%\venv\Scripts\python.exe" -m pip install -r "%GIT_PATH%\requirements.txt" --quiet --prefer-binary 2>nul
if exist "%GIT_PATH%\pyproject.toml"    if exist "%GIT_PATH%\venv\Scripts\python.exe" "%GIT_PATH%\venv\Scripts\python.exe" -m pip install -e "%GIT_PATH%" --quiet 2>nul
goto :EOF
:GCU_FAIL
del "%TEMP%\ht_gp.txt" 2>nul
echo  %DG%    Update skipped (offline or local changes detected).%R%
goto :EOF


:: ============================================================
::  INSTALL FUNCTIONS
:: ============================================================

:INSTALL_SPIDER_FUNC
if exist "%P_SPIDER%\sf.py" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning SpiderFoot...%R%
git clone https://github.com/smicallef/spiderfoot "%P_SPIDER%"
if not exist "%P_SPIDER%\sf.py" (echo  %RD%    Clone failed - check internet and git.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_SPIDER%\venv"
"%P_SPIDER%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_SPIDER%\venv\Scripts\python.exe" -m pip install -r "%P_SPIDER%\requirements.txt" --quiet --prefer-binary
copy nul "%P_SPIDER%\venv\.health" >nul 2>&1
echo  %GN%    SpiderFoot installed.%R%
goto :EOF

:INSTALL_EXIF_FUNC
if exist "%P_EXIF%\exiftool.exe" (echo  %GN%    Already installed.%R% & goto :EOF)
if not exist "%P_EXIF%" mkdir "%P_EXIF%"
echo  %WH%    Downloading ExifTool (latest stable)...%R%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$v=(Invoke-WebRequest 'https://exiftool.org/ver.txt' -UseBasicParsing -TimeoutSec 15).Content.Trim(); Write-Host('    Downloading v'+$v+'...'); $z='C:\Tools\exiftool\et.zip'; Invoke-WebRequest ('https://exiftool.org/exiftool-'+$v+'_64.zip') -OutFile $z -UseBasicParsing -TimeoutSec 120; Expand-Archive $z 'C:\Tools\exiftool' -Force; $f=Get-ChildItem 'C:\Tools\exiftool' -Recurse -Filter 'exiftool(-k).exe' -EA SilentlyContinue | Select-Object -First 1; if($f){Copy-Item $f.FullName 'C:\Tools\exiftool\exiftool.exe' -Force; Write-Host('    ExifTool v'+$v+' installed.') -ForegroundColor Green}else{Write-Host '    Install failed - exe not found after extract.' -ForegroundColor Red}; Remove-Item $z -Force -EA SilentlyContinue"
goto :EOF

:INSTALL_SHERL_FUNC
if exist "%P_SHERL%\sherlock_project" (echo  %GN%    Already installed.%R% & goto :EOF)
if exist "%P_SHERL%" rmdir /s /q "%P_SHERL%" 2>nul
echo  %WH%    Cloning Sherlock...%R%
git clone https://github.com/sherlock-project/sherlock "%P_SHERL%"
if not exist "%P_SHERL%\sherlock_project" (echo  %RD%    Clone failed - check git and internet.%R% & goto :EOF)
echo  %WH%    Creating venv and installing package...%R%
python -m venv "%P_SHERL%\venv"
"%P_SHERL%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_SHERL%\venv\Scripts\python.exe" -m pip install -e "%P_SHERL%" --quiet 2>nul
"%P_SHERL%\venv\Scripts\python.exe" -m pip install sherlock-project --quiet --prefer-binary 2>nul
copy nul "%P_SHERL%\venv\.health" >nul 2>&1
echo  %GN%    Sherlock installed.%R%
goto :EOF

:INSTALL_OGRAM_FUNC
if exist "%P_OGRAM%\main.py" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning Osintgram...%R%
git clone https://github.com/Datalux/Osintgram "%P_OGRAM%"
if not exist "%P_OGRAM%\main.py" (echo  %RD%    Clone failed.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_OGRAM%\venv"
"%P_OGRAM%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_OGRAM%\venv\Scripts\python.exe" -m pip install -r "%P_OGRAM%\requirements.txt" --quiet --prefer-binary
if not exist "%P_OGRAM%\config" mkdir "%P_OGRAM%\config"
copy nul "%P_OGRAM%\venv\.health" >nul 2>&1
echo  %GN%    Osintgram installed.%R%
echo  %YW%    Note: Press [I] on the menu to set your Instagram credentials.%R%
goto :EOF

:INSTALL_HARV_FUNC
if exist "%P_HARV%\theHarvester\__main__.py" (echo  %GN%    Already installed.%R% & goto :EOF)
if exist "%P_HARV%" rmdir /s /q "%P_HARV%" 2>nul
echo  %WH%    Cloning theHarvester...%R%
git clone https://github.com/laramies/theHarvester "%P_HARV%"
if not exist "%P_HARV%\theHarvester\__main__.py" (echo  %RD%    Clone failed - check git and internet.%R% & goto :EOF)
echo  %WH%    Creating venv and installing package (may take a while)...%R%
python -m venv "%P_HARV%\venv"
"%P_HARV%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_HARV%\venv\Scripts\python.exe" -m pip install -e "%P_HARV%" --quiet 2>nul
"%P_HARV%\venv\Scripts\python.exe" -m pip install theHarvester --quiet --prefer-binary 2>nul
copy nul "%P_HARV%\venv\.health" >nul 2>&1
echo  %GN%    theHarvester installed.%R%
goto :EOF

:INSTALL_HOLE_FUNC
if exist "%P_HOLE%\holehe" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning Holehe...%R%
git clone https://github.com/megadose/holehe "%P_HOLE%"
if not exist "%P_HOLE%\holehe" (echo  %RD%    Clone failed.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_HOLE%\venv"
"%P_HOLE%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_HOLE%\venv\Scripts\python.exe" -m pip install -r "%P_HOLE%\requirements.txt" --quiet --prefer-binary 2>nul
"%P_HOLE%\venv\Scripts\python.exe" -m pip install -e "%P_HOLE%" --quiet 2>nul
copy nul "%P_HOLE%\venv\.health" >nul 2>&1
echo  %GN%    Holehe installed.%R%
goto :EOF

:INSTALL_MAIG_FUNC
if exist "%P_MAIG%\maigret" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning Maigret...%R%
git clone https://github.com/soxoj/maigret "%P_MAIG%"
if not exist "%P_MAIG%\maigret" (echo  %RD%    Clone failed.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_MAIG%\venv"
"%P_MAIG%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_MAIG%\venv\Scripts\python.exe" -m pip install -r "%P_MAIG%\requirements.txt" --quiet --prefer-binary 2>nul
"%P_MAIG%\venv\Scripts\python.exe" -m pip install -e "%P_MAIG%" --quiet 2>nul
copy nul "%P_MAIG%\venv\.health" >nul 2>&1
echo  %GN%    Maigret installed.%R%
goto :EOF

:INSTALL_PHOT_FUNC
if exist "%P_PHOT%\photon.py" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning Photon...%R%
git clone https://github.com/s0md3v/Photon "%P_PHOT%"
if not exist "%P_PHOT%\photon.py" (echo  %RD%    Clone failed.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_PHOT%\venv"
"%P_PHOT%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_PHOT%\venv\Scripts\python.exe" -m pip install -r "%P_PHOT%\requirements.txt" --quiet --prefer-binary
copy nul "%P_PHOT%\venv\.health" >nul 2>&1
echo  %GN%    Photon installed.%R%
goto :EOF

:INSTALL_SQLM_FUNC
if exist "%P_SQLM%\sqlmap.py" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning SQLMap (shallow clone - large repo)...%R%
git clone --depth 1 https://github.com/sqlmapproject/sqlmap "%P_SQLM%"
if not exist "%P_SQLM%\sqlmap.py" (echo  %RD%    Clone failed - check git and internet.%R% & goto :EOF)
echo  %GN%    SQLMap installed. No extra packages needed.%R%
goto :EOF

:INSTALL_SCAV_FUNC
if exist "%P_SCAV%\scavenger.py" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning Scavenger...%R%
git clone https://github.com/rndinfosecguy/Scavenger "%P_SCAV%"
if not exist "%P_SCAV%\scavenger.py" (echo  %RD%    Clone failed - check git and internet.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_SCAV%\venv"
"%P_SCAV%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_SCAV%\venv\Scripts\python.exe" -m pip install requests beautifulsoup4 colorama --quiet --prefer-binary
copy nul "%P_SCAV%\venv\.health" >nul 2>&1
echo  %GN%    Scavenger installed.%R%
goto :EOF

:INSTALL_LINK_FUNC
if exist "%P_LINK%\linkedin_gatherer.py" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning LinkedIn Gatherer...%R%
git clone https://github.com/DisK0nn3cT/linkedin-gatherer "%P_LINK%"
if not exist "%P_LINK%\linkedin_gatherer.py" (echo  %RD%    Clone failed - check git and internet.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_LINK%\venv"
"%P_LINK%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_LINK%\venv\Scripts\python.exe" -m pip install requests --quiet --prefer-binary 2>nul
copy nul "%P_LINK%\venv\.health" >nul 2>&1
echo  %GN%    LinkedIn Gatherer installed.%R%
echo  %YW%    NOTE: Python 2 tool - edit linkedin_gatherer.py to replace raw_input with input if it crashes.%R%
goto :EOF

:INSTALL_PWND_FUNC
if exist "%P_PWND%\pwnedornot.py" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning pwnedOrNot...%R%
git clone https://github.com/thewhiteh4t/pwnedOrNot "%P_PWND%"
if not exist "%P_PWND%\pwnedornot.py" (echo  %RD%    Clone failed - check git and internet.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_PWND%\venv"
"%P_PWND%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_PWND%\venv\Scripts\python.exe" -m pip install requests html2text --quiet --prefer-binary
copy nul "%P_PWND%\venv\.health" >nul 2>&1
echo  %GN%    pwnedOrNot installed.%R%
echo  %DG%    Get your free API key at: https://haveibeenpwned.com/API/Key%R%
goto :EOF


:: ============================================================
::  EXIFTOOL VERSION UPDATE
:: ============================================================
:UPDATE_EXIF_FUNC
echo  %DG%    Checking ExifTool version...%R%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$cur=(& 'C:\Tools\exiftool\exiftool.exe' -ver 2>$null); $cur=if($cur){$cur.Trim()}else{''}; try{$page=(Invoke-WebRequest 'https://exiftool.org' -UseBasicParsing -TimeoutSec 10).Content; $m=[regex]::Match($page,'exiftool-(\d+\.\d+)_64\.zip'); if($m.Success){$latest=$m.Groups[1].Value; if($cur -ne $latest){Write-Host('    Updating ExifTool '+$cur+' -> '+$latest+'...') -ForegroundColor Yellow; $zip='C:\Tools\exiftool\update.zip'; Invoke-WebRequest('https://exiftool.org/exiftool-'+$latest+'_64.zip') -OutFile $zip -UseBasicParsing; Expand-Archive $zip 'C:\Tools\exiftool' -Force; $f=Get-ChildItem 'C:\Tools\exiftool' -Filter 'exiftool(-k).exe' -EA SilentlyContinue | Select-Object -First 1; if($f){Move-Item $f.FullName 'C:\Tools\exiftool\exiftool.exe' -Force}; Remove-Item $zip -Force -EA SilentlyContinue; Write-Host '    ExifTool updated.' -ForegroundColor Green}else{Write-Host('    ExifTool v'+$cur+' is current.') -ForegroundColor Green}}else{Write-Host '    Version check unavailable.' -ForegroundColor Yellow}}catch{Write-Host('    Update check failed.') -ForegroundColor Yellow}"
goto :EOF


:: ============================================================
::  SELF-FIX: Osintgram pyreadline Python 3.10+ compatibility
:: ============================================================
:FIX_OSINTGRAM
if not exist "%P_OGRAM%\venv\Scripts\python.exe" goto :EOF
powershell -NoProfile -ExecutionPolicy Bypass -Command "$f='C:\OSINT\osintgram\venv\Lib\site-packages\pyreadline\py3k_compat.py'; if(Test-Path $f){$c=Get-Content $f -Raw; if($c -match 'collections\.Callable' -and $c -notmatch 'collections\.abc\.Callable'){$c=$c -replace 'import collections','import collections`nimport collections.abc'; $c=$c -replace 'collections\.Callable','collections.abc.Callable'; Set-Content $f $c -Encoding UTF8; Write-Host '    Applied pyreadline Python 3.10+ compatibility fix.' -ForegroundColor Green}}" 2>nul
goto :EOF


:: ============================================================
::  HEALTH VENV
::  Set HV_PATH and HV_REQS before calling.
::  Optionally set HV_PKG for a PyPI package to install.
::  Creates venv if missing. Runs installs if .health missing.
::  .health is deleted on git update -> re-runs next launch.
:: ============================================================
:HEALTH_VENV
if not exist "!HV_PATH!\venv\Scripts\python.exe" goto :HV_CREATE
if not exist "!HV_PATH!\venv\.health" goto :HV_INSTALL
goto :EOF
:HV_INSTALL
echo  %DG%    Verifying dependencies...%R%
if exist "!HV_REQS!"              "!HV_PATH!\venv\Scripts\python.exe" -m pip install -r "!HV_REQS!" --quiet --prefer-binary 2>nul
if exist "!HV_PATH!\setup.py"       "!HV_PATH!\venv\Scripts\python.exe" -m pip install -e "!HV_PATH!" --quiet 2>nul
if exist "!HV_PATH!\pyproject.toml" "!HV_PATH!\venv\Scripts\python.exe" -m pip install -e "!HV_PATH!" --quiet 2>nul
if defined HV_PKG                 "!HV_PATH!\venv\Scripts\python.exe" -m pip install !HV_PKG! --quiet --prefer-binary 2>nul
set "HV_PKG="
copy nul "!HV_PATH!\venv\.health" >nul 2>&1
goto :EOF
:HV_CREATE
echo  %YW%    No venv found - rebuilding automatically...%R%
python -m venv "!HV_PATH!\venv" 2>nul
if not exist "!HV_PATH!\venv\Scripts\python.exe" (echo  %RD%    Venv creation failed - is Python 3.10+ installed and in PATH?%R% & goto :EOF)
"!HV_PATH!\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet 2>nul
if exist "!HV_REQS!"              "!HV_PATH!\venv\Scripts\python.exe" -m pip install -r "!HV_REQS!" --quiet --prefer-binary 2>nul
if exist "!HV_PATH!\setup.py"       "!HV_PATH!\venv\Scripts\python.exe" -m pip install -e "!HV_PATH!" --quiet 2>nul
if exist "!HV_PATH!\pyproject.toml" "!HV_PATH!\venv\Scripts\python.exe" -m pip install -e "!HV_PATH!" --quiet 2>nul
if defined HV_PKG                 "!HV_PATH!\venv\Scripts\python.exe" -m pip install !HV_PKG! --quiet --prefer-binary 2>nul
set "HV_PKG="
copy nul "!HV_PATH!\venv\.health" >nul 2>&1
echo  %GN%    Venv rebuilt and ready.%R%
goto :EOF


:: ============================================================
::  SAFETY NET - should never reach here
:: ============================================================
echo.
echo  %YW%  Unexpected exit - restarting...%R%
timeout /t 2 /nobreak >nul
goto STARTUP
