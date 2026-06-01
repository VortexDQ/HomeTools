@echo off
:: ============================================================
::  HOME TOOLS  |  OSINT Launcher  |  v4.2
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
:: HOMETOOLS_VERSION:4.2
if "%~1"=="-k" goto :INIT
cmd /k "%~f0" -k
exit /b
:INIT

setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title HOME TOOLS v4.2

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
::  VERSION
:: ============================================================
set "HT_VERSION=4.2"

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
set "P_GHNT=C:\OSINT\GHunt"
set "P_RECN=C:\OSINT\recon-ng"
set "P_ZAP=C:\Tools\ZAP"
set "P_WPSC=C:\OSINT\wpscan"

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
echo  %CB%           HOME TOOLS v4.2  -  First Launch             %R%
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

call :CHECK_HT_UPDATE

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
call :SC_GHNT
call :SC_RECN
call :SC_ZAP
call :SC_WPSC
call :FIX_LINKEDIN
call :FIX_OSINTGRAM

echo.
echo  %GB%  =======================================================%R%
echo  %GN%  All checks complete.%R%
echo  %GB%  =======================================================%R%
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$e=[char]27;$cr=[char]13;try{$host.UI.RawUI.CursorVisible=$false}catch{};function W($ms){Start-Sleep -Milliseconds $ms};function CLS{[Console]::Clear()};CLS;W 400;1..3|ForEach-Object{CLS;Write-Host('  '+$e+'[1;93m*  *  *  *  *  *  *  *  *  *  *  *  *'+$e+'[0m');Write-Host('  '+$e+'[1;93m  *  *  *  *  *  *  *  *  *  *  *  *  '+$e+'[0m');W 70;CLS;W 50};CLS;Write-Host '';Write-Host('          '+$e+'[90m.-~~~-.'+$e+'[0m');Write-Host('        '+$e+'[90m( o   o )'+$e+'[0m');Write-Host('         '+$e+'[90m \ --- /'+$e+'[0m');Write-Host('          '+$e+'[90m.-----.'+$e+'[0m');Write-Host('            '+$e+'[90m|'+$e+'[0m');Write-Host('     '+$e+'[90m.-----++++-----.'+$e+'[0m');Write-Host('    '+$e+'[90m/ ++++++++++++++ \'+$e+'[0m');Write-Host('   '+$e+'[90m/ ++++++++++++++++ \'+$e+'[0m');W 500;CLS;Write-Host '';Write-Host('  '+$e+'[90m,--------.__'+$e+'[0m');Write-Host(' '+$e+'[90m/            `.'+$e+'[0m');Write-Host('          '+$e+'[90m.-~~~-.'+$e+'[0m');Write-Host('        '+$e+'[90m( X   X )'+$e+'[0m');Write-Host('         '+$e+'[90m \ --- /'+$e+'[0m');Write-Host('          '+$e+'[90m.-----.'+$e+'[0m');Write-Host('            '+$e+'[90m|'+$e+'[0m');Write-Host('     '+$e+'[90m.-----++++-----.'+$e+'[0m');Write-Host('    '+$e+'[90m/ ++++++++++++++ \'+$e+'[0m');W 350;CLS;Write-Host '';Write-Host('       '+$e+'[91m__________'+$e+'[0m');Write-Host(' '+$e+'[91m,-/          \-.'+$e+'[0m');Write-Host($e+'[91m/               \'+$e+'[0m');Write-Host('          '+$e+'[90m.-~~~-.'+$e+'[0m');Write-Host('        '+$e+'[90m( X   X )'+$e+'[0m');Write-Host('         '+$e+'[90m \ --- /'+$e+'[0m');Write-Host('          '+$e+'[90m.-----.'+$e+'[0m');Write-Host('            '+$e+'[90m|'+$e+'[0m');Write-Host('     '+$e+'[90m.-----++++-----.'+$e+'[0m');W 250;1..3|ForEach-Object{CLS;Write-Host '';Write-Host('      '+$e+'[1;91m     \\  //    '+$e+'[0m');Write-Host('      '+$e+'[1;91m      \\//     '+$e+'[0m');Write-Host('      '+$e+'[1;91m  S L A S H   '+$e+'[0m');Write-Host('      '+$e+'[1;91m      //\\     '+$e+'[0m');Write-Host('      '+$e+'[1;91m     //  \\    '+$e+'[0m');W 80;CLS;W 55};W 200;CLS;W 100;Write-Host '';Write-Host('  '+$e+'[1;96m ___  ___  ___  ___  ___     ___  ___  ___  __  ___   '+$e+'[0m');W 110;Write-Host('  '+$e+'[1;96m| . \| . \| . \| . \| . \   |_ _|| . \| . \| .||_ _|  '+$e+'[0m');W 110;Write-Host('  '+$e+'[1;96m|  _/|  _/|  _/|___/|   /     | | |   /|   /| . || |   '+$e+'[0m');W 110;Write-Host('  '+$e+'[1;96m|_|  |_|  |_|  |    |_|\_\    |_| |_|\_\|_|\_\|_|||_|   '+$e+'[0m');W 200;Write-Host '';$w=42;for($i=0;$i -le $w;$i++){$pct=[int](($i/$w)*100);$bar=([string][char]0x2588)*$i+$e+'[90m'+([string][char]0x2591)*($w-$i)+$e+'[0m';$col=if($pct -lt 35){$e+'[91m'}elseif($pct -lt 70){$e+'[93m'}else{$e+'[92m'};Write-Host -NoNewline([string]$cr+'  '+$col+$bar+'  '+[string]$pct+'%  '+$e+'[0m');W 16};Write-Host;Write-Host;Write-Host -NoNewline '  ';'HOME TOOLS  v!HT_VERSION!  ONLINE'.ToCharArray()|ForEach-Object{Write-Host -NoNewline($e+'[1;92m'+$_+$e+'[0m');W 42};Write-Host;W 800;CLS"
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
echo  %WB%              HOME TOOLS  ^|  v!HT_VERSION!%R%
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
set "S15=%RD%[--] %R%"
set "S16=%RD%[--] %R%"
set "S17=%RD%[--] %R%"
set "S18=%RD%[--] %R%"

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
if exist "%P_GHNT%\ghunt"                        set "S15=%GN%[OK] %R%"
if exist "%P_RECN%\recon-ng"                     set "S16=%GN%[OK] %R%"
if exist "%P_ZAP%\zap.bat"                       set "S17=%GN%[OK] %R%"
where wpscan >nul 2>&1 && set "S18=%GN%[OK] %R%"

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
echo  %WB%  ADVANCED TOOLS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  !S15!%GB%[15]%R%  %WH%GHunt                     %DG%Google account OSINT - email, location, more%R%
echo  !S16!%CB%[16]%R%  %WH%Recon-ng                  %DG%Modular web reconnaissance framework%R%
echo  !S17!%RD%[17]%R%  %WH%OWASP ZAP                 %DG%Web application security scanner%R%
echo  !S18!%MGB%[18]%R%  %WH%WPScan                    %DG%WordPress vulnerability scanner%R%
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
if /i "%CHO%"=="15"        goto LAUNCH_GHNT
if /i "%CHO%"=="16"        goto LAUNCH_RECN
if /i "%CHO%"=="17"        goto LAUNCH_ZAP
if /i "%CHO%"=="18"        goto LAUNCH_WPSC
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
echo  %RD%  Unknown option. Type 1-18, R, C, H, I, or Q.%R%
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
if not defined SCHO (cls & goto MENU_SCANNERS)
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
start "SpiderFoot  |  OSINT Server" powershell -NoExit -Command "$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;96m  SpiderFoot  |  Automated OSINT Framework'+$e+'[0m');Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host;Write-Host '  Server starting...' -ForegroundColor DarkGray;Write-Host;Set-Location 'C:\OSINT\spiderfoot';$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};&$p sf.py -l 127.0.0.1:5001"
echo.
echo  %GN%  SpiderFoot server launched in a separate window.%R%
echo  %CY%  Browser:  http://127.0.0.1:5001%R%
echo  %DG%  Wait ~5 seconds, then open the URL. Close that window to stop the server.%R%
echo.
echo  %WH%  Press any key to return to menu...%R%
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
title HOME TOOLS  ^|  ExifTool
powershell -NoProfile -Command "Set-Location 'C:\Tools\exiftool';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;95m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;95m  ExifTool  |  File Metadata Reader / Writer'+$e+'[0m');Write-Host('  '+$e+'[1;95m'+$sep+$e+'[0m');Write-Host '  Drag a file onto this window or type a full path.' -ForegroundColor DarkGray;Write-Host;Write-Host '  COMMANDS' -ForegroundColor White;Write-Host '  file.jpg                  Read all metadata' -ForegroundColor DarkGray;Write-Host '  -all= file.jpg            Strip ALL metadata from file' -ForegroundColor DarkGray;Write-Host '  -GPS* file.jpg            Show GPS coordinates only' -ForegroundColor DarkGray;Write-Host '  -Author -Make file.jpg    Show specific tags' -ForegroundColor DarkGray;Write-Host '  -json file.jpg            Output metadata as JSON' -ForegroundColor DarkGray;Write-Host '  -csv -r C:\Photos\        Bulk scan folder to CSV' -ForegroundColor DarkGray;Write-Host '  -all= -r C:\Folder\       Strip metadata from entire folder' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;do{$f=Read-Host '  File/folder';if($f){.\exiftool.exe $f}}while($f)"
title HOME TOOLS v!HT_VERSION!
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
title HOME TOOLS  ^|  Sherlock
powershell -NoProfile -Command "Set-Location 'C:\OSINT\sherlock';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;93m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;93m  Sherlock  |  Username Hunt across 400+ Sites'+$e+'[0m');Write-Host('  '+$e+'[1;93m'+$sep+$e+'[0m');Write-Host '  Just type a username below. Results show every site where it exists.' -ForegroundColor DarkGray;Write-Host;Write-Host '  TIPS' -ForegroundColor White;Write-Host '  Try variations: john  john_doe  john123  j0hn  johnsmith' -ForegroundColor DarkGray;Write-Host '  [+] = account found    [x] = not found    [!] = error' -ForegroundColor DarkGray;Write-Host '  Results are saved automatically to a .txt file in the sherlock folder' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$u=Read-Host '  Username';if($u){&$p -m sherlock_project $u}}while($u)"
title HOME TOOLS v!HT_VERSION!
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
title HOME TOOLS  ^|  Osintgram
powershell -NoProfile -Command "Set-Location 'C:\OSINT\osintgram';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;92m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;92m  Osintgram  |  Instagram OSINT'+$e+'[0m');Write-Host('  '+$e+'[1;92m'+$sep+$e+'[0m');Write-Host '  Enter a target Instagram username. Once loaded, type commands below.' -ForegroundColor DarkGray;Write-Host;Write-Host '  COMMANDS  (type after target loads)' -ForegroundColor White;Write-Host '  info          Account info: bio, followers, post count' -ForegroundColor DarkGray;Write-Host '  followers     List all followers' -ForegroundColor DarkGray;Write-Host '  following     List all accounts they follow' -ForegroundColor DarkGray;Write-Host '  photos        Download all photos' -ForegroundColor DarkGray;Write-Host '  location      Extract location data from posts' -ForegroundColor DarkGray;Write-Host '  hashtags      Hashtags used in posts' -ForegroundColor DarkGray;Write-Host '  comments      All comments made by the user' -ForegroundColor DarkGray;Write-Host '  captions      Post captions' -ForegroundColor DarkGray;Write-Host '  tagged        Photos the user is tagged in' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$t=Read-Host '  Target username';if($t){&$p main.py $t}}while($t)"
title HOME TOOLS v!HT_VERSION!
goto MENU


:LAUNCH_HARV
cls
echo.
echo  %ORB%  =======================================================%R%
echo  %WB%  theHarvester  ^|  Email / Domain Recon%R%
echo  %ORB%  =======================================================%R%
echo.
if not exist "%P_HARV%\theHarvester\__main__.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_HARV%" & set "HV_REQS=%P_HARV%\requirements.txt" & set "HV_PKG=theHarvester"
call :HEALTH_VENV
title HOME TOOLS  ^|  theHarvester
powershell -NoProfile -Command "Set-Location 'C:\OSINT\theHarvester';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;33m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;33m  theHarvester  |  Email / Domain / Subdomain Recon'+$e+'[0m');Write-Host('  '+$e+'[1;33m'+$sep+$e+'[0m');Write-Host '  Enter a domain to harvest emails, subdomains, employee names and IPs.' -ForegroundColor DarkGray;Write-Host;Write-Host '  WHAT IT FINDS' -ForegroundColor White;Write-Host '  Emails, subdomains, employee names, IP addresses, open ports' -ForegroundColor DarkGray;Write-Host '  Sources: Google, Bing, Yahoo, DuckDuckGo (default)' -ForegroundColor DarkGray;Write-Host;Write-Host '  TIPS' -ForegroundColor White;Write-Host '  Enter just the domain: example.com  (no https://)' -ForegroundColor DarkGray;Write-Host '  Results include all emails found across all sources' -ForegroundColor DarkGray;Write-Host '  Use these emails with Holehe [8] or pwnedOrNot [14]' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$d=Read-Host '  Domain (e.g. example.com)';if($d){&$p -m theHarvester -d $d -b google,bing,yahoo,duckduckgo}}while($d)"
title HOME TOOLS v!HT_VERSION!
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
title HOME TOOLS  ^|  Holehe
powershell -NoProfile -Command "Set-Location 'C:\OSINT\holehe';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;35m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;35m  Holehe  |  Email to Social Accounts - 120+ Sites'+$e+'[0m');Write-Host('  '+$e+'[1;35m'+$sep+$e+'[0m');Write-Host '  Enter an email to check which sites have an account registered to it.' -ForegroundColor DarkGray;Write-Host;Write-Host '  READING RESULTS' -ForegroundColor White;Write-Host '  [+] Account found on that site' -ForegroundColor DarkGray;Write-Host '  [-] No account found' -ForegroundColor DarkGray;Write-Host '  [~] Rate limited - try again later' -ForegroundColor DarkGray;Write-Host;Write-Host '  TIPS' -ForegroundColor White;Write-Host '  Works best with Gmail, Outlook and Yahoo addresses' -ForegroundColor DarkGray;Write-Host '  Pair with theHarvester [7] - harvest emails then check each one here' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$em=Read-Host '  Email';if($em){&$p -m holehe $em}}while($em)"
title HOME TOOLS v!HT_VERSION!
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
title HOME TOOLS  ^|  Maigret
powershell -NoProfile -Command "Set-Location 'C:\OSINT\maigret';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;96m  Maigret  |  Deep Username OSINT  -  3000+ Sites'+$e+'[0m');Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host '  Scans 3000+ sites and links accounts into an interactive HTML report.' -ForegroundColor DarkGray;Write-Host;Write-Host '  WHAT YOU GET' -ForegroundColor White;Write-Host '  HTML report with account network graph (saved in reports\ folder)' -ForegroundColor DarkGray;Write-Host '  All found profiles linked with profile URLs' -ForegroundColor DarkGray;Write-Host '  Account connections and linked identities' -ForegroundColor DarkGray;Write-Host;Write-Host '  TIPS' -ForegroundColor White;Write-Host '  Scan takes 1-3 min. Report opens in your browser when done.' -ForegroundColor DarkGray;Write-Host '  Try exact username then variations (underscore, numbers, etc.)' -ForegroundColor DarkGray;Write-Host '  Use after Sherlock [5] to go deeper on found usernames' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$u=Read-Host '  Username';if($u){&$p -m maigret $u --html}}while($u)"
title HOME TOOLS v!HT_VERSION!
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
title HOME TOOLS  ^|  Photon
powershell -NoProfile -Command "Set-Location 'C:\OSINT\Photon';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;97m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;97m  Photon  |  Web Crawler and OSINT Spider'+$e+'[0m');Write-Host('  '+$e+'[1;97m'+$sep+$e+'[0m');Write-Host '  Enter a URL to crawl. Extracts emails, URLs, API keys, phone numbers, JS secrets.' -ForegroundColor DarkGray;Write-Host;Write-Host '  WHAT IT EXTRACTS' -ForegroundColor White;Write-Host '  Emails, internal/external URLs, JavaScript files' -ForegroundColor DarkGray;Write-Host '  API keys, tokens, phone numbers, social media links' -ForegroundColor DarkGray;Write-Host '  Results saved in results\ folder (JSON + text files)' -ForegroundColor DarkGray;Write-Host;Write-Host '  SETTINGS (currently: depth=2, threads=5)' -ForegroundColor White;Write-Host '  Increase --level 3 for deeper crawl (slower)' -ForegroundColor DarkGray;Write-Host '  Increase --threads 10 for faster crawl' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$u=Read-Host '  URL (https://...)';if($u){&$p photon.py -u $u --level 2 --threads 5}}while($u)"
title HOME TOOLS v!HT_VERSION!
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
title HOME TOOLS  ^|  SQLMap
powershell -NoProfile -Command "Set-Location 'C:\OSINT\sqlmap';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;91m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;91m  SQLMap  |  SQL Injection Scanner'+$e+'[0m');Write-Host('  '+$e+'[1;91m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;93m  REMINDER: Only test systems you own or have permission to test.'+$e+'[0m');Write-Host;Write-Host '  HOW TO USE' -ForegroundColor White;Write-Host '  Find a URL with a parameter like: http://site.com/page.php?id=1' -ForegroundColor DarkGray;Write-Host '  Paste it below. SQLMap tests it automatically with --batch mode.' -ForegroundColor DarkGray;Write-Host;Write-Host '  WHAT HAPPENS' -ForegroundColor White;Write-Host '  SQLMap detects injection type, lists databases, can dump tables' -ForegroundColor DarkGray;Write-Host '  --batch = auto-answers all prompts (no input needed during scan)' -ForegroundColor DarkGray;Write-Host;Write-Host '  USEFUL FLAGS  (add to URL after a space)' -ForegroundColor White;Write-Host '  --dbs               List all databases' -ForegroundColor DarkGray;Write-Host '  --tables -D dbname  List tables in a database' -ForegroundColor DarkGray;Write-Host '  --dump -D db -T tbl Dump a specific table' -ForegroundColor DarkGray;Write-Host '  --forms             Auto-detect and test all forms on the page' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;do{$u=Read-Host '  Target URL';if($u){python sqlmap.py -u $u --batch}}while($u)"
title HOME TOOLS v!HT_VERSION!
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
title HOME TOOLS  ^|  Scavenger
powershell -NoProfile -Command "Set-Location 'C:\OSINT\scavenger';$e=[char]27;$sep=([string][char]0x2550)*54;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};$q=$false;do{cls;Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;96m  Scavenger  |  Pastebin Leak Monitor'+$e+'[0m');Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host '  Monitors Pastebin for leaked credentials, API keys and RSA keys.' -ForegroundColor DarkGray;Write-Host;Write-Host '  [1]  Archive Scrape   -  continuously crawl Pastebin archive' -ForegroundColor White;Write-Host '  [2]  Track User       -  monitor a specific Pastebin user' -ForegroundColor White;Write-Host '  [3]  Scan Folder      -  scan local files for leaked credentials' -ForegroundColor White;Write-Host '  [Q]  Return to HOME TOOLS' -ForegroundColor DarkGray;Write-Host;$m=Read-Host '  Mode';if($m -eq '1'){Write-Host '  Starting archive scrape... Press Ctrl+C to stop.' -ForegroundColor Green;Write-Host;&$p pbincomArchiveScrape.py;Read-Host '  Press Enter to continue'}elseif($m -eq '2'){$u=Read-Host '  Pastebin username to track';if($u){Add-Content -Path 'configs\users.txt' -Value $u;Write-Host('  Added '+$u+' to tracking list. Starting tracker...') -ForegroundColor Green;Write-Host;&$p pbincomTrackUser.py;Read-Host '  Press Enter to continue'}}elseif($m -eq '3'){do{$f=Read-Host '  Folder path (blank = back)';if($f){Write-Host '  Scanning...' -ForegroundColor DarkGray;&$p findSensitiveData.py $f}}while($f)}elseif($m -eq 'Q'-or$m -eq 'q'){$q=$true}}while(-not $q)"
title HOME TOOLS v!HT_VERSION!
goto MENU

:LAUNCH_LINK
cls
echo.
echo  %BB%  =======================================================%R%
echo  %WB%  LinkedIn Gatherer  ^|  LinkedIn OSINT%R%
echo  %BB%  =======================================================%R%
echo.
if not exist "%P_LINK%\linkedin_gatherer.py" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
:: Auto-patch Python 2 raw_input -> input (silent, runs every time as guard)
call :FIX_LINKEDIN
:: Check if LinkedIn credentials are set in config.py
set "LKCRED=0"
powershell -NoProfile -Command "if((Get-Content 'C:\OSINT\linkedin-gatherer\config.py' -Raw -EA SilentlyContinue) -match 'username\s*=\s*''.+'''){exit 0}else{exit 1}" >nul 2>nul && set "LKCRED=1"
if "!LKCRED!"=="1" goto LINK_LAUNCH
goto LINK_SETUP

:LINK_SETUP
cls
echo.
echo  %BB%  =======================================================%R%
echo  %WB%  LinkedIn Gatherer  ^|  Account Setup%R%
echo  %BB%  =======================================================%R%
echo.
echo  %WH%  LinkedIn Gatherer needs a LinkedIn account to log in.%R%
echo  %YW%  Use a secondary / burner account - NOT your main one.%R%
echo  %DG%  Credentials stored locally in: C:\OSINT\linkedin-gatherer\config.py%R%
echo.
set "LK_USER="
set /p "LK_USER=   LinkedIn Email >> "
if not defined LK_USER goto MENU
echo.
echo  %DG%  Password input is hidden while typing...%R%
for /f "delims=" %%P in ('powershell -NoProfile -Command "$s=Read-Host -Prompt ''   LinkedIn Password'' -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($s))"') do set "LK_PASS=%%P"
if not defined LK_PASS goto MENU
powershell -NoProfile -Command "$f='C:\OSINT\linkedin-gatherer\config.py'; $c=Get-Content $f -Raw; $c=$c -replace 'username\s*=\s*.*','username = ''!LK_USER!'''; $c=$c -replace 'password\s*=\s*.*','password = ''!LK_PASS!'''; Set-Content $f $c -Encoding UTF8" >nul 2>nul
set "LK_PASS="
echo.
echo  %GN%  Credentials saved.%R%
echo  %DG%  To update: run LinkedIn Gatherer again when not logged in.%R%
timeout /t 2 /nobreak >nul
goto LINK_LAUNCH

:LINK_LAUNCH
set "HV_PATH=%P_LINK%" & set "HV_REQS=%P_LINK%\requirements.txt"
call :HEALTH_VENV
title HOME TOOLS  ^|  LinkedIn Gatherer
powershell -NoProfile -Command "Set-Location 'C:\OSINT\linkedin-gatherer';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;94m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;94m  LinkedIn Gatherer  |  LinkedIn Profile OSINT'+$e+'[0m');Write-Host('  '+$e+'[1;94m'+$sep+$e+'[0m');Write-Host '  Gathers employee names, job titles and profile URLs from a company.' -ForegroundColor DarkGray;Write-Host '  The tool will prompt: search URL, company name, output filename.' -ForegroundColor DarkGray;Write-Host '  Answer N to Search again? to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{Write-Host('  '+$e+'[90m--- New search ---'+$e+'[0m');try{&$p linkedin_gatherer.py}catch{Write-Host('  Error: '+$_.Exception.Message) -ForegroundColor Red};$again=Read-Host '  Search again? [Y/N]'}while($again -eq 'Y'-or$again -eq 'y')"
title HOME TOOLS v!HT_VERSION!
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
:: Check if API key is configured (key must be non-empty string, 5+ chars)
set "PWND_KEY=0"
powershell -NoProfile -Command "$cfg='%USERPROFILE%\.config\pwnedornot\config.json'; if(Test-Path $cfg){try{$j=Get-Content $cfg -Raw | ConvertFrom-Json; if($j.api_key -and $j.api_key.Length -ge 5){exit 0}}catch{}}; exit 1" >nul 2>nul && set "PWND_KEY=1"
if "!PWND_KEY!"=="0" goto PWND_SETUP
goto PWND_LAUNCH

:PWND_SETUP
cls
echo.
echo  %YB%  =======================================================%R%
echo  %WB%  pwnedOrNot  ^|  API Key Setup%R%
echo  %YB%  =======================================================%R%
echo.
echo  %WH%  pwnedOrNot needs a HaveIBeenPwned API key to work.%R%
echo.
echo  %DG%  How to get your free key:%R%
echo  %CY%  1. Go to: https://haveibeenpwned.com/API/Key%R%
echo  %CY%  2. Enter your email and subscribe (free plan available)%R%
echo  %CY%  3. Copy the key from the confirmation email%R%
echo  %CY%  4. Paste it below%R%
echo.
set "HIBP_KEY="
set /p "HIBP_KEY=   Paste API key >> "
if not defined HIBP_KEY goto MENU
if not exist "%USERPROFILE%\.config\pwnedornot" mkdir "%USERPROFILE%\.config\pwnedornot" >nul 2>&1
powershell -NoProfile -Command "$o=[PSCustomObject]@{api_key='!HIBP_KEY!'}; $o | ConvertTo-Json | Set-Content '%USERPROFILE%\.config\pwnedornot\config.json' -Encoding UTF8" >nul 2>nul
set "HIBP_KEY="
echo.
echo  %GN%  API key saved. You're all set.%R%
echo  %DG%  To change it later: delete %USERPROFILE%\.config\pwnedornot\config.json and relaunch.%R%
timeout /t 2 /nobreak >nul
goto PWND_LAUNCH

:PWND_LAUNCH
title HOME TOOLS  ^|  pwnedOrNot
powershell -NoProfile -Command "Set-Location 'C:\OSINT\pwnedornot';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;93m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;93m  pwnedOrNot  |  Email Breach Checker'+$e+'[0m');Write-Host('  '+$e+'[1;93m'+$sep+$e+'[0m');Write-Host '  Enter an email to check all known data breaches and leaked passwords.' -ForegroundColor DarkGray;Write-Host;Write-Host '  WHAT YOU GET' -ForegroundColor White;Write-Host '  List of breaches the email appeared in (site, date, data types)' -ForegroundColor DarkGray;Write-Host '  Any leaked passwords found in public dumps' -ForegroundColor DarkGray;Write-Host '  Pastebin mentions of the address' -ForegroundColor DarkGray;Write-Host;Write-Host '  TIPS' -ForegroundColor White;Write-Host '  Found passwords reveal patterns - people reuse passwords with small changes' -ForegroundColor DarkGray;Write-Host '  Run on every email you find with theHarvester [7] or Holehe [8]' -ForegroundColor DarkGray;Write-Host '  Needs a HIBP API key - press I on menu then pick pwnedOrNot if not set' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$em=Read-Host '  Email';if($em){&$p pwnedornot.py -e $em}}while($em)"
title HOME TOOLS v!HT_VERSION!
goto MENU


:: ============================================================
::  LAUNCHERS  15-18
:: ============================================================

:LAUNCH_GHNT
cls
echo.
echo  %GB%  =======================================================%R%
echo  %WB%  GHunt  ^|  Google Account OSINT%R%
echo  %GB%  =======================================================%R%
echo.
if not exist "%P_GHNT%\ghunt" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_GHNT%" & set "HV_REQS=%P_GHNT%\requirements.txt"
call :HEALTH_VENV
title HOME TOOLS  ^|  GHunt
powershell -NoProfile -Command "Set-Location 'C:\OSINT\GHunt';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;92m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;92m  GHunt  |  Google Account OSINT'+$e+'[0m');Write-Host('  '+$e+'[1;92m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;93m  First time: type  login  as the subcommand to authenticate.'+$e+'[0m');Write-Host;Write-Host '  SUBCOMMANDS' -ForegroundColor White;Write-Host '  email    target@gmail.com    Account info: name, Gaia ID, profile pic' -ForegroundColor DarkGray;Write-Host '                               Last edit, Maps activity, YouTube channel' -ForegroundColor DarkGray;Write-Host '  gaia     GAIA_ID              Search by internal Google ID' -ForegroundColor DarkGray;Write-Host '  drive    target@gmail.com    Find publicly shared Drive files' -ForegroundColor DarkGray;Write-Host '  youtube  target@gmail.com    Find linked YouTube channel' -ForegroundColor DarkGray;Write-Host '  login    (no target)         Authenticate with your Google account' -ForegroundColor DarkGray;Write-Host;Write-Host '  Leave blank to return to HOME TOOLS.' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};do{$cmd=Read-Host '  Subcommand (email/gaia/drive/youtube/login)';if($cmd -eq 'login'){&$p -m ghunt login}elseif($cmd){$tgt=Read-Host '  Target (email or ID)';if($tgt){&$p -m ghunt $cmd $tgt}}}while($cmd)"
title HOME TOOLS v!HT_VERSION!
goto MENU

:LAUNCH_RECN
cls
echo.
echo  %CB%  =======================================================%R%
echo  %WB%  Recon-ng  ^|  Web Reconnaissance Framework%R%
echo  %CB%  =======================================================%R%
echo.
if not exist "%P_RECN%\recon-ng" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
set "HV_PATH=%P_RECN%" & set "HV_REQS=%P_RECN%\REQUIREMENTS"
call :HEALTH_VENV
title HOME TOOLS  ^|  Recon-ng
powershell -NoProfile -Command "Set-Location 'C:\OSINT\recon-ng';$e=[char]27;$sep=([string][char]0x2550)*54;Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host('  '+$e+'[1;96m  Recon-ng  |  Web Reconnaissance Framework'+$e+'[0m');Write-Host('  '+$e+'[1;96m'+$sep+$e+'[0m');Write-Host '  Modular recon framework - type commands inside its console.' -ForegroundColor DarkGray;Write-Host;Write-Host '  QUICK START  (type these inside recon-ng)' -ForegroundColor White;Write-Host '  workspaces create NAME          Create a new workspace for a target' -ForegroundColor DarkGray;Write-Host '  workspaces load NAME            Switch to an existing workspace' -ForegroundColor DarkGray;Write-Host '  modules search email            Find email harvesting modules' -ForegroundColor DarkGray;Write-Host '  modules search domain           Find domain recon modules' -ForegroundColor DarkGray;Write-Host '  marketplace install MODULE      Install a module' -ForegroundColor DarkGray;Write-Host '  modules load MODULE             Load an installed module' -ForegroundColor DarkGray;Write-Host '  info                            Show current module info' -ForegroundColor DarkGray;Write-Host '  options set SOURCE example.com  Set the target' -ForegroundColor DarkGray;Write-Host '  run                             Execute the module' -ForegroundColor DarkGray;Write-Host '  show hosts                      Show all discovered hosts' -ForegroundColor DarkGray;Write-Host '  exit                            Return to HOME TOOLS' -ForegroundColor DarkGray;Write-Host;$p=if(Test-Path 'venv\Scripts\python.exe'){'.\venv\Scripts\python.exe'}else{'python'};&$p recon-ng"
title HOME TOOLS v!HT_VERSION!
goto MENU

:LAUNCH_ZAP
cls
echo.
echo  %RD%  =======================================================%R%
echo  %WB%  OWASP ZAP  ^|  Web Application Security Scanner%R%
echo  %RD%  =======================================================%R%
echo.
echo  %YW%  REMINDER: Only scan applications you own or have permission to test.%R%
echo.
if not exist "%P_ZAP%\zap.bat" echo  %RD%  Not ready. Type R on the menu to repair.%R% & pause & goto MENU
java -version >nul 2>&1 || (echo  %RD%  Java is required to run ZAP.%R% & echo  %CY%  Download Java at: https://adoptium.net%R% & echo. & pause & goto MENU)
echo  %GN%  Launching ZAP by Checkmarx...%R%
echo  %DG%  ZAP opens in its own GUI window.%R%
echo  %DG%  Close the ZAP window when done - it does not run in this terminal.%R%
echo.
start "ZAP" "%P_ZAP%\zap.bat"
echo  %WH%  Press any key to return to menu (ZAP keeps running in background)...%R%
pause >nul
goto MENU

:LAUNCH_WPSC
cls
echo.
echo  %MGB%  =======================================================%R%
echo  %WB%  WPScan  ^|  WordPress Vulnerability Scanner%R%
echo  %MGB%  =======================================================%R%
echo.
echo  %YW%  REMINDER: Only scan WordPress sites you own or have permission to test.%R%
echo  %DG%  License: Free for personal/non-commercial use. Commercial use requires a paid plan.%R%
echo.
title HOME TOOLS  ^|  WPScan
echo  %MGB%  ============================================================%R%
echo  %WB%    QUICK COMMANDS%R%
echo  %MGB%  ============================================================%R%
echo  %DG%  wpscan --url URL                          Basic scan%R%
echo  %DG%  wpscan --url URL --enumerate u             Find usernames%R%
echo  %DG%  wpscan --url URL --enumerate p             Find plugins%R%
echo  %DG%  wpscan --url URL --enumerate t             Find themes%R%
echo  %DG%  wpscan --url URL --enumerate u,p,t         All of the above%R%
echo  %DG%  wpscan --url URL --api-token TOKEN         Add CVE vuln data%R%
echo  %DG%  wpscan --url URL --random-user-agent       Bypass WAF detection%R%
echo  %DG%  Get a free API token at: https://wpscan.com%R%
echo.
:WPSC_LOOP
set "WPSC_URL="
set /p "WPSC_URL=   Target URL (blank to return) >> "
if not defined WPSC_URL goto WPSC_DONE
echo.
wpscan --url "!WPSC_URL!" --enumerate u,p,t --random-user-agent
echo.
echo  %DG%  Press any key to scan another target...%R%
pause >nul
goto WPSC_LOOP
:WPSC_DONE
title HOME TOOLS v!HT_VERSION!
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
echo  %WB%       HELP  ^|  HOME TOOLS v!HT_VERSION!%R%
echo  %CB%  =======================================================%R%
echo.
echo  %WB%  QUICK START%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Type a number 1-18 and press ENTER to launch a tool.%R%
echo  %DG%  Every tool installs and updates itself automatically.%R%
echo  %DG%  Leave input blank inside any tool to return to this menu.%R%
echo.
echo  %WB%  DEVICE / LOCAL  %DG%(1-2)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CB%  1%R%   JLT Edge Wireless   %DG%OemDrv wireless device manager%R%
echo  %CB%  2%R%   Scanners            %DG%ESET / F-Secure / HitmanPro submenu%R%
echo.
echo  %WB%  OSINT TOOLS  %DG%(3-14)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %BB%  3%R%   SpiderFoot          %DG%Automated OSINT framework - opens browser at :5001%R%
echo  %MB%  4%R%   ExifTool            %DG%Read, write and strip metadata from any file%R%
echo  %YB%  5%R%   Sherlock            %DG%Find a username across 400+ social media sites%R%
echo  %GB%  6%R%   Osintgram           %DG%Instagram OSINT  ^| needs burner account + no 2FA%R%
echo  %ORB%  7%R%   theHarvester        %DG%Harvest emails, subdomains and IPs from a domain%R%
echo  %MGB%  8%R%   Holehe              %DG%Check if an email is registered on 120+ sites%R%
echo  %CY%  9%R%   Maigret             %DG%Deep username OSINT across 3000+ sites + HTML report%R%
echo  %WB% 10%R%   Photon              %DG%Web crawler - extracts emails, URLs, API keys, JS%R%
echo  %RD% 11%R%   SQLMap              %DG%Automated SQL injection scanner and exploiter%R%
echo  %CB% 12%R%   Scavenger           %DG%Pastebin leak monitor and credential scraper%R%
echo  %BB% 13%R%   LinkedIn Gatherer   %DG%LinkedIn employee and profile OSINT%R%
echo  %YB% 14%R%   pwnedOrNot          %DG%Email breach checker - finds leaked passwords too%R%
echo.
echo  %WB%  ADVANCED TOOLS  %DG%(15-18)%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %GB% 15%R%   GHunt               %DG%Google account OSINT - email, location, Maps, Drive%R%
echo  %DG%              %YW%First use: run tool then type  ghunt login%R%
echo  %CB% 16%R%   Recon-ng            %DG%Modular web recon framework with its own console%R%
echo  %RD% 17%R%   ZAP by Checkmarx    %DG%Web app security scanner - opens full GUI%R%
echo  %DG%              %YW%Requires Java (https://adoptium.net)%R%
echo  %MGB% 18%R%   WPScan              %DG%WordPress vulnerability scanner - plugins, users, CVEs%R%
echo  %DG%              %YW%Requires Ruby (https://rubyinstaller.org)%R%
echo  %DG%              Free for personal use. Commercial use needs paid plan.%R%
echo.
echo  %WB%  MENU KEYS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %CY%  R%R%  Repair      Re-run all installs and updates
echo  %CY%  C%R%  Commands    Full command reference for every tool
echo  %CY%  I%R%  Instagram   Set or update Osintgram account credentials
echo  %CY%  H%R%  Help        This screen
echo  %CY%  Q%R%  Quit        Close HOME TOOLS
echo.
echo  %WB%  REQUIREMENTS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  Python 3.10+  git  -  required for most tools (add both to PATH)%R%
echo  %DG%  Java          -  required for ZAP only   (https://adoptium.net)%R%
echo  %DG%  Ruby + gem    -  required for WPScan     (https://rubyinstaller.org)%R%
echo.
echo  %WB%  INSTALL LOCATIONS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  OSINT tools:  C:\OSINT\        ZAP: C:\Tools\ZAP\%R%
echo  %DG%  ExifTool:     C:\Tools\exiftool\%R%
echo.
echo  %WB%  STATUS INDICATORS%R%
echo  %DG%  --------------------------------------------------------%R%
echo  %DG%  %GN%[OK]%DG% = Installed and ready%R%
echo  %DG%  %RD%[--]%DG% = Not yet installed (auto-installs on startup)%R%
echo  %DG%  %RD%[!!]%DG% = Local file missing (check path in bat file)%R%
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
exit 0


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
goto :SC_SPIDER_END
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
goto :SC_OGRAM_END
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
if "!HAS_GIT!"=="0" (echo  %GN%    Installed. Python 3 auto-patched.%R% & goto :SC_LINK_END)
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

:SC_GHNT
echo.
echo  %GB%  [15] GHunt%R%
if exist "%P_GHNT%\ghunt" goto :SC_GHNT_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_GHNT_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_GHNT_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_GHNT_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_GHNT_FUNC
goto :SC_GHNT_END
:SC_GHNT_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_GHNT_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_GHNT_END)
set "GIT_PATH=%P_GHNT%" & set "GIT_NAME=GHunt" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
goto :SC_GHNT_END
:SC_GHNT_END
if exist "%P_GHNT%\ghunt" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_RECN
echo.
echo  %CB%  [16] Recon-ng%R%
if exist "%P_RECN%\recon-ng" goto :SC_RECN_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_RECN_END)
if "!HAS_GIT!"=="0" (echo  %YW%    Needs git in PATH.%R%          & goto :SC_RECN_END)
if "!HAS_PY!"=="0"  (echo  %YW%    Needs Python in PATH.%R%       & goto :SC_RECN_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_RECN_FUNC
goto :SC_RECN_END
:SC_RECN_UPD
if "!HAS_NET!"=="0" (echo  %DG%    Offline - skipping update.%R%  & goto :SC_RECN_END)
if "!HAS_GIT!"=="0" (echo  %GN%    Installed.%R%                   & goto :SC_RECN_END)
set "GIT_PATH=%P_RECN%" & set "GIT_NAME=Recon-ng" & set "GIT_REQS=1"
call :GIT_CHECK_UPDATE
goto :SC_RECN_END
:SC_RECN_END
if exist "%P_RECN%\recon-ng" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_ZAP
echo.
echo  %RD%  [17] OWASP ZAP%R%
if exist "%P_ZAP%\zap.bat" goto :SC_ZAP_JCHK
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_ZAP_END)
echo  %WH%    Not installed - downloading...%R%
call :INSTALL_ZAP_FUNC
goto :SC_ZAP_END
:SC_ZAP_JCHK
java -version >nul 2>&1 || echo  %YW%    WARNING: Java not found. ZAP needs Java - get it at: https://adoptium.net%R%
:SC_ZAP_END
if exist "%P_ZAP%\zap.bat" (echo  %GN%    Status: Ready%R%) else (echo  %RD%    Status: NOT READY%R%)
goto :EOF

:SC_WPSC
echo.
echo  %MGB%  [18] WPScan%R%
where wpscan >nul 2>&1 && (echo  %GN%    Status: Ready%R% & goto :EOF)
if "!HAS_NET!"=="0" (echo  %DG%    Offline - not installed.%R%    & goto :SC_WPSC_END)
where ruby >nul 2>&1 || (echo  %YW%    Needs Ruby in PATH. Get it at: https://rubyinstaller.org%R% & goto :SC_WPSC_END)
echo  %WH%    Installing WPScan gem (may take 1-2 min)...%R%
gem install wpscan --no-document 2>nul
where wpscan >nul 2>&1 && (echo  %GN%    WPScan installed.%R%) || (echo  %RD%    Install failed - check Ruby and gem are in PATH.%R%)
:SC_WPSC_END
where wpscan >nul 2>&1 && (echo  %GN%    Status: Ready%R%) || (echo  %RD%    Status: NOT READY%R%)
goto :EOF


:: ============================================================
::  HOME TOOLS SELF-UPDATE
::  Uses temp files not for/f('ps') to avoid capture issues.
:: ============================================================
:CHECK_HT_UPDATE
if "!HAS_NET!"=="0" goto :EOF
echo  %DG%  Checking for HomeTools updates...%R%
set "HT_REMOTE_VER="
set "HT_VER_TMP=%TEMP%\ht_ver_%RANDOM%.txt"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; try { $c=(Invoke-WebRequest 'https://raw.githubusercontent.com/VortexDQ/HomeTools/main/HomeTools.bat' -UseBasicParsing -TimeoutSec 10).Content; $m=[regex]::Match($c,'HOMETOOLS_VERSION:([\d.]+)'); if($m.Success){ $v=$m.Groups[1].Value.Trim(); if($v -match '^\d+\.\d+$'){ [System.IO.File]::WriteAllText($env:TEMP+'\ht_ver_tmp.txt',$v) } } } catch {}" >nul 2>nul
if exist "%TEMP%\ht_ver_tmp.txt" (
  set /p HT_REMOTE_VER= < "%TEMP%\ht_ver_tmp.txt"
  del "%TEMP%\ht_ver_tmp.txt" >nul 2>nul
)
if not defined HT_REMOTE_VER (echo  %DG%  Version check unavailable.%R% & goto :EOF)
:: Strip any trailing whitespace/CR from set /p read
for /f "tokens=*" %%V in ("!HT_REMOTE_VER!") do set "HT_REMOTE_VER=%%V"
if "!HT_REMOTE_VER!"=="!HT_VERSION!" (echo  %GN%  HOME TOOLS v!HT_VERSION! is up to date.%R% & goto :EOF)
:: Compare - only update if remote is strictly newer
set "HT_DO_UPDATE=0"
powershell -NoProfile -Command "$ProgressPreference='SilentlyContinue'; try { if([version]'!HT_REMOTE_VER!' -gt [version]'!HT_VERSION!'){ [System.IO.File]::WriteAllText($env:TEMP+'\ht_cmp_tmp.txt','1') } else { [System.IO.File]::WriteAllText($env:TEMP+'\ht_cmp_tmp.txt','0') } } catch { [System.IO.File]::WriteAllText($env:TEMP+'\ht_cmp_tmp.txt','0') }" >nul 2>nul
if exist "%TEMP%\ht_cmp_tmp.txt" (
  set /p HT_DO_UPDATE= < "%TEMP%\ht_cmp_tmp.txt"
  del "%TEMP%\ht_cmp_tmp.txt" >nul 2>nul
)
if not "!HT_DO_UPDATE!"=="1" (echo  %GN%  HOME TOOLS v!HT_VERSION! is up to date.%R% & goto :EOF)
echo.
echo  %YB%  =======================================================%R%
echo  %CB%      HOME TOOLS UPDATE AVAILABLE%R%
echo  %WH%      Current:  %RD%v!HT_VERSION!%R%
echo  %WH%      New:      %GN%v!HT_REMOTE_VER!%R%
echo  %YB%  =======================================================%R%
echo.
echo  %WH%  Downloading v!HT_REMOTE_VER!...%R%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; try { Invoke-WebRequest 'https://raw.githubusercontent.com/VortexDQ/HomeTools/main/HomeTools.bat' -OutFile '%TEMP%\HT_update.bat' -UseBasicParsing -TimeoutSec 30 } catch {}" >nul 2>nul
if not exist "%TEMP%\HT_update.bat" (
  echo  %RD%  Download failed - continuing with current version.%R%
  timeout /t 2 /nobreak >nul
  goto :EOF
)
set "HT_SELF=%~f0"
(
  echo @echo off
  echo timeout /t 2 /nobreak ^>nul
  echo copy /y "%TEMP%\HT_update.bat" "!HT_SELF!" ^>nul 2^>^&1
  echo del "%TEMP%\HT_update.bat" ^>nul 2^>^&1
  echo start "" "!HT_SELF!"
  echo del "%%~f0"
) > "%TEMP%\HT_runner.bat"
echo  %GN%  Update downloaded - restarting with v!HT_REMOTE_VER!...%R%
timeout /t 2 /nobreak >nul
start "" "%TEMP%\HT_runner.bat"
exit 0

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
echo  %WH%    Applying Python 3 compatibility patch...%R%
call :FIX_LINKEDIN
echo  %GN%    LinkedIn Gatherer installed and patched for Python 3.%R%
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
:: ============================================================
::  SELF-FIX: LinkedIn Gatherer Python 2 -> 3 compatibility
::  Patches raw_input() -> input() in all .py files
:: ============================================================
:FIX_LINKEDIN
if not exist "%P_LINK%\linkedin_gatherer.py" goto :EOF
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem 'C:\OSINT\linkedin-gatherer\*.py' | ForEach-Object { $c=Get-Content $_.FullName -Raw; if($c -match 'raw_input\s*\('){ $c=$c -replace 'raw_input\s*\(','input('; Set-Content $_.FullName $c -Encoding UTF8; Write-Host ('    Patched Python 3 fix in: '+$_.Name) -ForegroundColor Green } }" 2>nul
goto :EOF

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


:INSTALL_GHNT_FUNC
if exist "%P_GHNT%\ghunt" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning GHunt...%R%
git clone https://github.com/mxrch/GHunt "%P_GHNT%"
if not exist "%P_GHNT%\ghunt" (echo  %RD%    Clone failed.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_GHNT%\venv"
"%P_GHNT%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_GHNT%\venv\Scripts\python.exe" -m pip install -r "%P_GHNT%\requirements.txt" --quiet --prefer-binary 2>nul
"%P_GHNT%\venv\Scripts\python.exe" -m pip install -e "%P_GHNT%" --quiet 2>nul
copy nul "%P_GHNT%\venv\.health" >nul 2>&1
echo  %GN%    GHunt installed.%R%
echo  %YW%    First use: launch tool 15 and run  ghunt login  to authenticate.%R%
goto :EOF

:INSTALL_RECN_FUNC
if exist "%P_RECN%\recon-ng" (echo  %GN%    Already installed.%R% & goto :EOF)
echo  %WH%    Cloning Recon-ng...%R%
git clone https://github.com/lanmaster53/recon-ng "%P_RECN%"
if not exist "%P_RECN%\recon-ng" (echo  %RD%    Clone failed.%R% & goto :EOF)
echo  %WH%    Creating venv and installing requirements...%R%
python -m venv "%P_RECN%\venv"
"%P_RECN%\venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
"%P_RECN%\venv\Scripts\python.exe" -m pip install -r "%P_RECN%\REQUIREMENTS" --quiet --prefer-binary 2>nul
copy nul "%P_RECN%\venv\.health" >nul 2>&1
echo  %GN%    Recon-ng installed.%R%
goto :EOF

:INSTALL_ZAP_FUNC
if exist "%P_ZAP%\zap.bat" (echo  %GN%    Already installed.%R% & goto :EOF)
if not exist "%P_ZAP%" mkdir "%P_ZAP%"
echo  %WH%    Downloading OWASP ZAP (cross-platform package)...%R%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; try { $api=(Invoke-WebRequest 'https://api.github.com/repos/zaproxy/zaproxy/releases/latest' -UseBasicParsing -TimeoutSec 15).Content | ConvertFrom-Json; $asset=$api.assets | Where-Object{$_.name -match 'Crossplatform\.zip'} | Select-Object -First 1; if(-not $asset){$asset=$api.assets | Where-Object{$_.name -match '\.zip'} | Select-Object -First 1}; if($asset){Write-Host('    Downloading '+$asset.name+'...'); Invoke-WebRequest $asset.browser_download_url -OutFile 'C:\Tools\ZAP\zap.zip' -UseBasicParsing -TimeoutSec 180; Expand-Archive 'C:\Tools\ZAP\zap.zip' 'C:\Tools\ZAP' -Force; Remove-Item 'C:\Tools\ZAP\zap.zip' -Force -EA SilentlyContinue; $bat=Get-ChildItem 'C:\Tools\ZAP' -Recurse -Filter 'zap.bat' -EA SilentlyContinue | Select-Object -First 1; if($bat -and $bat.FullName -ne 'C:\Tools\ZAP\zap.bat'){Copy-Item $bat.FullName 'C:\Tools\ZAP\zap.bat' -Force}; Write-Host '    OWASP ZAP installed.' -ForegroundColor Green}else{Write-Host '    Could not find ZAP download asset.' -ForegroundColor Red}}catch{Write-Host('    Download failed: '+$_.Exception.Message) -ForegroundColor Red}"
goto :EOF

:INSTALL_WPSC_FUNC
where ruby >nul 2>&1 || (echo  %YW%    Ruby not in PATH - get it at: https://rubyinstaller.org%R% & goto :EOF)
echo  %WH%    Installing WPScan via gem (may take 1-2 min)...%R%
gem install wpscan --no-document 2>nul
where wpscan >nul 2>&1 && echo  %GN%    WPScan installed.%R% || echo  %RD%    gem install failed.%R%
goto :EOF


:: ============================================================
::  SAFETY NET - should never reach here
:: ============================================================
echo.
echo  %YW%  Unexpected exit - restarting...%R%
timeout /t 2 /nobreak >nul
goto STARTUP
