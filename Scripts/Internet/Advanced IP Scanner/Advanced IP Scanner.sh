#!/usr/bin/env PlayOnLinux-Bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: Dadu042, GuerreroAzul
License: Retail
 
CHANGELOG
[GuerrreroAzul] (2024-04-16 14:05 GMT-6) Wine 9.0 x32 / Linux Mint 21.3 x86_64
  Update wine -> 5.0 - 9.0
[Dadu042] (2020-03-30 10:40)
  Fix SHORTCUT_FILENAME
[Dadu042] (2020-03-11 10:40)
  First script. 
 
KNOWN ISSUES
  Wine amd64 5.0, 4.21 :err:winediag:IcmpCreateFile Failed to use ICMP (network ping). Im not sure if its a real problem. Look at https://forum.winehq.org/viewtopic.php?t=31134
KNOWN ISSUES (FIXED):
  Wine amd64 3.0.3: X
 
REFERENCE
GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/app-3972-Advanced_IP_Scanner.html
GuerreroAzul: Link Download. - https://www.advanced-ip-scanner.com/
'
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Setting
TITLE="Advanced IP Scanner"
PREFIX="ipscanner"
CATEGORY="Network;"
WINEVERSION="9.0"
OSVERSION="win7"
EDITHOR="Dadu042, GuerreroAzul"
COMPANY="Famatech Corp"
HOMEPAGE="https://www.advanced-ip-scanner.com/"
LOGO="https://i.imgur.com/qcR42fn.png"
BANNER="https://i.imgur.com/Di6W76j.png"
DOWNLOAD_URL="https://download.advanced-ip-scanner.com/download/files/Advanced_IP_Scanner_2.5.4594.1.exe"
FILE_INSTALL="Advanced_IP_Scanner_2.5.4594.1.exe"
MD5_CHECKSUM="5537c708edb9a2c21f88e34e8a0f1744"
 
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
 
#Dependencies
# Dll Obtained from the site DLL-FILES.COM
POL_Download_Resource "https://archive.org/download/mgmtapi/mgmtapi.dll" "b313d4fbc1a01fe70f1617dda3819315" "mgmtapi"
POL_Download_Resource "https://archive.org/download/wsnmp32/wsnmp32.dll" "96f29d1d0bf1a5ededdf67025774828c" "wsnmp32"
POL_Download_Resource "https://archive.org/download/snmpapi/snmpapi.dll" "ddfff308496e2db5e3997b69b16202e9" "snmpapi"
cp "$POL_USER_ROOT/ressources/mgmtapi/mgmtapi.dll" -d "$WINEPREFIX/drive_c/windows/system32/"
cp "$POL_USER_ROOT/ressources/wsnmp32/wsnmp32.dll" -d "$WINEPREFIX/drive_c/windows/system32/"
cp "$POL_USER_ROOT/ressources/snmpapi/snmpapi.dll" -d "$WINEPREFIX/drive_c/windows/system32/"
 
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
POL_Wine start /unix "$INSTALLER" /S
POL_Wine_WaitExit "$INSTALLER" /S
 
# Shortcut
POL_Shortcut "advanced_ip_scanner.exe" "$TITLE" "" "" "$CATEGORY"
 
# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
