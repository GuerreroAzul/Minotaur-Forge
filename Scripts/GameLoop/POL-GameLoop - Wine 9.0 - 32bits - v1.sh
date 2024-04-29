#!/usr/bin/env playonLinux-bash

# Date: See changelog.
# Last revision: See changelog.
# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: GuerreroAzul
# License: GNU General Public License v3.0 

# CHANGELOG
# [GuerrreroAzul] 2024-04-27 16:03 (UTC -06:00) / Wine 8.1-staging x86 / Linux Mint 21.3 x86_64
# Script creation:
#   Wine version: 8.1-staging
#   System version: Windows 10
#   Architecture: 64bits
# Reference
#  Link Reference: https://wiki.playonlinux.com/index.php/Main_Page
#  Link download: https://www.gameloop.com/product/gameloop-download

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="GameLoop"
PREFIX="gameloop"
CATEGORY="Games;"
WINEVERSION="9.0"
OSVERSION="win10"
EDITHOR="GuerreroAzul"
COMPANY="Hong Kong Gathering Media Limited"
HOMEPAGE="https://www.gameloop.com/"
LOGO="https://i.imgur.com/bszmPOY.png"
BANNER="https://i.imgur.com/Di6W76j.png"
DOWNLOAD_URL="https://down.gameloop.com/channel/3/16412/GLP_installer_1000218456_market.exe"
FILE_INSTALL="GLP_installer_1000218456_market.exe"
MD5_CHECKSUM="ef61ca12b115d390a2971608cf462a83"

#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init

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
POL_Call POL_Install_dotnet40

# [GuerreroAzul] dll's Obtained from the site DLL-FILES.COM
# [GuerreroAzul] Fix error: "fixme:msctf:TextStoreACPSink" (MS Text Service Module)
POL_Download_Resource "https://archive.org/download/msctf/msctf.dll" "945b2f6a542a30a7032b0d0ae3f62b57" "msctf"
cp "$POL_USER_ROOT/ressources/msctf/msctf.dll" -d "$WINEPREFIX/drive_c/windows/system32/"

# [GuerreroAzul] Fix error: "fixme:dwmapi:DwmEnableBlurBehindWindow" (Blur behind windows)
POL_Download_Resource "https://archive.org/download/dwmapi/dwmapi.dll" "7a48cca25ef5aa3f537af4c3edce1902" "dwmapi"
cp "$POL_USER_ROOT/ressources/dwmapi/dwmapi.dll" -d "$WINEPREFIX/drive_c/windows/system32/"

# [GuerreroAzul] Fix error "fixme:ntdll:NtQuerySystemInformation" (Information about system performance)
POL_Download_Resource "https://archive.org/download/ntdll/ntdll.dll" "ba43e77a5b6c451360dcac576a386f20" "ntdll"
cp "$POL_USER_ROOT/ressources/ntdll/ntdll.dll" -d "$WINEPREFIX/drive_c/windows/system32/"

# [GuerreroAzul] Fix error"fixme:richedit:fnTextSrv_OnTxSetCursor" (Show rich text)
POL_Call POL_Install_riched20
POL_Wine_OverrideDLL "native,builtin" "riched20"

# [GuerreroAzul] Fix error: "fixme:cryptasn:CryptDecodeObjectEx"
#POL_Call POL_Install_donet40
POL_Call POL_Install_gdiplus
POL_Call POL_Install_msxml6
POL_Call POL_Install_msls31
POL_Wine_OverrideDLL "native,builtin" "msxml6"
POL_Wine_OverrideDLL "native,builtin" "msls31"

# Bugs pending solution
# [GuerreroAzul] "fixme:system:EnableNonClientDpiScaling" (DPI scaling)
# [GuerreroAzul] "fixme:wtsapi:WTSUnRegisterSessionNotification" (Terminal Service (WTS))
# [GuerreroAzul] "fixme:userenv:UnregisterGPNotification" (Group policy notifications in Windows environment)


# Script start
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  POL_System_TmpCreate "$PREFIX"
  cd "$POL_System_TmpDir"

  POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"
  INSTALLER="$POL_System_TmpDir/$FILE_INSTALL"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  INSTALLER="$APP_ANSWER"
fi

# Install Program
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$TITLE"

# Shortcut
POL_Shortcut "AppMarket.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0