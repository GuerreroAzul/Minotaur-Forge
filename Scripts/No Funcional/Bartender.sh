#!/usr/bin/env PlayOnLinux-Bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Dadu042
# License: Retail
 
# CHANGELOG
# [GuerrreroAzul] (2025-06-10 08-55 GMT-6) / Linux Mint 22.1 x86_64
#   [Setting initial]:
#     + Wine version 9.0
#     + System version: Windows 7
#     + Category: Other
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Setting
TITLE="Bartender"
PREFIX="Bartend"
CATEGORY="Other;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="GuerreroAzul"
COMPANY="Seagull Scientific"
HOMEPAGE="https://www.seagullscientific.com/es/software/"
LOGO="https://i.imgur.com/pW7zb7Z.png"
BANNER="https://i.imgur.com/Di6W76j.png"

# Download Images
mkdir "$POL_USER_ROOT/configurations/setups/$TITLE"
wget --header="User-Agent: Mozilla/5.0" -qO- "$LOGO" | convert - -resize 64x64! "$POL_USER_ROOT/configurations/setups/$TITLE/top"
wget --header="User-Agent: Mozilla/5.0" -qO- "$BANNER" | convert - -resize 150x356! "$POL_USER_ROOT/configurations/setups/$TITLE/left"

#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"
 
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
# Welcome message
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$HOMEPAGE" "$EDITHOR" "$PREFIX"
 
# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"
 
# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$TITLE!"
fi
 
# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"
 
# Dependencies

# Microsoft Data Access Components 2.8 SP1 (mdac28)
Set_OS nt40
POL_Download_Resource "https://archive.org/download/mdac28/MDAC_TYP.EXE" "6e914a7391c3b17380ce54fd3a7a133d" "mdac28"
POL_Wine_OverrideDLL "native, builtin" odbc32 odbccp32 oledb32 sqlsrv32
POL_Wine "$POL_USER_ROOT/ressources/mdac28/MDAC_TYP.EXE" /q /C:"setup /QNT"
POL_Wine_WaitExit "Microsoft Data Access Components 2.8 SP1"
Set_OS "$OSVersion"

# Microsoft .Net Framework 3.5 SP1
# POL_Call POL_Install_dotnet35
Set_OS "winxp"
POL_Download_Resource "https://download.microsoft.com/download/2/0/e/20e90413-712f-438c-988e-fdaa79a8ac3d/dotnetfx35.exe" "d481cda2625d9dd2731a00f482484d86" "dotnet35sp1"
POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet35sp1/dotnetfx35.exe" /q
POL_Wine_WaitExit "Microsoft .Net Framework 3.5 SP1"
Set_OS "$OSVersion"

# Microsoft .Net Framework 4.0
POL_Download_Resource "https://download.microsoft.com/download/9/5/a/95a9616b-7a37-4af6-bc36-d6ea96c8daae/dotNetFx40_Full_x86_x64.exe" "251743dfd3fda414570524bac9e55381" "dotnet40"
POL_Wine start /unix "$POL_USER_ROOT/ressources/dotnet40/dotNetFx40_Full_x86_x64.exe" /q
POL_Wine_WaitExit "Microsoft .Net Framework 4.0"

# Microsoft Windows Script Host 5.7 (wsh57)
POL_Download_Resource "https://download.microsoft.com/download/4/4/d/44de8a9e-630d-4c10-9f17-b9b34d3f6417/scripten.exe" "65a8ebf870420316a939ac44fd4c731d" "wsh57"
cabextract -d "$WINEPREFIX/drive_c/windows/system32" "$POL_USER_ROOT/ressources/wsh57/scripten.exe"
POL_Wine_WaitExit "Microsoft Windows Script Host 5.7"
POL_Wine_OverrideDLL "native, builtin" jscript scrrun vbscript cscript.exe wscript.exe
POL_Wine regsvr32 /s dispex.dll jscript.dll scrobj.dll scrrun.dll vbscript.dll wshcon.dll wshext.dll

# Microsoft Jet 4.0 Service Pack 8 (jet40)
POL_Download_Resource "https://archive.org/download/jet40/Jet40SP8_9xNT.exe" "d1028c0f98b4ffe5ede854327b77fbb9" "jet40"
POL_Wine "$POL_USER_ROOT/ressources/jet40/Jet40SP8_9xNT.exe" /Q
POL_Wine_WaitExit "Microsoft Jet 4.0 Service Pack 8"

# Microsoft GDI+ (gdiplus)
POL_Download_Resource "https://archive.org/download/windows-xp-kb-975337-x-86-enu/WindowsXP-KB975337-x86-ENU.exe" "946d00d87e4094f3a6e425e2d538eadd" "gdiplus"
POL_Wine "$POL_USER_ROOT/ressources/gdiplus/WindowsXP-KB975337-x86-ENU.exe" /extract:C:\\Tmp /q
POL_Wine_WaitExit "Microsoft GDI+"
if [ "$POL_ARCH" == "amd64" ]; then
  mv "$WINEPREFIX/drive_c/Tmp/asms/10/msft/windows/gdiplus/gdiplus.dll" "$WINEPREFIX/drive_c/windows/syswow64"
else
  mv "$WINEPREFIX/drive_c/Tmp/asms/10/msft/windows/gdiplus/gdiplus.dll" "$WINEPREFIX/drive_c/windows/system32"
fi
POL_Wine_OverrideDLL "native, builtin" gdiplus

# Registry
cd "$POL_System_TmpDir"
echo -e 'REGEDIT4
 
[HKEY_CURRENT_USER\Control Panel\International]
"Locale"="00000409"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language]
"InstallLanguage"="0409"
"Default"="0409"' > ConfigRegion.reg  
POL_Wine regedit ConfigRegion.reg
 
# Microsoft Visual C++ 2008 MFC
Set_OS "$OSVERSION"
POL_Download_Resource "https://archive.org/download/DLL-POL/Microsoft%20Visual%20C%2B%2B%202008%20MFC/x86/vcredist_x86_vc9sp1.exe" "5689d43c3b201dd3810fa3bba4a6476a" "vcrun2008sfc"
POL_Wine start /unix "$POL_USER_ROOT/ressources/vcrun2008sfc/vcredist_x86_vc9sp1.exe" /q
POL_Wine_WaitExit "Microsoft Visual C++ 2008 MFC"
 
# Dll Obtained from the site DLL-FILES.COM
POL_Download_Resource "https://archive.org/download/mscorwks32/mscorwks.dll" "8afa8b582babf0b563e83362dec4cca3" "mscorwks32"
cp "$POL_USER_ROOT/ressources/mscorwks32/mscorwks.dll" -d "$WINEPREFIX/drive_c/windows/system32/"
 
# Installing DLL Libraries
POL_Wine_OverrideDLL "native, builtin" "mscoree"
 
POL_Call POL_Install_msxml3
POL_Wine_OverrideDLL "native, builtin" "msxml3"
 
POL_Call POL_Install_msxml4
POL_Wine_OverrideDLL "native, builtin" "msxml4"
 
POL_Call POL_Install_msxml6
POL_Wine_OverrideDLL "native, builtin" "msxml6"

# Script start
Set_OS "$OSVERSION"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install Program
POL_Wine start /unix "$INSTALLER" /S
POL_Wine_WaitExit "$TITLE"

# Patch
POL_SetupWindow_browse "$(eval_gettext 'Please select the patch')" "$TITLE"
PATCH="$APP_ANSWER"
cp -f "$PATCH" "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/Program Files/Seagull/BarTender 2022"

# Shortcut
POL_Shortcut "bartend.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0