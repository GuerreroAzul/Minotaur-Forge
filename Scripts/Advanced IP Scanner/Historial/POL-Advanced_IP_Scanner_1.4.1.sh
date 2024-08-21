#!/usr/bin/env playonLinux-bash

# Wine version used: See changelog.
# Distribution used to test: See changelog.
# Author: Dadu042
# Contributor: GuerrreroAzul
# License: GNU General Public License v3.0 
 
# CHANGELOG
# [GuerreroAzul] 2024-08-19 13-20 (UTC -06-00)
#   Script version: 1.4.1
#   Update software version: 2.5.3850 -> 2.5.4594.1
#   Update system version: win7 -> win11
# [GuerrreroAzul] (2024-04-16 14:05 GMT-6) Wine 9.0 x32 / Linux Mint 21.3 x86_64
#   Update wine -> 5.0 - 9.0
#   REFERENCE:
#     GuerreroAzul: Documentation POL. - https://www.playonlinux.com/en/app-3972-Advanced_IP_Scanner.html
#     GuerreroAzul: Link Download. - https://www.advanced-ip-scanner.com/
# [Dadu042] (2020-03-30 10:40)
#   Fix SHORTCUT_FILENAME
# [Dadu042] (2020-03-11 10:40)
#   First script. 
#   KNOWN ISSUES
#     Wine amd64 5.0, 4.21 :err:winediag:IcmpCreateFile Failed to use ICMP (network ping). Im not sure if its a real problem. Look at https://forum.winehq.org/viewtopic.php?t=31134
#   KNOWN ISSUES (FIXED):
#     Wine amd64 3.0.3: X

# Start script
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Declaration of variables
Title="Advanced IP Scanner"
Prefix="AdvancedIPScanner"
Category="Network;"
WineVersion="9.0"
SystemVersion="win11"
Edithor="Dadu042 \n GuerreroAzul"
Company="Famatech Corp."
OfficialSite="https://www.advanced-ip-scanner.com/"
Logo="https://i.imgur.com/filSA0h.png"
Banner="https://i.imgur.com/ba7r3Zz.png"
DownloadSoftware="https://download.advanced-ip-scanner.com/download/files/Advanced_IP_Scanner_2.5.4594.1.exe 5537c708edb9a2c21f88e34e8a0f1744"
FileSetup="advanced_ip_scanner.exe"

# Setup Image
POL_GetSetupImages "$Logo" "$Banner" "$Title"
 
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
# Welcome message
POL_SetupWindow_presentation "$Title" "$Company" "$OfficialSite" "$Edithor" "$Prefix"
 
# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"
 
# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$Title!"
fi
 
# Prepare resources for installation!
POL_Wine_SelectPrefix "$Prefix"
POL_Wine_PrefixCreate "$WineVersion"
Set_OS "$SystemVersion"
 
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
  POL_System_TmpCreate "$Prefix"
  cd "$POL_System_TmpDir"

  DownloadLink=$(echo ${DownloadSoftware} | cut -d" " -f1)
  FingerPrint=$(echo ${DownloadSoftware} | cut -d" " -f2)
  FileSoftware=${DownloadLink##*/}
  
  POL_Download "$DownloadLink" "$FingerPrint"
  Installer="$POL_System_TmpDir/$FileSoftware"
else
  cd "$HOME"
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  Installer="$APP_ANSWER"
  FileSoftware=$(echo "$Installer" | rev | cut -d'/' -f1 | rev)
fi
 
# Install Program
POL_Wine start /unix "$Installer" /SILENT /CLOSEAPPLICATIONS /NOICONS
POL_Wine_WaitExit "$Installer"
 
# Shortcut
POL_Shortcut "$FileSetup" "$Title" "" "" "$Category"
 
# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
